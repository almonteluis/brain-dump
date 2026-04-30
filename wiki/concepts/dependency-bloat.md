---
description: Excessive or redundant dependencies in JavaScript/npm dependency trees caused by runtime support, atomic architecture, and stale ponyfills
tags: [javascript, npm, dependencies, performance, ecosystem]
sources: ["three-pillars-javascript-bloat"]
created: 2026-04-29
updated: 2026-04-29
---

# Dependency Bloat

Excessive or redundant dependencies in JavaScript/npm dependency trees. A significant and growing problem in the JS ecosystem where the vast majority of projects pay costs for niche compatibility needs of a tiny minority.

## Three Pillars of Bloat

### 1. Older Runtime Support
Packages reimplement native functionality for very old engines (ES3), global namespace mutation protection, and cross-realm values. Most projects running modern Node.js or evergreen browsers don't need any of this.

Examples: `is-string`, `hasown`, `math-intrinsics`

### 2. Atomic Architecture
Breaking code into micro-packages (single regex, single ternary). Creates duplication, single-use packages, and larger supply chain surface area.

Examples: `shebang-regex` (1 regex), `arrify` (1 ternary), `path-key` (1 env var check)

### 3. Ponyfills That Overstayed Welcome
Ponyfills for features now universally supported. Remain because nobody removed them.

Examples: `globalthis` (49M downloads/week, supported since 2019), `indexof` (2.3M/week, supported since 2010)

## Mitigation Tools

- [[knip]] — Find unused dependencies and dead code
- [[e18e CLI]] — Analyze and migrate replaceable dependencies
- [[npmgraph]] — Visualize dependency trees
- [[module-replacements]] — Community dataset of native alternatives

## Related

- [[supply-chain-security]] — Larger dependency trees = larger attack surface
- [[package-manager-comparison]] — pnpm's strict node_modules helps prevent accidental bloat
- [[three-pillars-javascript-bloat]] — Source article