---
description: GraphQL over-fetching — requesting more data than the UI needs, causing performance degradation
tags: ["graphql", "performance", "over-fetching", "relay", "optimization", "concept"]
created: 2026-04-30
updated: 2026-04-30
sources: ["classesroster-graphql-performance-issue"]
---

# GraphQL Over-Fetching

Over-fetching in GraphQL occurs when a query requests fields that the consuming component does not need, resulting in larger payloads, slower responses, and unnecessary database load.

## Symptoms

- Dropdowns or lists taking 5+ seconds to populate
- Queries returning thousands of nested records that are never rendered
- Multiple sequential round-trips due to pagination when a single request would suffice

## Common Causes

### 1. Reusing Heavy Queries for Simple UI

A query designed for a detail view (with nested users, roles, sites) is reused for a dropdown that only needs `id` and `name`.

### 2. Missing Filter Parameters

Backend supports filtering (e.g., `siteIds`) but frontend never passes them, fetching all records and filtering client-side.

### 3. Over-Pagination

Fetching 100 records at a time when the backend supports 5000, causing multiple sequential round-trips.

### 4. `network-only` Fetch Policy

Disabling cache means every visit re-fetches everything, even when data hasn't changed.

## Solutions

### Create Purpose-Built Queries

```graphql
# Heavy — for detail view
query ClassDetail($id: ID!) {
  class(id: $id) {
    id name section
    users { id firstName lastName roles { name } }
    owner { id firstName lastName }
  }
}

# Light — for dropdown
query ClassesForDropdown($filter: ClassesFilterInput) {
  classes(first: 5000, classesFilterInput: $filter) {
    nodes { id name section owner { firstName lastName } }
  }
}
```

### Use Existing Light Queries

Often a lighter query already exists in the codebase (e.g., `allClassesBasicData`) — check before creating new ones.

### Leverage Backend Filters

```tsx
// Pass siteIds to scope the query
const classesData = useLazyLoadQuery(ClassesQuery, {
  filter: {
    haveAtLeastOneStudent: true,
    isActive: 'ACTIVE',
    siteIds: userSiteIds,  // Backend already supports this
  },
  first: 5000,
});
```

### Use `store-or-network` for Cache Hits

```tsx
{ fetchPolicy: 'store-or-network' }  // Use cache if available
```

## Case Study: ClassesRoster

| Problem | Impact | Fix |
|---------|--------|-----|
| `users` nested in query | 15,000 user records for dropdown | Use `allClassesBasicData` (no users) |
| Paginates 100/page | Multiple round-trips | `first: 5000` in one request |
| No `siteIds` filter | Fetches all classes | Pass `siteIds` from Redux user state |
| `network-only` policy | No caching | `store-or-network` |

## Related

- [[classesroster-graphql-performance-issue]] — Real-world over-fetching case study
- [[relay]] — Relay patterns for efficient data fetching
- [[data-colocation]] — Fragment composition for precise data needs
- [[frontend-performance]] — General web performance optimization
