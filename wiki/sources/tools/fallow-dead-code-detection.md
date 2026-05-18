---
description: Fallow dead code detection tool for TypeScript/JavaScript — 15 issue types with severity levels, priority ordering, and incremental adoption strategy
tags:
  - dead-code
  - typescript
  - javascript
  - static-analysis
  - tooling
  - code/quality
sources:
  - fallow The codebase analyzer for TypeScript and JavaScript.md
created: 2026-04-11
updated: 2026-04-11
---

# Fallow Dead Code Detection

**Source:** Fallow documentation (docs.fallow.tools)
**Type:** Tool documentation
**Date ingested:** 2026-04-11

## Summary

Fallow is a codebase analyzer for TypeScript and JavaScript that detects 15 types of dead code with severity-based reporting, priority ordering, and incremental adoption support. It auto-detects 85 frameworks via `package.json` and provides CLI + MCP server interfaces.

## 15 Issue Types

### Error Severity (Cause non-zero exit with `--fail-on-issues`)

| Issue Type | Description | Common False Positive |
|------------|-------------|----------------------|
| **Unused files** | Files not reachable from any entry point | Scripts run directly — add to `entry` |
| **Unused exports** | Exported symbols never imported by any module | Library public API — mark with `/** @public */` |
| **Unused dependencies** | Packages in `dependencies` never imported | Peer deps of other packages |
| **Unresolved imports** | Import specifiers that cannot be resolved to a file | Typos, missing deps, unconfigured path aliases |
| **Unlisted dependencies** | Imports not declared in `package.json` | Works by accident (hoisted), breaks in pnpm/yarn PnP |
| **Boundary violations** | Imports crossing user-defined architecture zone boundaries | Shared utilities accessible from multiple zones |

### Warning Severity

| Issue Type | Description | Common False Positive |
|------------|-------------|----------------------|
| **Unused types** | Type aliases/interfaces never referenced | Shared type packages for external consumers |
| **Unused devDependencies** | Dev packages never imported | — |
| **Unused optionalDependencies** | Same as unused deps but for optional (opt-in) | — |
| **Unused enum members** | Enum values declared but never referenced | — |
| **Unused class members** | Class methods/properties not referenced outside class body | Framework lifecycle methods, decorator-driven access |
| **Duplicate exports** | Same symbol name exported from multiple modules | — |
| **Circular dependencies** | Modules importing each other directly or transitively | Type-only cycles are safe |
| **Type-only dependencies** | Production deps only imported via `import type` | Move to `devDependencies` |
| **Test-only dependencies** | Production deps only imported by test files | Move to `devDependencies` |

## Priority Ordering for Findings

Fix in this order:

1. **Unresolved imports** — Potential runtime failures
2. **Unlisted dependencies** — Breaks in strict environments
3. **Boundary violations** — Architecture enforcement
4. **Unused files** — Entire modules to delete
5. **Unused dependencies** — Security and install time
6. **Unused exports** — API surface cleanup
7. **Circular dependencies** — Initialization bugs
8. **Type-only dependencies** — Install size optimization
9. **Test-only dependencies** — Install size optimization
10. **Duplicate exports** — Developer experience
11. **Unused types / enum members / class members** — Code hygiene

Categories 1-2 are correctness issues (may cause runtime failures). Everything else is maintenance and hygiene.

## Circular Dependency Risk Matrix

| Cycle length | Risk | Action |
|-------------|------|--------|
| 2 (A <-> B) | Moderate — usually a design issue | Extract shared code into third module |
| 3-5 | Higher — harder to trace | Break at weakest edge |
| 5+ | Architectural issue | Refactor module boundaries |

## Incremental Adoption

### Baseline Comparison
```bash
fallow dead-code --save-baseline .fallow-baseline.json
fallow dead-code --baseline .fallow-baseline.json --fail-on-issues
```

Baseline captures issue fingerprints (file + export + type), not line numbers. Refactoring won't invalidate the baseline.

### Changed-Since (for CI)
```bash
fallow dead-code --changed-since main
```

Reports issues only in files changed in current PR.

### Filter by Type
```bash
fallow dead-code --unused-files --fail-on-issues
```

Adopt one issue type at a time. Fix findings, then add next type.

## Verification Commands

```bash
# Verify a specific export
fallow dead-code --trace src/utils.ts:formatDate

# See all edges for a file
fallow dead-code --trace-file src/utils.ts

# Check where a dependency is used
fallow dead-code --trace-dependency lodash
```

## Common False Positive Patterns

| Pattern | Why Flagged | Fix |
|---------|-------------|-----|
| Scripts run directly | Not imported by any module | Add to `entry` or `package.json` script |
| Dependency injection | Registered via DI container | Add to `entry` or use `/** @public */` |
| Dynamic `require()` with variables | Path not statically resolvable | Add directory to `entry` |
| Environment-specific files | Only imported behind `process.env` checks | Add to `entry` if always needed |

## Limitations

- **Runtime-computed paths** — `import(variable)` cannot be resolved; template literals and `import.meta.glob` are resolved
- **Syntactic analysis only** — No TypeScript compiler invocation; conditional types require type resolution
- **Side-effect imports** — Tracked at file level, but individual exports within still analyzed

## Connection to TEAME-218

The dead code detection priority ordering and graduated confidence methodology was referenced in [[teame-218-brainbreak-postmortem]] PR readiness research for evaluating the BrainBreak codebase cleanup.

## Related

- [[tree-shaking]] — Dead code elimination at bundle level
- [[barrel-files]] — Anti-pattern that creates unused exports
- [[teame-218-brainbreak-postmortem]] — Post-mortem referencing dead code detection
- [[code-splitting]] — Component-level lazy loading
