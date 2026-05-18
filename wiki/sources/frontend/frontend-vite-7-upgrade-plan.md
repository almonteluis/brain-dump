---
description: "Upgrade plan for Vite 7 including package updates, breaking changes, and execution order"
tags: ['research']
raw_file: "Frontend Vite 7 Upgrade Plan.md"
created: 2026-05-17
---

## Overview
Upgrade Vite from v4.4.5 to v7.x and associated packages only. This is a focused upgrade - ESLint, React Router, and other dependencies will be handled in separate branches.

## Prerequisites
- Node.js 20.x (already upgraded by another dev)

---

## Packages to Update (This Branch Only)

| Package | Current | Target | Notes |
|---------|---------|--------|-------|
| vite | 4.4.5 | 7.1.6 | Main upgrade |
| vitest | 0.34.6 | 3.2.4 | Must support Vite 7 |
| @vitejs/plugin-react | 4.0.3 | 5.1.4 | Vite 7 compatible |
| vite-plugin-svgr | 4.2.0 | 4.5.0 | Minor update |
| vite-plugin-node-polyfills | 0.19.0 | 0.25.0 | Minor update |
| vite-plugin-relay | 2.0.0 | 2.1.0 | Minor update |
| rollup-plugin-visualizer | 5.9.2 | 5.14.0 | Minor update |

---

## Critical Breaking Change: splitVendorChunkPlugin

**Vite 7 removed `splitVendorChunkPlugin()`**

The good news: Your `vite.config.ts` already has a `manualChunks` function that handles vendor splitting, so you just need to remove the deprecated plugin.

---

## Phase 1: Update package.json

### devDependencies to update:

```json
{
  "devDependencies": {
    "vite": "^7.1.6",
    "vitest": "^3.2.4",
    "@vitejs/plugin-react": "^5.1.4",
    "vite-plugin-svgr": "^4.5.0",
    "vite-plugin-node-polyfills": "^0.25.0",
    "vite-plugin-relay": "^2.1.0",
    "rollup-plugin-visualizer": "^5.14.0"
  }
}
```

---

## Phase 2: Update vite.config.ts

**File**: `frontend/vite.config.ts`

Remove `splitVendorChunkPlugin` import and usage:

```diff
- import { loadEnv, splitVendorChunkPlugin } from 'vite';
+ import { loadEnv } from 'vite';
```

```diff
  plugins: [
    relay,
    react(),
    svgr(),
-   splitVendorChunkPlugin(),
    visualizer(),
    nodePolyfills(),
    // ...
  ],
```

---

## Execution Order

1. **Create** new branch: `git checkout -b upgrade/vite-7`
2. **Update** packages using targeted npm install (preserves lockfile):
   ```bash
   cd frontend
   npm install vite@^7.1.6 vitest@^3.2.4 @vitejs/plugin-react@^5.1.4 vite-plugin-svgr@^4.5.0 vite-plugin-node-polyfills@^0.25.0 vite-plugin-relay@^2.1.0 rollup-plugin-visualizer@^5.14.0 --save-dev
   ```
3. **Update** `vite.config.ts` (remove splitVendorChunkPlugin)
4. **Test**: `npm run build && npm test`
5. **Run** dev server: `npm run dev`

**Why NOT delete package-lock.json:**
- Deleting it forces npm to recalculate the entire dependency tree
- npm will update ALL packages to the latest versions within their semver ranges
- This causes cascading updates to unrelated packages
- Using `npm install package@version` only updates the specified packages and necessary transitive deps

---

## Verification Steps

1. **Build Check**: `npm run build` - should complete successfully
2. **Test Check**: `npm test` - all tests should pass
3. **Dev Server**: `npm run dev` - should start without errors

---

## Files to Modify

1. `frontend/package.json` - update Vite-related versions
2. `frontend/vite.config.ts` - remove splitVendorChunkPlugin

---

## Separate Tickets (Not This Branch)

- ESLint 9 + flat config migration
- React Router v7 upgrade
- React 18.3.x update
- Relay v20 upgrade
- Other dependency updates
