---
description: "Relay fragment composition patterns and parent-child data relationships"
tags: ["source", "relay", "graphql", "fragment-composition"]
sources: ["relay-fragment-composition.md"]
created: 2026-04-08
updated: 2026-04-08
---

# Relay Fragment Composition

**Source:** raw/02_reference/approaches/relay-fragment-composition.md
**Date ingested:** 2026-04-08
**Type:** Technical guide

## Summary

Fragment composition mirrors React component composition, enabling each component to declare its own data needs while including fragments of direct children. This creates a hierarchy where data ownership stays local to components.

## Key Claims

- Components should declare their own data needs via fragments
- Parents must both render children in JSX AND include child's fragment in GraphQL
- Fragment refs flow down: Query → Parent Fragment → Child Fragment → Grandchild Fragment
- Adding fields to child components doesn't require parent changes (Relay compiler handles it)
- Data is isolated — parent only sees what it declared, child only sees what it declared

## Entities Mentioned

- [[relay]] — GraphQL client framework
- [[react-patterns]] — UI component library

## Concepts Covered

- [[fragment-composition]] — Parent-child fragment relationship pattern
- [[data-colocation]] — Keeping data declarations near component usage
- [[fragment-references]] — Opaque refs passed between components
- [[relay-compiler]] — Generates types and optimizes queries

## Key Patterns

### Basic Composition Flow
```
Query → Parent Fragment → Child Fragment
```

### Fragment Naming
Pattern: `{ComponentName}_{propName} on {Type}`

### Benefits
- Local development (change child without touching parents)
- Clear data ownership
- Single efficient query
- Type safety via generated types
- Reusable components across different graph contexts
