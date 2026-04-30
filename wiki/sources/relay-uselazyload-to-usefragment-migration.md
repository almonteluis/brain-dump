---
description: "Migration guide from useLazyLoadQuery to useFragment"
tags: ["source", "relay", "graphql", "migration", "refactoring"]
sources: ["relay-uselazyload-to-usefragment-migration.md"]
created: 2026-04-08
updated: 2026-04-08
---

# Migrating useLazyLoadQuery to useFragment

**Source:** raw/02_reference/approaches/relay-uselazyload-to-usefragment-migration.md
**Date ingested:** 2026-04-08
**Type:** Migration guide

## Summary

Process for migrating Relay queries from `useLazyLoadQuery` to `useFragment` for better data colocation and type safety. Moves data ownership closer to where it's consumed.

## Key Claims

- `useLazyLoadQuery` is for root-level data fetching and page initialization
- `useFragment` is for child component data, reusable components, shared data across parents
- Migration requires: create parent fragment, update child to use fragment, refactor parent query, verify type safety
- Changes to child data needs stay local — no parent query modifications required

## Migration Steps

1. **Create Parent Fragment** — Declare fragment that child will consume
2. **Update Child Component** — Convert from props to fragment ownership
3. **Refactor Parent Query** — Remove fields now owned by child
4. **Verify Type Safety** — Use generated `$key` types

## Comparison

| `useLazyLoadQuery` | `useFragment` |
|-------------------|---------------|
| Data fetched at parent, passed down | Data declared at component, owns lifecycle |
| Changes require modifying parent query | Changes stay local to component |
| Props must be typed manually | Types generated automatically from fragment |
| Refetching requires parent context | Refetching hooks available on fragment |

## Fragment Naming Pattern

```graphql
fragment {ComponentName}_{propName} on {Type}
```

Examples:
- `catalogSearch_BrandTypes on Brand`
- `productDetails_Pricing on Product`
- `userHeader_Profile on User`
