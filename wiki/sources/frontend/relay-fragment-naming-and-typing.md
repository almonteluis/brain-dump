---
description: Relay fragment naming conventions and TypeScript types
tags:
  - source
  - relay
  - graphql
  - typescript
sources:
  - relay-fragment-naming-and-typing.md
created: 2026-04-08
updated: 2026-04-08
---

# Relay Fragment Naming and Typing

**Source:** raw/02_reference/approaches/relay-fragment-naming-and-typing.md
**Date ingested:** 2026-04-08
**Type:** Technical reference

## Summary

Relay fragment naming follows `{ComponentName}_{propName} on {Type}` pattern with generated `$key` types for type-safe fragment references. This convention describes where fragments are used rather than what they contain.

## Key Claims

- Fragment names should describe component relationship, not contents
- Generated types use `$key` suffix (e.g., `catalogSearch_query$key`)
- Never use `any` for fragment refs — use generated types
- Running `npm run relay` generates types in `__generated__/` folder
- Pattern scales across component hierarchies

## Entities Mentioned

- [[relay]] — GraphQL client framework
- [[TypeScript]] — Typed JavaScript superset

## Concepts Covered

- [[fragment-naming-convention]] — `{ComponentName}_{propName} on {Type}`
- [[generated-types]] — `$key` suffix types from Relay compiler
- [[type-safety]] — Compile-time guarantees for fragment usage
- [[component-hierarchy]] — Parent-child relationships in fragments

## Quick Reference

| Fragment Definition                 | Generated Type                 |
| ----------------------------------- | ------------------------------ |
| `fragment catalogSearch_query`      | `catalogSearch_query$key`      |
| `fragment catalogSearch_BrandTypes` | `catalogSearch_BrandTypes$key` |

## Type Pattern

```tsx
// Import generated type
import type { catalogSearch_BrandTypes$key } from "./__generated__/catalogSearch_BrandTypes.graphql";

// Use in props
interface BrandsProps {
  $ref: catalogSearch_BrandTypes$key;  // Type-safe
}
```
