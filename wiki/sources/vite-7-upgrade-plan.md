---
description: Step-by-step guide for upgrading Vite from v4 to v7 with package updates and breaking changes
tags: [source, vite, upgrade, build-tools, frontend, migration]
sources: ["Frontend Vite 7 Upgrade Plan.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Vite 7 Upgrade Guide

**Source:** `raw/00_inbox/process/Frontend Vite 7 Upgrade Plan.md`
**Date ingested:** 2026-04-09
**Type:** Migration guide

## Summary

Focused upgrade plan for Vite v4.4.5 to v7.x with associated plugin updates. Preserves lockfile to avoid cascading dependency updates.

## Package Updates

| Package | From | To | Notes |
|---------|------|----|-------|
| vite | 4.4.5 | 7.1.6 | Main upgrade |
| vitest | 0.34.6 | 3.2.4 | Must support Vite 7 |
| @vitejs/plugin-react | 4.0.3 | 5.1.4 | Vite 7 compatible |
| vite-plugin-svgr | 4.2.0 | 4.5.0 | Minor update |
| vite-plugin-node-polyfills | 0.19.0 | 0.25.0 | Minor update |
| vite-plugin-relay | 2.0.0 | 2.1.0 | Minor update |
| rollup-plugin-visualizer | 5.9.2 | 5.14.0 | Minor update |

## Critical Breaking Change: splitVendorChunkPlugin

**Vite 7 removed `splitVendorChunkPlugin()`**

If your config already has a `manualChunks` function handling vendor splitting, simply remove the deprecated plugin import and usage.

```diff
- import { loadEnv, splitVendorChunkPlugin } from 'vite';
+ import { loadEnv } from 'vite';

  plugins: [
    relay,
    react(),
    svgr(),
-   splitVendorChunkPlugin(),
    visualizer(),
    nodePolyfills(),
  ],
```

## Execution Steps

1. **Create branch:**
   ```bash
   git checkout -b upgrade/vite-7
   ```

2. **Update packages (targeted):**
   ```bash
   cd frontend
   npm install vite@^7.1.6 vitest@^3.2.4 @vitejs/plugin-react@^5.1.4 vite-plugin-svgr@^4.5.0 vite-plugin-node-polyfills@^0.25.0 vite-plugin-relay@^2.1.0 rollup-plugin-visualizer@^5.14.0 --save-dev
   ```

3. **Update vite.config.ts:** Remove `splitVendorChunkPlugin`

4. **Verify:**
   ```bash
   npm run build  # Should complete
   npm test       # All tests pass
   npm run dev    # Starts without errors
   ```

## Why Targeted Install (Not Delete Lockfile)

- Deleting `package-lock.json` forces npm to recalculate entire dependency tree
- Updates ALL packages to latest within semver ranges
- Causes cascading unrelated updates
- Targeted install only updates specified packages + necessary transitive deps

## Key Concepts

- [[vite-upgrade]] — Version migration patterns
- [[breaking-changes]] — Handling deprecated APIs
- [[lockfile-preservation]] — Minimizing dependency drift
