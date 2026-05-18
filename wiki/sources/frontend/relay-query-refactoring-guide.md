---
description: Migration guide from multiple useLazyLoadQuery calls to single query + fragments with hook comparison
tags:
  - relay
  - graphql
  - query-refactoring
  - fragments
  - data/masking
  - optimization
sources:
  - relay-query-refactoring-guide.md
created: 2026-04-09
updated: 2026-04-09
---

# Relay Query Refactoring Guide: Multiple Queries to Single Query + Fragments

**Source:** raw/02_reference/relay/relay-query-refactoring-guide.md
**Date ingested:** 2026-04-09
**Type:** technical guide

## Summary

Deep dive into converting `useLazyLoadQuery` and `usePreloadedQuery` patterns to use fragments for optimized data fetching. Covers fragment keys, data masking, migration strategies, and performance improvements.

## Key Claims

- Multiple separate queries result in waterfall network requests (2+ round trips)
- Single query with fragments reduces total time by ~45% (e.g., 450ms → 250ms)
- Fragment keys (`$ref`) enable data masking and component isolation
- `usePreloadedQuery` with `loadQuery()` enables "render-as-you-fetch" pattern
- `@skip` and `@include` directives enable conditional fragment fetching

## Concepts Covered

- [[useLazyLoadQuery]] — Fetch query when component renders
- [[usePreloadedQuery]] — Read preloaded query data
- [[useQueryLoader]] — Manage preloaded query references
- [[useFragment]] — Read fragment data from Relay store
- [[fragment-keys]] — Opaque references to graph data (`$ref` types)
- [[data-masking]] — Hiding data from non-declaring components
- [[fragment-arguments]] — Dynamic behavior via `@argumentDefinitions`
- [[render-as-you-fetch]] — Fetching before component renders
- [[relay-compiler]] — TypeScript type generation from GraphQL

## Migration Checklist

- [ ] Create fragment for child component
- [ ] Import/use `useFragment` in child
- [ ] Update Props to use `FragmentName$key`
- [ ] Spread fragment into parent query
- [ ] Remove `useQueryLoader` from parent
- [ ] Pass fragment key to child, not `skillId`
- [ ] Handle `@skip`/`@include` for conditional views
- [ ] Run `npm run relay` to regenerate types
- [ ] Verify single network request in DevTools
