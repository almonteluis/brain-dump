---
description: "Layer 3 heading audit results summary"
tags: [tools, layer-3, audit, headings, progressive-disclosure, vault-maintenance, obsidian]
sources: [layer-3-audit-summary.md]
created: 2026-04-09
updated: 2026-04-09
---

# Layer 3 Heading Audit Summary

**Source:** raw/02_reference/tools/layer-3-audit-summary.md
**Date ingested:** 2026-04-09
**Type:** audit report

## Summary

Comprehensive audit of vault heading structure (Layer 3 of progressive disclosure) that identified and fixed 207 files with heading issues. All notes now follow standardized heading conventions.

## Key Claims

- 207 files had heading issues requiring fixes across 4 categories
- H5+ deeply nested files should be split into focused notes
- Wall of text files (>30 lines, <3 headings) need structural breaks
- Every note must have H1 + at least one H2
- H4 maximum depth — deeper nesting means split the note

## Issues Found and Fixed

| Issue Type | Count | Description |
|------------|-------|-------------|
| **H5+ files** | 3 | Files with H5 or deeper headings — required splitting |
| **ONLY_H1** | 48 | Files with H1 but no H2 headings |
| **WALL_OF_TEXT** | 106 | Files with >30 lines and <3 headings total |
| **NO_HEADINGS** | 50 | Files with no headings at all |
| **TOTAL** | 207 | All fixed |

## Standards Established

1. **Minimum headings** — Every note has H1 + at least one H2
2. **Max depth** — H4 maximum (deeper means split the note)
3. **Section order** — Overview → Details → Examples → Related
4. **Parallel structure** — Consistent heading patterns within note types

## Heading Standards by Note Type

### Quick Reference
```
# Topic Name
## Key Points
## Common Use Cases
## Edge Cases / Gotchas
## Best Practices
```

### Concept / Reference
```
# Concept Name
## Overview
## How It Works
## Syntax Examples
## Common Patterns
## Related Concepts
```

### Debugging / Case Study
```
# Problem Title
## Issue Summary
## Debugging Process
## Root Cause
## Solution
## Lessons Learned
```

## Concepts Covered

- [[progressive-disclosure-in-practice]] — Layered information navigation
- [[Layer 3]] — Outline/heading layer
- [[Heading Standards]] — Note structure conventions
- [[Vault Maintenance]] — Quality assurance processes

## Related

- [[layer-3-heading-standards]]
- [[yaml-descriptions-layer-2]]
- [[obsidian-claude-101]]
