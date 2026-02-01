---
description: Step-by-step upgrade gameplan for migrating Vite from 4.4.1 to 7.x in React monorepo — breaking changes, migration path, testing checklist, and rollback strategy.
tags: ["vite", "upgrade", "migration", "monorepo", "react", "rollup"]
created: 2026-01-31
status: #planning
---

# Vite 4.4.1 to 7.x Upgrade Gameplan

## Context

**Current state:** Vite 4.4.1 (released ~2023)
**Target state:** Vite 7.3.1 (latest stable as of January 2026)
**Jump:** Three major versions (4.x → 5.x → 6.x → 7.x)

**Why upgrade?**
- Security updates (Node 18 EOL, vulnerabilities)
- Performance improvements (esbuild updates, Rollup 4)
- New features (better tree-shaking, improved HMR)
- Bug fixes and stability improvements

---

## Risk Assessment

| Risk | Level | Mitigation |
|------|-------|------------|
| Breaking changes | Medium | Follow migration guides, test thoroughly |
| Plugin compatibility | Medium | Check plugin versions, update as needed |
| Node version requirement | Low | Already on Node 20+ |
| Build output changes | Low | Test build artifacts thoroughly |
| Runtime behavior changes | Low | SSR handling changes in v5+ |

---

## Version Overview

| Version | Key Changes | Release Date |
|---------|--------------|--------------|
| **4.4.1** (current) | Rollup 3.x, basic tree-shaking | ~2023 |
| **5.x** | Rollup 4, esbuild consistency, SSR changes | 2024 |
| **6.x** | Node 20+ required, browser target changes | 2025 |
| **7.x** | Node 18 dropped, Rolldown preview, performance | 2025 |

**Latest stable:** 7.3.1 (January 2026)

---

## Prerequisites Checklist

Before starting the upgrade:

- [ ] [[Document current build output sizes]]
- [ ] Run `npm run build` and save stats.html as baseline
- [ ] List all Vite plugins: `npm list | grep vite`
- [ ] Check Node version: `node --version` (must be 20.19+ / 22.12+)
- [ ] Create a git branch: `git checkout -b upgrade-vite-7`
- [ ] Ensure tests pass: `npm test`
- [ ] Document current vite.config.ts

---

## Upgrade Path: Skip to 7.x Direct

**Can you upgrade directly?** Yes. The official Vite docs recommend reviewing migration guides incrementally to understand changes, but this is for comprehension—not a technical requirement. You can install Vite 7.x directly and address all breaking changes at once.

**Source:** [Vite Migration Guide](https://vite.dev/guide/migration) — "Check the Migration from v5 Guide first... then proceed" is guidance for understanding, not a stepwise requirement.

### Plugin Compatibility Check

Before upgrading, verify your Vite plugins support Vite 7:

```bash
# List all Vite-related packages
npm list | grep vite

# Check specific plugin versions against Vite 7 compatibility
npm view @vitejs/plugin-react peerDependencies
npm view vite-plugin-svelte peerDependencies
```

**Common plugin versions for Vite 7:**

| Plugin | Minimum Version | Install Command |
|--------|----------------|-----------------|
| @vitejs/plugin-react | ^4.3.4 | `npm install -D @vitejs/plugin-react@^4.3.4` |
| @vitejs/plugin-react-swc | ^3.7.2 | `npm install -D @vitejs/plugin-react-swc@^3.7.2` |
| @vitejs/plugin-vue | ^5.2.1 | `npm install -D @vitejs/plugin-vue@^5.2.1` |
| vite-plugin-svelte | ^4.0.0 | `npm install -D vite-plugin-svelte@^4.0.0` |

**Check if your plugin is ready:**
- Search `npm view <plugin-name> peerDependencies` for Vite version requirements
- Check plugin's GitHub issues for Vite 7 compatibility
- Look for "Vite 7" or "Rollup 4" mentions in plugin changelogs

### Step 1: Update Dependencies

**package.json:**
```json
{
  "devDependencies": {
    "vite": "^7.3.1",
    "@vitejs/plugin-react": "^4.3.4",
    "@vitejs/plugin-react-swc": "^3.7.2"
  }
}
```

**Install:**
```bash
npm install vite@^7.3.1 @vitejs/plugin-react@^4.3.4 --save-dev
```

### Step 2: Address Breaking Changes

#### Node.js Version

**Requires:** Node.js 20.19+ / 22.12+

```bash
node --version  # Must be 20.19+ or 22.12+
```

If on Node 18: Upgrade Node first.

#### TypeScript Configuration

**tsconfig.json:**
```json
{
  "compilerOptions": {
    "moduleResolution": "bundler",
    "target": "ES2022"
  }
}
```

#### CSS: Sass Legacy API Removed

If you see Sass errors, remove `api` option:

```typescript
// ❌ Remove this
css: {
  preprocessorOptions: {
    scss: {
      api: 'modern-compiler' // or 'legacy'
    }
  }
}
```

#### Import Attributes (Rollup 4 change)

If you use import assertions:

```typescript
// ❌ Old (Vite 4)
import { foo } from 'bar' with { type: 'json' }

// ✅ New (Vite 5+)
import { foo } from 'bar' with { type: 'json' }
```

Actually `assertions` → `attributes` but syntax is same. If you get errors, check plugin compatibility.

#### SSR External Modules (Vite 5 change)

If using SSR, import patterns changed:

```typescript
// Before (Vite 4)
import { foo } from 'bar'

// After (Vite 5+) - may need adjustment
import * as _bar from 'bar'
const { foo } = _bar
```

**Set `legacy.proxySsrExternalModules: true` in vite.config if needed:**

```typescript
export default defineConfig({
  // ...
  ssr: {
    noExternal: true,
    // OR if issues persist:
    // legacy: {
    //   proxySsrExternalModules: true
    // }
  }
})
```

#### CLI Shortcuts (Vite 5+)

CLI shortcuts now require `Enter`:
- `r + Enter` to restart (was just `r`)
- `h + Enter` to show help

#### Manifest Location (Vite 5+)

Manifest files now in `.vite` directory instead of build root:

```typescript
// Before: build/build.manifest
// After: build/.vite/build.manifest
```

Update references if your code reads these files.

### Step 3: Update vite.config.ts

```typescript
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react-swc'

export default defineConfig({
  plugins: [react()],
  build: {
    target: 'es2020', // Baseline 2022
    rollupOptions: {
      output: {
        manualChunks: {
          vendor: ['react', 'react-dom', 'react/jsx-runtime']
        }
      }
    }
  }
})
```

### Step 4: Update Worker Plugins (if applicable)

```typescript
// ❌ Vite 4
worker: {
  plugins: [plugin1(), plugin2()]
}

// ✅ Vite 5+
worker: {
  plugins: () => [plugin1(), plugin2()]
}
```

### Step 5: Update Test Scripts

If using `--https` flag, remove it (no longer useful):

```json
{
  "scripts": {
    // ❌ "dev": "vite --https"
    "dev": "vite"
  }
}
```

---

## Testing Checklist

After upgrading, verify:

### Build succeeds
- [ ] `npm run build` completes without errors
- [ ] Output files are generated in expected locations
- [ ] Manifest files in `.vite/` directory

### Dev server works
- [ ] `npm run dev` starts successfully
- [ ] Hot Module Replacement (HMR) works
- [ ] No console errors in browser

### Runtime verification
- [ ] App loads in browser
- [ ] Routes navigate correctly
- [ ] API calls work
- [ ] Dynamic imports load chunks
- [ ] SSR (if applicable) renders correctly

### Bundle analysis
- [ ] Compare bundle sizes with baseline
- [ ] Check stats.html for unexpected additions
- [ ] Verify tree-shaking still works

### Tests pass
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] E2E tests pass

---

## Rollback Strategy

If upgrade fails:

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

**Before upgrading, commit everything:**
```bash
git add .
git commit -m "Before Vite upgrade: working state at 4.4.1"
```

---

## Migration Timeline Estimate

| Phase | Tasks | Time |
|-------|-------|------|
| **Preparation** | Baseline metrics, branch, docs | 30 min |
| **Dependency update** | Install Vite 7.x, update plugins | 15 min |
| **Config changes** | Update vite.config, tsconfig | 30 min |
| **Breaking changes** | Fix import patterns, worker plugins | 1-2 hours |
| **Testing** | Dev server, build, runtime tests | 1-2 hours |
| **Verification** | Bundle analysis, regression testing | 1 hour |
| **Total** | | **4-5 hours** |

---

## Quick Reference: Common Issues

| Issue | Solution |
|-------|----------|
| Module not found | Check `moduleResolution: 'bundler'` in tsconfig |
| Sass errors | Remove `css.preprocessorOptions.scss.api` |
| SSR imports broken | Try `legacy.proxySsrExternalModules: true` |
| Worker plugins fail | Change to function: `plugins: () => [...]` |
| Build slower | Check plugin versions, disable unnecessary ones |
| HMR not working | Check browser console, verify `@vitejs/plugin-react-swc` |
| Bundle size increased | Run stats.html, check for tree-shaking failures |

---

## Post-Upgrade Actions

After successful upgrade:

1. **Update documentation** - Update any internal docs referencing Vite 4.x syntax
2. **Update team** - Share changes with team, especially SSR changes
3. **Monitor** - Watch for any issues in production for first week
4. **Clean up** - Remove any workarounds added during migration

---

## Sources

- [Vite Migration Guide (v6 → v7)](https://vite.dev/guide/migration)
- [Vite 5 Migration Guide (v4 → v5)](https://v5.vite.dev/guide/migration) — Rollup 4 changes
- [Vite Breaking Changes](https://vite.dev/changes/) — Complete list with `future` opt-in options
- [Vite 7.0 Announcement](https://vite.dev/blog/announcing-vite7)
- [Vite 7 Release - Baseline 2025](https://blog.openreplay.com/whats-new-vite-7-rust-baseline-beyond/) — "Most projects require minimal changes beyond Node.js version updates"
- [Rollup Changelog](https://github.com/rollup/rollup/blob/master/CHANGELOG.md)

---

## Related

[[vite-rollup-tree-shaking-guide]]
[[Vite Rollup tree-shaking]]
[[Rollup]]
[[Performance Optimization]]
