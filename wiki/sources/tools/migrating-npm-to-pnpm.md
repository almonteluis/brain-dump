---
description: Step-by-step guide for migrating from npm to pnpm with CI pipeline and Node version management
tags:
  - package-manager/pnpm
  - package-manager/npm
  - migrations
  - git/ci-cd
  - package-manager
sources:
  - Migrating from NPM to PNPM.md
created: 2026-04-29
updated: 2026-04-29
---

# Migrating from NPM to PNPM

**Source:** [[Migrating from NPM to PNPM]]
**Date ingested:** 2026-04-29
**Type:** migration guide

## Summary

Step-by-step guide for migrating from npm to pnpm. Covers installation, lockfile import, strict node_modules implications, CI pipeline setup (GitLab CI example), and pnpm's Node version management.

## Key Claims

1. **Migration steps**: Delete `node_modules` → add `preinstall: "npx only-allow pnpm"` → create `pnpm-workspace.yaml` → `pnpm import` → delete old lockfile → `pnpm install`.
2. **Strict node_modules**: pnpm only exposes direct dependencies. Code importing undeclared packages will fail. Fix with `--shamefully-hoist` (discouraged).
3. **CI caching**: Cache `/root/.pnpm-store/v3` + `./node_modules`. Use `$CI_COMMIT_REF_SLUG` as cache key.
4. **Node version management**: `pnpm env use --global lts` replaces nvm. Set via `.npmrc`: `use-node-version=16.14.0`.
5. **Reused counter** on install shows cache hits. Stays at 0 on first install, increases on subsequent runs.

## Entities Mentioned

- [[Janusz Lavrnja-Czapski]] — Author (British Geological Survey)
- [[pnpm]] — Package manager
- [[GitLab CI]] — CI/CD platform

## Concepts Covered

- [[npm-to-pnpm-migration]] — Practical migration steps
- [[pnpm-strict-node-modules]] — Dependency isolation benefits
- [[ci-caching-pnpm]] — CI pipeline optimization with pnpm

## Related

- [[pnpm-vs-npm-vs-yarn-vs-bun-2026]] — Comprehensive 2026 comparison
- [[choosing-right-js-package-manager-2025]] — Beginner-friendly overview
- [[pnpm-vs-bun-vs-yarn-berry]] — Three-way comparison of alternatives
- [[pnpm-npm-yarn-bun-benchmarks]] — Speed and disk benchmarks