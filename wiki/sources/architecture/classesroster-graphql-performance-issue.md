---
description: ClassesRoster search bar 5+ second delay analysis — GraphQL over-fetching with 15,000 user records for a dropdown that only needs class names
tags: ["graphql", "relay", "performance", "over-fetching", "classesroster", "optimization"]
sources: ["2026-04-29-ClassesRoster-GraphQL-Performance-Issue.md"]
created: 2026-04-30
updated: 2026-04-30
---

# ClassesRoster Search Bar 5+ Second Delay

**Source:** `2026-04-29-ClassesRoster-GraphQL-Performance-Issue.md`
**Date ingested:** 2026-04-30
**Type:** research-note
**Date:** 2026-04-29
**Branch:** feature/new-student-ska
**Commit:** c8016ab4d
**Repository:** marvin

## Summary

The ClassesRoster dropdown takes 5+ seconds to show options. The root cause is not the search bar itself (which filters client-side) but the initial data fetch: `useGetClassesByRole` fetches ALL classes with nested `users` per class — 500 classes x 30 students = 15,000 user records for a dropdown that only needs class names.

## Root Cause

### Heavy Query (The Culprit)

`frontend/src/graphQLOperations/Classes.ts:107-157` — `ClassesGetAllQuery`

```graphql
query ClassesGetAllQuery($filter: ClassesFilterInput, $cursor: String) {
  classes(classesFilterInput: $filter, first: 100, after: $cursor) {
    nodes {
      id name section site { ... } gradeLevels { ... } isActive
      users {            # MASSIVE — never used by dropdown
        id firstName lastName isActive
        roles { name }
        sites { id name }
        classes { name }
        gradeLevels { name id }
      }
      owner { ... }
      externalSync { source }
    }
    pageInfo { endCursor }
  }
}
```

The `users` field is only needed when `ClassesRosterRightSide` fetches a single class via `classById`. The dropdown never reads it.

### Additional Problems

1. **Paginates 100/page** — Multiple sequential round-trips
2. **No siteIds filter** — Hook passes `{ haveAtLeastOneStudent, isActive }` only, never `siteIds`
3. **`network-only` fetch policy** — No caching benefit on repeat visits

## Light Query Already Exists

`frontend/src/graphQLOperations/Classes.ts:159-193` — `allClassesBasicData`

```graphql
query ClassesGetAllBasicDataQuery(
  $filter: ClassesFilterInput
  $cursor: String
  $first: Int = 100
) {
  classes(first: $first, after: $cursor, classesFilterInput: $filter) {
    nodes {
      id name section
      site { id name }
      gradeLevels { name id }
      isActive
      owner { id firstName lastName }
      externalSync { source }
    }
    pageInfo { endCursor }
  }
}
```

No `users`. 90%+ smaller payload. Already used by `MonitoringCommonFilters.tsx:55`.

## How MonitoringCommonFilters Does It Better

`MonitoringCommonFilters.tsx:54-59` fetches 5000 at once:

```tsx
const classesData = isAdmin
  ? useLazyLoadQuery<ClassesGetAllBasicDataQuery>(
      allClassesBasicData,
      { cursor: null, first: 5000 },    // ONE request, up to 5000
      { fetchPolicy: 'network-only' },
    )
```

Backend supports `MaxPageSize = 5000` (`Query.Class.cs:17`).

## Backend Site Filtering Already Works

`ClassesFilterInput.cs:6-10` already has `siteIds`:

```csharp
public record ClassesFilterInput(
    ActiveRecords IsActive = ActiveRecords.Active,
    bool? HaveAtLeastOneStudent = null,
    [property: ID(nameof(Site))] IEnumerable<int>? SiteIds = null);
```

Frontend never passes it. Backend resolver already applies it.

## Role-Based Access (Already Scoped)

| Role | Class Read Permission |
|------|----------------------|
| InternalAdmin | `All` — all classes |
| NetworkAdmin | `Own` + `AssociatedViaSite` — their sites only |
| SiteAdmin | `Own` + `AssociatedViaSite` — their sites only |
| Teacher | `Own` + `AssociatedViaClass` — their classes only |

NetworkAdmin/SiteAdmin already filtered to their sites at DB level.

## Recommended Fix (Option 4: All Combined)

```tsx
const userSiteIds = userRedux?.sites
  ?.filter(s => s?.id)
  ?.map(s => parseInt(s.id.split(':')[1]));

const classesData = isAdmin
  ? useLazyLoadQuery<ClassesGetAllBasicDataQuery>(
      allClassesBasicData,
      {
        filter: {
          haveAtLeastOneStudent: classHasStudents,
          isActive: 'ACTIVE',
          siteIds: userSiteIds,
        },
        first: 5000,
        cursor: null,
      },
      { fetchPolicy: storeOrNetworkPolicy ? 'store-or-network' : 'network-only' },
    )
```

Single lightweight request scoped to user's sites.

## Recommended Changes (Priority Order)

1. **High**: Change `fetchPolicy` from `network-only` to `store-or-network`
2. **High**: Remove `disabled={!allClassesLoaded}` from `AutoComplete`, use `loading` prop
3. **High**: Fetch `first: 5000` in one request (no pagination)
4. **Medium**: Add `siteIds` filter for scoped admin queries
5. **Medium**: Create `classesForDropdown` minimal query
6. **Low**: Split `classById` into metadata + deferred users query

## Files to Change

| File | Change |
|------|--------|
| `frontend/src/custom-hooks/useGetClassesByRole.ts` | Add `siteIds`, `first: 5000`. Verify light query path. |
| `frontend/src/pages/ClassesRosters.tsx` | May need to pass user sites to hook. |

## Open Questions

- Redux `user.sites` IDs in `SiteNode:123` format? Need verify before parse.
- NetworkAdmin with 10 sites — want all sites or single site select?
- `network-only` policy intentional? `store-or-network` would cache repeat visits.
- Does `ClassesRosters.tsx:24` calling `useGetClassesByRole(true)` actually hit `allClassesBasicData` path?

## Related

- [[relay]] — Relay GraphQL framework patterns
- [[graphql-over-fetching]] — General over-fetching patterns and solutions
- [[frontend-performance]] — Web performance optimization
- [[data-colocation]] — Relay fragment and query patterns

## Concepts Covered

- [[graphql]] — Query design and optimization
- [[relay]] — useLazyLoadQuery patterns and fetch policies
- [[performance]] — Identifying and fixing over-fetching
- [[pagination]] — Batch fetching vs sequential round-trips
