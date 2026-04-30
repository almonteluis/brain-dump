---
description: Vite — next-generation frontend build tool and development server
tags: ["vite", "build-tools", "frontend", "bundler", "dev-server", "concept"]
created: 2026-04-30
updated: 2026-04-30
sources: ["teamf-296-vite-upgrade", "vite-7-upgrade-plan", "vite-4-4-1-to-7-x-upgrade-gameplan"]
---

# Vite

Vite is a next-generation frontend build tool and development server that leverages native ES modules for fast development and Rollup for optimized production builds.

## Key Features

- **Instant dev server start** — No bundling on startup, serves files via native ESM
- **Lightning-fast HMR** — Hot module replacement via native ESM
- **Optimized builds** — Uses Rollup for production bundling with tree-shaking and code splitting
- **Rich plugin ecosystem** — Compatible with Rollup plugins plus Vite-specific plugins

## Version History

| Version | Year | Key Changes |
|---------|------|-------------|
| 4.x | 2023 | Baseline for many projects |
| 5.x | 2024 | Improved build performance, removed `splitVendorChunkPlugin` |
| 6.x | 2025 | Further optimizations |
| 7.x | 2026 | Latest stable |

## Upgrade Patterns

### Targeted Install (Recommended)

```bash
npm install vite@^5.4.21 vitest@^3.2.4 @vitejs/plugin-react@^5.1.4 --save-dev
```

Preserves lockfile, avoids cascading dependency updates.

### Breaking Changes to Watch

- **Vite 5:** Removed `splitVendorChunkPlugin()` — remove from config if present
- **Vite 6/7:** Check changelogs for plugin compatibility

### ESLint Compatibility

ESLint v9 migration can block Vite upgrades due to test runner incompatibilities (e.g., `InvalidCharacterError` in jsdom). May need separate ticket.

## Performance Benchmarks

From [[teamf-296-vite-upgrade]]:
- Build time: 44.60s to 19.92s (55% improvement, v4 to v5)
- Tests: 132 passing, no regressions
- Vulnerabilities: 28 to 10

## Related

- [[teamf-296-vite-upgrade]] — Vite 4 to 5 upgrade case study
- [[vite-7-upgrade-plan]] — v4 to v7 migration guide
- [[build-performance]] — Measuring and optimizing build times
- [[rollup]] — Underlying bundler for Vite production builds
