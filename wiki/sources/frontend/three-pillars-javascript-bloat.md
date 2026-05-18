---
description: Analysis of the three main causes of JavaScript dependency tree bloat and tools to address them
tags:
  - javascript
  - performance
  - dependencies
  - package-manager/npm
  - e18e
sources:
  - The Three Pillars of JavaScript Bloat.md
created: 2026-04-29
updated: 2026-04-29
---

# The Three Pillars of JavaScript Bloat

**Source:** [[The Three Pillars of JavaScript Bloat]]
**Date ingested:** 2026-04-29
**Type:** article

## Summary

Analysis of the three main causes of dependency tree bloat in JavaScript/npm ecosystems, why they exist, and how to address them. Written by [[James Garbutt]] (43081j.com), affiliated with the [[e18e]] cleanup initiative.

## Key Claims

1. **Older runtime support** — Packages like `is-string`, `hasown`, `math-intrinsics` exist for ES3 support, global namespace mutation protection, and cross-realm values. The vast majority of projects don't need any of this.
2. **Atomic architecture** — Breaking packages into micro-packages (shebang-regex = 1 regex, arrify = 1 ternary) creates duplication, single-use packages, and larger supply chain surface area. Inlining makes duplication almost free; packaging makes it expensive.
3. **Ponyfills that overstayed welcome** — Packages like `globalthis` (49M downloads/week), `indexof` (2.3M/week), `object.entries` (35M/week) remain in use years after native support arrived.
4. Tools to clean up: [[knip]] (unused deps), [[e18e CLI]] (analyze + migrate), [[npmgraph]] (visualize), [[module-replacements]] (community dataset).

## Entities Mentioned

- [[e18e]] — Community initiative for cleaning up JS ecosystem
- [[knip]] — Tool for finding unused dependencies and dead code
- [[npmgraph]] — Dependency tree visualizer
- [[module-replacements]] — Community dataset of replaceable packages
- [[James Garbutt]] — Author, maintainer of chai

## Concepts Covered

- [[dependency-bloat]] — Excessive/redundant dependencies in npm trees
- [[ponyfill]] — Polyfill imported rather than mutating environment
- [[atomic-packages]] — Micro-packages with single-line functionality
- [[supply-chain-security]] — Risks from large dependency surface area