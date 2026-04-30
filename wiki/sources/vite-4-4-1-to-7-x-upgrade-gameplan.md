---
description: "Vite migration guide from 4.4.1 to 7.x"
tags: [vite, upgrade, migration, monorepo, react, rollup]
sources: ["Vite 4.4.1 to 7.x Upgrade Gameplan.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Vite 4.4.1 to 7.x Upgrade Gameplan

**Source:** raw/01_thinking/notes/Vite 4.4.1 to 7.x Upgrade Gameplan.md
**Date ingested:** 2026-04-09
**Type:** thinking note — Completed March 2026. See [[Completed Work]].

## Summary

Step-by-step upgrade gameplan for migrating Vite from 4.4.1 to 7.x in a React monorepo. Covers breaking changes, migration path, testing checklist, and rollback strategy across three major version jumps (4.x → 5.x → 6.x → 7.x).

## Key Claims

- Can upgrade directly to Vite 7.x without incremental steps — migration guides are for comprehension, not technical requirement
- Node.js 20.19+ / 22.12+ required for Vite 7
- Rollup 4 (Vite 5+) and esbuild consistency are major changes
- Most projects require minimal changes beyond Node.js version updates

## Version Overview

| Version | Key Changes | Release Date |
|---------|-------------|--------------|
| 4.4.1 (current) | Rollup 3.x, basic tree-shaking | ~2023 |
| 5.x | Rollup 4, esbuild consistency, SSR changes | 2024 |
| 6.x | Node 20+ required, browser target changes | 2025 |
| 7.x | Node 18 dropped, Rolldown preview, performance | 2025 |

## Breaking Changes to Address

### TypeScript Configuration
```json
{
  "compilerOptions": {
    "moduleResolution": "bundler",
    "target": "ES2022"
  }
}
```

### CSS: Sass Legacy API Removed
Remove `api` option from `css.preprocessorOptions.scss`

### SSR External Modules (Vite 5+)
May need `legacy.proxySsrExternalModules: true` in config

### CLI Shortcuts (Vite 5+)
Now require Enter: `r + Enter` to restart (was just `r`)

### Manifest Location (Vite 5+)
Moved from `build/build.manifest` to `build/.vite/build.manifest`

### Worker Plugins
Change from array to function: `plugins: () => [...]`

### HTTPS Flag Removed
Remove `--https` from dev scripts (no longer useful)

## Plugin Compatibility

| Plugin | Minimum Version |
|--------|-----------------|
| @vitejs/plugin-react | ^4.3.4 |
| @vitejs/plugin-react-swc | ^3.7.2 |
| @vitejs/plugin-vue | ^5.2.1 |
| vite-plugin-svelte | ^4.0.0 |

## Testing Checklist

### Build Verification
- [ ] `npm run build` completes without errors
- [ ] Output files in expected locations
- [ ] Manifest files in `.vite/` directory

### Dev Server
- [ ] `npm run dev` starts successfully
- [ ] Hot Module Replacement (HMR) works
- [ ] No console errors in browser

### Runtime
- [ ] App loads in browser
- [ ] Routes navigate correctly
- [ ] API calls work
- [ ] Dynamic imports load chunks
- [ ] SSR renders correctly (if applicable)

### Bundle Analysis
- [ ] Compare bundle sizes with baseline
- [ ] Check stats.html for unexpected additions
- [ ] Verify tree-shaking still works

## Migration Timeline Estimate

| Phase | Time |
|-------|------|
| Preparation | 30 min |
| Dependency update | 15 min |
| Config changes | 30 min |
| Breaking changes | 1-2 hours |
| Testing | 1-2 hours |
| Verification | 1 hour |
| **Total** | **4-5 hours** |

## Rollback Strategy

```bash
# 1. Revert package.json
git checkout package.json package-lock.json

# 2. Reinstall dependencies
rm -rf node_modules
npm install

# 3. Verify rollback
npm run build
npm run dev
```

## Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| Module not found | Check `moduleResolution: 'bundler'` in tsconfig |
| Sass errors | Remove `css.preprocessorOptions.scss.api` |
| SSR imports broken | Try `legacy.proxySsrExternalModules: true` |
| Worker plugins fail | Change to function: `plugins: () => [...]` |
| HMR not working | Check `@vitejs/plugin-react-swc` |

## Concepts Covered

- [[Vite Migration]] — Version upgrade strategies
- [[Monorepo Management]] — Dependency coordination
- [[Build Tool Configuration]] — Vite config patterns
- [[Rollback Strategy]] — Safe upgrade practices

## Related

- [[vite-rollup-tree-shaking-guide]]
- [[relay-compiler-build-setup]]
