---
description: Eight methods for measuring and documenting build output sizes — baseline before tree-shaking optimization
tags: [build, bundle-size, vite, rollup, performance, metrics]
sources: ["Document current build output sizes.md"]
created: 2026-04-21
updated: 2026-04-21
---

# Build Output Size Measurement

**Source:** Document current build output sizes.md
**Date ingested:** 2026-04-21
**Type:** Technical reference

## Summary

Comprehensive guide for measuring and documenting build output sizes across 8 methods. Essential baseline before any tree-shaking or bundle optimization work.

## Key Methods

| Method | Tool | Best For |
|--------|------|----------|
| rollup-plugin-visualizer | Vite plugin | Treemap/sunburst/network views of bundle composition |
| CLI Size Analysis | shell commands | Quick file size checks |
| Vite Built-in Stats | vite.config.ts | Console output with gzip/brotli sizes |
| bundlesize | npm package | CI size threshold enforcement |
| packagesize | npm package | JSON output for automation |
| Webpack/Vite Stats JSON | rollup options | Raw data for custom analysis |
| Lighthouse CI | lighthouse CLI | Performance scores + JS bottlenecks |
| Compare Builds Script | bash | Before/after diff |

## Key Metrics to Capture

- Total bundle size (gzipped and brotli)
- Largest modules (top 5)
- Chunk count
- Vendor vs app ratio
- Performance score, TBT, LCP, CLS, TTI

## Quick Commands

```bash
# All JS files sorted by size
ls -lh dist/assets/*.js | awk '{print $5, $9}' | sort -rh
# Total bundle size
du -sh dist/
# Sum of all gzipped JS
find dist/assets -name "*.js" -exec gzip -c {} \; | wc -c
```

## Concepts Covered

- [[bundle-optimization]] — Measurement before optimization
- [[tree-shaking]] — Baseline for measuring improvement

## Related

- [[vite-rollup-tree-shaking-guide]]
- [[performance-patterns]]
