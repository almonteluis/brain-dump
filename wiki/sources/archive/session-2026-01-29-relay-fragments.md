---
description: Session transcript on Relay fragments from 2026-01-29
tags:
  - session/summary
  - relay
  - graphql
  - fragments
  - documentation
  - transcript
sources:
  - session-2026-01-29-relay-fragments.md
created: 2026-04-09
updated: 2026-04-09
---

# Session: Relay GraphQL Fragments

**Source:** raw/02_reference/tools/session-2026-01-29-relay-fragments.md
**Date ingested:** 2026-04-09
**Type:** session transcript

## Summary

Session summary from processing Relay GraphQL fragments documentation. Created 6 notes on fragment patterns, data masking, fragment references, composition, @alias directive, and fragment arguments.

## Sources Processed

1. Relay Tutorial - Fragments (official)
2. Relay Guided Tour - Rendering Fragments (official)
3. RescriptRelay - Using Fragments
4. Emma Goto - Relay GraphQL Fragments (practical guide)

## The Fragment Pattern

```
┌─────────────────────────────────────────────────────────────┐
│                    THE FRAGMENT PATTERN                      │
├─────────────────────────────────────────────────────────────┤
│  1. DEFINE   → fragment MyFragment on Type { fields }       │
│  2. SPREAD   → ...MyFragment in parent query/fragment       │
│  3. PASS     → <Child data={fragmentRef} />                │
│  4. READ     → const data = useFragment(fragment, ref)     │
└─────────────────────────────────────────────────────────────┘
```

## Key Concepts Extracted

### 1. Fragment References
- Opaque objects that Relay uses to read data
- Contain hidden metadata: node ID + available fragments
- Created at the point where fragment is spread
- Passed between components as props

### 2. Data Masking
- Relay hides data unless component explicitly requests it
- Enables safe refactoring (remove fields with confidence)
- Prevents implicit dependencies between components

### 3. Fragment Composition
- Fragments can include other fragments
- Parent spreads child's fragment in its own fragment
- Modify child's data needs without touching parent

### 4. @alias Directive
- Puts each fragment on its own property
- Solves conditional fragments (@include/@skip)
- Solves union/interface fragment spreads

### 5. Fragment Arguments
- Fragments accept arguments via @argumentDefinitions
- Arguments passed at spread time via @arguments
- Enables context-specific data fetching

## Notes Created

| Note | Location | Key Topic |
|------|----------|-----------|
| [[relay-graphql-fragments]] | `00_inbox/Links/` | Main overview |
| [[Data Masking in Relay]] | `02_reference/approaches/` | Data isolation |
| [[fragment-references-relay]] | `02_reference/approaches/` | Opaque pointers |
| [[Relay Fragment Composition]] | `02_reference/approaches/` | Parent-child pattern |
| [[@alias Directive]] | `02_reference/tools/` | Conditional fragments |

## ESLint Rules

- `unused-fields` — Error when queried fields aren't used
- `must-colocate-fragment-spreads` — Error when fragments aren't co-located

## Concepts Covered

- [[relay]] — Meta's React GraphQL framework
- [[fragment-composition]] — Parent-child fragment patterns
- [[data-masking]] — Component data isolation
- [[fragment-references-relay]] — Opaque data pointers

## Related

- [[relay-graphql-fragments]]
- [[relay-fragment-composition]]
