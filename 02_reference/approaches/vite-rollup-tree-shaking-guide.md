---
description: Complete guide to Vite/Rollup tree-shaking for React monorepos — setup, configuration, bundle analysis, metrics, and proven strategies to reduce bundle size by 60%+.
tags: ["vite", "rollup", "tree-shaking", "react", "monorepo", "bundle-optimization", "performance"]
created: 2026-01-31
source: https://github.com/btd/rollup-plugin-visualizer, https://dev.to/morewings/how-to-build-a-tree-shakable-library-with-vite-and-rollup-16cb
---

# Vite Tree-Shaking: The Complete React Monorepo Guide

## The Problem

You import two components from a 75kb library, but your entire bundle grows by 75kb. This is the tree-shaking failure that plagues React monorepos.

**The root cause:** Single-file bundles (`dist/index.js`) prevent consumer bundlers from tree-shaking. When you import `ComponentA`, the entire library gets bundled because everything is compiled into one file.

## Why Tree-Shaking Matters

| Before | After | Improvement |
|--------|-------|-------------|
| First load: 184kb | First load: 124kb | **32% reduction** |
| Server code: 62.4kb | Server code: 12.6kb | **80% reduction** |
| Client code: 37kb | Client code: 10kb | **73% reduction** |

*Real results from switching single-file to multi-file bundle (75kb library)*

---

## Prerequisites for Tree-Shaking

### 1. ES Module Format

Your code and dependencies must use ES modules (`import`/`export`), not CommonJS (`require`):

**package.json:**
```json
{
  "type": "module"
}
```

**CommonJS dependencies break tree-shaking.** Check your dependencies:
```bash
# Find CommonJS dependencies in your project
npx why node_modules/react
npx esbuild-visualizer --metafile
```

### 2. Named Exports Only

Tree-shaking fails with default exports:

```typescript
// ❌ Default export - NOT tree-shakeable
export default function MyComponent() {}

// ✅ Named export - tree-shakeable
export function MyComponent() {}
```

Import named exports:
```typescript
// ❌ Importing default pulls everything
import MyComponent from './library'

// ✅ Named imports allow tree-shaking
import { MyComponent } from './library'
```

### 3. Proper package.json Configuration

```json
{
  "type": "module",
  "sideEffects": false,
  "exports": {
    ".": {
      "import": "./dist/index.js",
      "require": "./dist/index.cjs"
    }
  }
}
```

**Key settings:**
- `sideEffects: false` — Tells bundler "all files are pure, can be tree-shaken"
- `exports` — Modern entry points (prefer `module` over `main`)

---

## Monorepo Setup: Vite + Tree-Shaking

### The Challenge

Monorepos add complexity:
- Multiple apps sharing internal packages
- Each app needs to tree-shake shared packages
- Build tooling (Nx/Turborepo) must preserve ES modules

### Library Package Configuration

**packages/ui/package.json:**
```json
{
  "name": "@monorepo/ui",
  "type": "module",
  "sideEffects": false,
  "main": "./dist/index.cjs",
  "module": "./dist/index.js",
  "types": "./dist/index.d.ts",
  "exports": {
    ".": {
      "import": "./dist/index.js",
      "require": "./dist/index.cjs",
      "types": "./dist/index.d.ts"
    },
    "./components/*": "./dist/components/*.js"
  },
  "files": ["dist"]
}
```

### Vite Config: Multi-File Build

**packages/ui/vite.config.ts:**
```typescript
import { defineConfig } from 'vite';
import { resolve } from 'path';

export default defineConfig({
  build: {
    sourcemap: true,
    lib: {
      entry: resolve(__dirname, 'src/index.ts'),
      fileName: (format, entryName) => {
        // Main entry gets simple name
        if (entryName === resolve(__dirname, 'src/index')) {
          return `index.${format === 'es' ? 'js' : 'cjs'}`;
        }
        // Other files keep their path
        return `${entryName}.${format === 'es' ? 'js' : 'cjs'}`;
      },
      formats: ['es', 'cjs'], // No UMD — better for tree-shaking
    },
    rollupOptions: {
      external: ['react', 'react-dom', 'react/jsx-runtime'],
      output: {
        preserveModules: true, // CRITICAL: Keep module structure!
        globals: {
          react: 'React',
          'react-dom': 'ReactDOM',
          'react/jsx-runtime': '_jsx_runtime'
        }
      }
    }
  }
});
```

**Why `preserveModules: true` matters:**
- Without it: All code compiles to `dist/index.js` (single file)
- With it: Each source file becomes a separate file in dist/
- Result: Consumer bundlers can tree-shake at module granularity

### App Package Configuration

**apps/web/vite.config.ts:**
```typescript
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react-swc';

export default defineConfig({
  plugins: [react()],
  resolve: {
    // Enable workspace imports
    alias: {
      '@monorepo/ui': resolve(__dirname, '../../packages/ui/src')
    }
  },
  build: {
    rollupOptions: {
      output: {
        manualChunks: {
          // Vendor chunk for stable caching
          vendor: ['react', 'react-dom', 'react/jsx-runtime'],
          // Internal packages get their own chunks
          '@monorepo/ui': ['@monorepo/ui']
        }
      }
    }
  }
});
```

---

## Bundle Analysis: Measuring Before/After

### Setup rollup-plugin-visualizer

**Install:**
```bash
npm install -D rollup-plugin-visualizer
```

**vite.config.ts:**
```typescript
import { visualizer } from 'rollup-plugin-visualizer';

export default defineConfig({
  plugins: [
    // ... other plugins
    visualizer({
      open: true,
      gzipSize: true,
      brotliSize: true,
      filename: 'stats.html',
      template: 'treemap' // or 'sunburst', 'flamegraph', 'network'
    })
  ]
});
```

**Generate report:**
```bash
npm run build
# Opens stats.html automatically
```

### Alternative: vite-plugin-inspect

```bash
npm install -D vite-plugin-inspect
```

**vite.config.ts:**
```typescript
import { inspect } from 'vite-plugin-inspect';

export default defineConfig({
  plugins: [
    inspect(),
    // ... other plugins
  ]
});
```

Run with: `npm run build -- --mode inspect`

---

## Metrics to Track

### Before Optimization (Baseline)

| Metric | Command | Target |
|--------|---------|--------|
| Initial JS bundle | `ls -lh dist/assets/*.js` | < 200kb gzipped |
| First Load JS | `stats.html` | < 150kb |
| Number of chunks | Build output | 5-10 chunks |
| Build time | `time npm run build` | < 30s |

### Measurement Commands

```bash
# Bundle sizes
npm run build
du -sh dist/assets/*.js | sort -h

# Gzip size
gzip -c dist/assets/main-[hash].js | wc -c

# Using rollup-plugin-visualizer
# Look for "un-treeshaken modules" in stats.html
```

### Verification Commands

```bash
# 1. Check if tree-shaking works
# Build your app, then search for unused exports in bundle
grep -r "unusedFunction" dist/assets/*.js
# If found: tree-shaking FAILED

# 2. Test with selective imports
# Create test component that imports only one thing
import { Button } from '@monorepo/ui'
# Build: Should include only Button code

# 3. Compare builds
npm run build -- --mode production
# Check main.js size, then add more imports
# Size should increase proportionally, not jump by full library size
```

---

## Common Tree-Shaking Pitfalls

### 1. Barrel Files (index.ts)

**Problem:**
```typescript
// src/index.ts (barrel file)
export { Button } from './Button'
export { Input } from './Input'
export { Select } from './Select'

// ❌ Entire barrel gets bundled if any import occurs
import { Button } from './index'
```

**Solution — Direct imports:**
```typescript
// ✅ Import directly from source
import { Button } from './components/Button'
```

**If you must use barrels:**
```json
// package.json of library
{
  "sideEffects": [
    "./src/index.ts"
  ]
}
```

### 2. Side Effects

**Problem:** Code with top-level side effects can't be tree-shaken:
```typescript
// ❌ Not tree-shakeable
polyfill library()

export function myComponent() {}
```

**Solution:**
```typescript
// ✅ Pure exports
export function myComponent() {}

// Side effects in separate file
// polyfill-library.js
import './polyfill-library' // Explicitly import when needed
```

### 3. CommonJS Dependencies

```bash
# Check which deps are CommonJS
npx esbuild-visualizer --metafile

# If you see lodash instead of lodash-es:
npm uninstall lodash
npm install lodash-es
```

**Common replacements:**
- `lodash` → `lodash-es`
- `moment` → `date-fns` or `dayjs`
- `react-icons` → specific icon imports

### 4. Conditional Requires

```typescript
// ❌ Breaks tree-shaking
if (process.env.NODE_ENV === 'production') {
  const prodOnly = require('./prod-module')
}

// ✅ Dynamic import (code splitting)
const prodOnly = await import('./prod-module')
```

---

## Monorepo-Specific Considerations

### Nx Configuration

**nx.json:**
```json
{
  "namedInputs": {
    "default": ["{projectRoot}/**/*", "sharedGlobals"]
  },
  "targetDefaults": {
    "build": {
      "cache": true,
      "dependsOn": ["^build"]
    }
  }
}
```

**projects.json (library package):**
```json
{
  "library-name": {
    "root": "packages/ui",
    "sourceRoot": "packages/ui/src",
    "projectType": "library",
    "targets": {
      "build": {
        "executor": "@nx/vite:build",
        "options": {
          "configFile": "packages/ui/vite.config.ts"
        }
      }
    }
  }
}
```

### Turborepo Configuration

**turbo.json:**
```json
{
  "pipeline": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": ["dist/**", ".next/**"]
    }
  }
}
```

### Internal Package Resolution

**apps/web/tsconfig.json:**
```json
{
  "compilerOptions": {
    "paths": {
      "@monorepo/ui": ["../../packages/ui/src"],
      "@monorepo/ui/*": ["../../packages/ui/src/*"]
    }
  }
}
```

---

## Quick Start Checklist

### For New Libraries

- [ ] `package.json` has `"type": "module"`
- [ ] `sideEffects: false` set correctly
- [ ] Only named exports (no `export default`)
- [ ] `preserveModules: true` in Rollup config
- [ ] `exports` field in package.json
- [ ] Install rollup-plugin-visualizer
- [ ] Test with selective imports
- [ ] Verify stats.html shows module granularity

### For Existing Monorepos

- [ ] Audit all packages for CommonJS deps
- [ ] Replace with ES module equivalents
- [ ] Add bundle analyzer to each app
- [ ] Measure baseline bundle sizes
- [ ] Enable `preserveModules` for shared packages
- [ ] Rebuild and compare
- [ ] Document before/after metrics

---

## React-Specific Tree-Shaking

### React Fast Refresh + SWC

```typescript
// vite.config.ts
import react from '@vitejs/plugin-react-swc';

export default defineConfig({
  plugins: [react()]
});
```

SWC is faster than Babel and maintains better tree-shaking.

### Component Lazy Loading

```typescript
import { lazy, Suspense } from 'react';

const HeavyDashboard = lazy(() => import('./HeavyDashboard'));

function App() {
  return (
    <Suspense fallback={<Loading />}>
      <HeavyDashboard />
    </Suspense>
  );
}
```

### Route-Based Splitting

```typescript
// React Router v6+
import { lazy } from 'react';

const Home = lazy(() => import('./routes/Home'));
const Admin = lazy(() => import('./routes/Admin'));

// Routes only loaded when needed
```

---

## Success Metrics

Use these to justify the tree-shaking work to stakeholders:

| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| Time to Interactive (TTI) | _ms | _ms | _% |
| First Contentful Paint (FCP) | _ms | _ms | _% |
| Total Bundle Size | _kb | _kb | _% |
| Initial JS Payload | _kb | _kb | _% |
| Lighthouse Score | _/100 | _/100 | _ points |

**Business case:**
- 32% smaller bundles = 32% faster load on slow connections
- 80% less server code = faster serverless cold starts
- Better SEO (Core Web Vitals)
- Lower bandwidth costs

---

## Related

[[Bundle optimization]]
[[Code splitting]]
[[Performance Optimization]]
[[Vite Rollup tree-shaking]]
[[Frontend Engineering Mastery Roadmap]]
