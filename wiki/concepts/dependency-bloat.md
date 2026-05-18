---
description: Excessive or redundant dependencies in JavaScript/npm dependency trees caused by runtime support, atomic architecture, and stale ponyfills
tags:
  - javascript
  - package-manager/npm
  - dependencies
  - performance
  - ecosystem
sources:
  - three-pillars-javascript-bloat
created: 2026-04-29
updated: 2026-04-29
---

# Dependency Bloat

Your `node_modules` is 800MB and your app is five pages. That's dependency bloat — the JS ecosystem's habit of pulling in hundreds of packages you don't need so that three people running IE8 in 2013 don't get errors. The vast majority of projects pay real costs (bundle size, install time, [[supply-chain-security]] risk) for compatibility they'll never use.

## Three Pillars of Bloat

### 1. Older Runtime Support
Packages that reimplement native functionality for ES3-era engines, global namespace mutation guards, and cross-realm value checks. If you're on modern Node.js or evergreen browsers (you are), none of this matters.

Examples: `is-string`, `hasown`, `math-intrinsics` — functions that are literally `typeof x === 'string'`.

### 2. Atomic Architecture
Breaking code into micro-packages where each one contains a single regex or a single ternary. Looks clean on npm, creates duplication and massive supply chain surface area downstream. One left-pad incident was enough.

Examples: `shebang-regex` (1 regex), `arrify` (1 ternary), `path-key` (1 env var check)

### 3. Ponyfills That Overstayed Welcome
Ponyfills for features now universally supported — still installed because nobody removed them. `globalthis` gets 49M downloads/week for something supported since 2019. `indexof` gets 2.3M/week for something supported since 2010.

## Tools to Fight Back

- [[knip]] — Find unused dependencies and dead code
- [[e18e CLI]] — Analyze and migrate replaceable dependencies
- [[npmgraph]] — Visualize dependency trees
- [[module-replacements]] — Community dataset of native alternatives

## Related

- [[supply-chain-security]] — Larger dependency trees = larger attack surface
- [[package-manager-comparison]] — pnpm's strict node_modules helps prevent accidental bloat
- [[three-pillars-javascript-bloat]] — Source article
- [[formal-verification]] — Same problem from the other direction: prove correctness instead of shrinking the trust surface
- [[trust-boundaries-formal-verification-and-bloat]] — Synthesis: dependency reduction + formal verification as twin strategies
