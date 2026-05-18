---
tags: [work, accessibility, axe, linting, devtools]
sources: ["Question for axetool linter.md"]
created: 2026-05-04
updated: 2026-05-04
---

# Axe Liner Setup — Notes from Chris Call

**Source:** Question for axetool linter.md
**Date ingested:** 2026-05-05
**Type:** Technical notes / tool evaluation

## Summary

Notes from call with Chris (Axe Tools technical rep) about IDE linter vs browser extension for accessibility testing. Conclusion: browser devtools extension is superior for comprehensive a11y testing.

## Key Claims

- Axe IDE linter catches only ~20% of accessibility bugs.
- Linter treats issues like "missing alt tag" — surface-level only.
- Custom components (e.g., a component that renders as a `<button>`) must be mapped to their semantic element for linter to evaluate correctly. Requires additional config.
- Full a11y bugs only surface when project is compiled and served — runtime DOM analysis needed.
- **Recommendation:** Use Chrome DevTools Axe extension over IDE linter.
- Since switched to NeoVim, no longer pursuing IDE linter integration. Potential plugin exists but not explored.
- Custom component mapping config may still be useful for CI/tooling.

## Entities Mentioned

- [[Chris]] — Axe Tools technical representative

## Concepts Covered

- [[axe-deque]] — axe DevTools / axe Linter
- [[accessibility-testing]] — IDE vs runtime testing tradeoffs
- [[wcag-2-1]] — accessibility guidelines being tested
- [[custom-components]] — semantic element mapping for linting

## Related

- [[accessibility-marvin-wcag]] — Marvin accessibility documentation
