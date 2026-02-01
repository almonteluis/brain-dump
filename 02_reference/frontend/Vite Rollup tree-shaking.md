---
description: Quick reference for Vite/Rollup tree-shaking setup with bundle analysis — visualization, configuration examples, and before/after metrics.
tags: ["vite", "rollup", "tree-shaking", "bundle-analysis", "react"]
created: 2026-01-31
---

# Vite Rollup Tree-Shaking Quick Reference

## Setup: rollup-plugin-visualizer

```bash
npm install -D rollup-plugin-visualizer
```

**vite.config.ts:**
```typescript
import { visualizer } from 'rollup-plugin-visualizer';

export default defineConfig({
  plugins: [
    visualizer({
      open: true,
      gzipSize: true,
      brotliSize: true
    })
  ]
});
```

## Generate Report

```bash
npm run build
# Opens stats.html automatically showing bundle treemap
```

## Key Configuration

### preserveModules (Critical)

```typescript
build: {
  rollupOptions: {
    output: {
      preserveModules: true // Keeps module structure for better tree-shaking
    }
  }
}
```

### Manual Chunks

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

## Metrics Template

| Metric | Before | After |
|--------|--------|-------|
| Bundle size (gzipped) | _ kb | _ kb |
| Initial load | _ ms | _ ms |
| Build time | _ s | _ s |

---

## Q&A

### Can Vite 4.4.1 do tree-shaking?

**Yes.** Vite 4.4.1 uses Rollup under the hood, which has built-in tree-shaking support. Tree-shaking works automatically for:
- ES Module syntax (import/export)
- Named exports (not default exports)
- Dependencies marked with `sideEffects: false` in package.json
- Proper package.json configuration

Vite 4.x series (including 4.4.1) supports full tree-shaking via Rollup 3.x/4.x. No special configuration needed — it works by default when your code follows ES module conventions.

---

## Related

[[vite-rollup-tree-shaking-guide]]
[[Vite 4.4.1 to 7.x Upgrade Gameplan]]
