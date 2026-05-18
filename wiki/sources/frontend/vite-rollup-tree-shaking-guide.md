---
description: "Vite and Rollup tree shaking configuration guide"
tags: ["source", "vite", "rollup", "tree-shaking", "bundle-optimization", "monorepo"]
sources: ["vite-rollup-tree-shaking-guide.md", "Vite Rollup tree-shaking.md"]
created: 2026-04-09
updated: 2026-04-15
---

# Vite Tree-Shaking: React Monorepo Guide

**Source:** raw/02_reference/approaches/vite-rollup-tree-shaking-guide.md
**Date ingested:** 2026-04-09
**Type:** Build optimization guide

## Summary

Complete guide to Vite/Rollup tree-shaking for React monorepos — setup, configuration, bundle analysis, metrics, and strategies to reduce bundle size by 60%+.

## Key Claims

- Single-file bundles prevent tree-shaking — need multi-file output
- `preserveModules: true` is critical for monorepo tree-shaking
- ES modules + named exports required for tree-shaking
- `sideEffects: false` tells bundler files are pure

## Real Results

| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| First load | 184kb | 124kb | 32% |
| Server code | 62.4kb | 12.6kb | 80% |
| Client code | 37kb | 10kb | 73% |

## Prerequisites for Tree-Shaking

1. **ES Module Format** — `"type": "module"` in package.json
2. **Named Exports Only** — No default exports
3. **Proper package.json** — `sideEffects: false`, `exports` field

## Vite Config: Multi-File Build

```typescript
// vite.config.ts
export default defineConfig({
  build: {
    lib: {
      entry: resolve(__dirname, 'src/index.ts'),
      formats: ['es', 'cjs'],
    },
    rollupOptions: {
      external: ['react', 'react-dom'],
      output: {
        preserveModules: true, // CRITICAL!
      }
    }
  }
});
```

## Why `preserveModules: true` Matters

- **Without:** All code → `dist/index.js` (single file, not tree-shakeable)
- **With:** Each source file → separate file in `dist/` (tree-shakeable)

## Bundle Analysis

```typescript
// vite.config.ts
import {visualizer} from 'rollup-plugin-visualizer';

export default defineConfig({
  plugins: [
    visualizer({
      open: true,
      gzipSize: true,
      filename: 'stats.html',
    })
  ]
});
```

## Common Pitfalls

### 1. Barrel Files (index.ts)
```typescript
// ❌ Entire barrel gets bundled
export {Button} from './Button';
export {Input} from './Input';

// ✅ Import directly
import {Button} from './components/Button';
```

### 2. CommonJS Dependencies
```bash
# Replace with ES module versions
npm uninstall lodash
npm install lodash-es
```

### 3. Side Effects
```typescript
// ❌ Not tree-shakeable
polyfillLibrary();
export function myComponent() {}

// ✅ Pure exports
export function myComponent() {}
```

## Manual Chunks

Split vendor code into separate files:

```typescript
build: {
  rollupOptions: {
    output: {
      manualChunks: {
        vendor: ['react', 'react-dom'],
        ui: ['@monorepo/ui']
      }
    }
  }
}
```

## Vite 4.4.1 Tree-Shaking Support

**Yes**, Vite 4.4.1 supports full tree-shaking via Rollup 3.x/4.x. No special configuration needed — it works by default when your code follows ES module conventions:
- ES Module syntax (import/export)
- Named exports (not default exports)
- Dependencies marked with `sideEffects: false` in package.json

## Monorepo Configuration

### Library package.json
```json
{
  "name": "@monorepo/ui",
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

## Verification Commands

```bash
# Check bundle sizes
npm run build
du -sh dist/assets/*.js | sort -h

# Check if tree-shaking works
grep -r "unusedFunction" dist/assets/*.js
# If found: tree-shaking FAILED
```

## Quick Start Checklist

- [ ] `"type": "module"` in package.json
- [ ] `sideEffects: false` set correctly
- [ ] Only named exports (no default)
- [ ] `preserveModules: true` in Rollup config
- [ ] `exports` field in package.json
- [ ] Install rollup-plugin-visualizer
- [ ] Test with selective imports

## Entities Mentioned

- [[Vite]] — Build tool
- [[Rollup]] — Bundler
- [[react-patterns]] — UI library

## Concepts Covered

- [[tree-shaking]] — Eliminating dead code
- [[bundle-optimization]] — Reducing bundle size
- [[monorepo-build]] — Multi-package build setup
- [[preserve-modules]] — Keeping module structure
- [[side-effects]] — Pure vs impure modules
