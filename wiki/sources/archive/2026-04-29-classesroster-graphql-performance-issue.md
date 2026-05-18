---
description: "2026-04-29-ClassesRoster-GraphQL-Performance-Issue"
tags: ['research']
raw_file: "2026-04-29-ClassesRoster-GraphQL-Performance-Issue.md"
created: 2026-05-17
---

# ClassesRoster Search Bar 5+ Second Delay

**Date**: 2026-04-29  
**Branch**: feature/new-student-ska  
**Commit**: c8016ab4d

## Problem

Dropdown takes 5+ seconds to show options. User waits after page load before `AutoComplete` enables.

## Root Cause

Not search bar -- search filters client-side, no GraphQL on type. Delay = initial data fetch. `useGetClassesByRole` fetches ALL classes with `users` nested per class. 500 classes x 30 students = 15,000 user records for a dropdown that only needs class names.

## Data Flow

```
ClassesRosters.tsx:24
  -> useGetClassesByRole(true)
     -> admin: useLazyLoadQuery(allClasses, ...)   // HEAVY
     -> teacher: useLazyLoadQuery(classesByTeacherId, ...)
     -> paginates 100/page, network-only
     -> allClassesLoaded = true when done
  -> ClassesRosterLeftSide (classesData=allClassesData)
     -> maps to classesList with sectionName
     -> AutoComplete (suggestions=filteredClassesList)
        -> searchClasses() = client-side filter
```

## Search Bar (No GraphQL)

`frontend/src/components/ClassesRoster/ClassesRosterLeftSide.tsx:89-99`

```tsx
const searchClasses = (event: AutoCompleteCompleteEvent) => {
  let _filteredClass;
  if (!event.query.trim().length) {
    _filteredClass = [...classesList];
  } else {
    _filteredClass = classesList.filter(x =>
      x?.sectionName?.toLowerCase().includes(event.query.toLowerCase())
    );
  }
  setFilteredClassesList(_filteredClass);
};
```

AutoComplete at line 144: `completeMethod={searchClasses}`. Pure string filter. No network.

## Heavy Query (The Culprit)

`frontend/src/graphQLOperations/Classes.ts:107-157`

```graphql
query ClassesGetAllQuery($filter: ClassesFilterInput, $cursor: String) {
  classes(classesFilterInput: $filter, first: 100, after: $cursor) {
    nodes {
      id name section site { ... } gradeLevels { ... } isActive
      users {            # MASSIVE -- never used by dropdown
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

`users` field only needed when `ClassesRosterRightSide` fetches single class via `classById`. Dropdown never reads it.

## Light Query (Already Exists)

`frontend/src/graphQLOperations/Classes.ts:159-193` -- `allClassesBasicData`

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

## Why Still Slow Even With Light Query

Two more problems:

1. **Paginates 100/page**. Multiple sequential round-trips.
2. **No siteIds filter**. Hook passes `{ haveAtLeastOneStudent, isActive }` only. Never `siteIds`.

## How MonitoringCommonFilters Does It Better

`frontend/src/components/Monitoring/MonitoringCommonFilters.tsx:54-59`

```tsx
const classesData = isAdmin
  ? useLazyLoadQuery<ClassesGetAllBasicDataQuery>(
      allClassesBasicData,
      { cursor: null, first: 5000 },    // ONE request, up to 5000
      { fetchPolicy: 'network-only' },
    )
```

Backend supports `MaxPageSize = 5000` (`Query.Class.cs:17`). Fetch all at once.

## Backend Site Filtering Already Works

`shared/Nc.Shared/Filters/ClassesFilterInput.cs:6-10`

```csharp
public record ClassesFilterInput(
    ActiveRecords IsActive = ActiveRecords.Active,
    bool? HaveAtLeastOneStudent = null,
    [property: ID(nameof(Site))] IEnumerable<int>? SiteIds = null);
```

`siteIds` exists. Frontend never passes it.

Backend resolver applies it:

`graphql-service/Nc.GraphQL.Service/Schema/Queries/Query.Class.cs:42-44`

```csharp
.Where(c =>
    (classesFilterInput.SiteIds == null
        || classesFilterInput.SiteIds.Contains(c.Site.Id))
)
```

## Role-Based Access (Backend Already Scopes)

From `UserManagerService.cs`:

| Role | Class Read Permission |
|------|----------------------|
| InternalAdmin | `All` -- all classes |
| NetworkAdmin | `Own` + `AssociatedViaSite` -- their sites only |
| SiteAdmin | `Own` + `AssociatedViaSite` -- their sites only |
| Teacher | `Own` + `AssociatedViaClass` -- their classes only |

`RelationshipChecker.cs:197-207`:

```csharp
PermissionRelationship.AssociatedViaSite =>
    c => c.Site.UserSites.Any(us => us.IsActive && us.User.PublicUserId == requestingUserSub)
```

NetworkAdmin/SiteAdmin already filtered to their sites at DB level. Passing `siteIds` frontend-side adds extra narrow for multi-site NetworkAdmins.

## Fix Options

### Option 1: Switch to allClassesBasicData

`frontend/src/custom-hooks/useGetClassesByRole.ts:43-54`

Current:
```tsx
const classesData = isAdmin
  ? onlyClasses
    ? useLazyLoadQuery<ClassesGetAllBasicDataQuery>(allClassesBasicData, ...)  // light
    : useLazyLoadQuery<ClassesGetAllQuery>(allClasses, ...)                   // heavy
```

`ClassesRosters.tsx:24` passes `useGetClassesByRole(true)` so `onlyClasses=true`. Should already hit light query. Verify this path works -- if somehow hitting heavy query, fix hook.

### Option 2: Fetch 5000 at once (no pagination)

Change `useGetClassesByRole.ts:47`:

```tsx
// BEFORE: paginates 100 at a time
{ filter: { ... }, cursor },

// AFTER: one request
{ filter: { ... }, first: 5000, cursor: null },
```

Or follow `MonitoringCommonFilters` pattern:
```tsx
{ cursor: null, first: 5000 }
```

### Option 3: Add siteIds filter

`useGetClassesByRole.ts` change:

```tsx
// BEFORE
{ filter: { haveAtLeastOneStudent: classHasStudents, isActive: 'ACTIVE' }, cursor }

// AFTER
{
  filter: {
    haveAtLeastOneStudent: classHasStudents,
    isActive: 'ACTIVE',
    siteIds: userRedux?.sites?.map(s => parseInt(s.id.split(':')[1])),
  },
  first: 5000,
  cursor: null,
}
```

Note: `siteIds` expects `int[]`. Redux site IDs are `SiteNode:123` format. Need `split(':')[1]` + `parseInt`.

### Option 4: All fixes combined (recommended)

`frontend/src/custom-hooks/useGetClassesByRole.ts` -- admin branch:

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

## Files to Change

| File | Change |
|------|--------|
| `frontend/src/custom-hooks/useGetClassesByRole.ts` | Add `siteIds`, `first: 5000`. Verify light query path. |
| `frontend/src/pages/ClassesRosters.tsx` | May need to pass user sites to hook. |

## Files for Reference (No Change)

| File | Why |
|------|-----|
| `frontend/src/graphQLOperations/Classes.ts:159` | `allClassesBasicData` already exists -- use it |
| `frontend/src/components/Monitoring/MonitoringCommonFilters.tsx:54-59` | Working example of `first: 5000` pattern |
| `shared/Nc.Shared/Filters/ClassesFilterInput.cs:9` | `siteIds` param already exists |
| `graphql-service/Nc.GraphQL.Service/Schema/Queries/Query.Class.cs:17` | `MaxPageSize = 5000` already set |

## Split Query Architecture (Additional Approach)

Beyond the Option 4 fix above, consider splitting the query into two independent fetches:

```
┌─────────────────────────────────────────────────────────────┐
│  ClassesRosters Page                                        │
│                                                             │
│  ┌─────────────────────┐    ┌──────────────────────────┐   │
│  │ LeftSide (Search)   │    │ RightSide (Detail)       │   │
│  │                     │    │                          │   │
│  │ AutoComplete        │───▶│ classById (deferred)     │   │
│  │  - instant          │    │  - loads after selection │   │
│  │  - small payload    │    │  - full user data        │   │
│  └─────────────────────┘    └──────────────────────────┘   │
│           │                                                 │
│           ▼                                                 │
│  ┌─────────────────────┐                                    │
│  │ classesForDropdown  │  ← minimal: id, name, section,     │
│  │  - id, name, section│    owner name only                 │
│  │  - owner name       │                                    │
│  └─────────────────────┘                                    │
└─────────────────────────────────────────────────────────────┘
```

### New Query: `classesForDropdown`

Even lighter than `allClassesBasicData` -- drop `site`, `gradeLevels`, `externalSync`:

```graphql
query ClassesForDropdownQuery(
  $filter: ClassesFilterInput
  $first: Int = 5000
) {
  classes(first: $first, classesFilterInput: $filter) {
    nodes {
      id
      name
      section
      owner {
        id
        firstName
        lastName
      }
    }
  }
}
```

### Split `classById` into Two Queries

**Part A -- Metadata (immediate on selection):**
```graphql
query ClassMetadataQuery($classId: ID!) {
  class(classId: $classId) {
    id
    name
    section
    site { id, name }
    gradeLevels { name, id }
    owner { id, firstName, lastName }
    externalSync { source }
  }
}
```

**Part B -- Users (deferred / streamed):**
```graphql
query ClassUsersQuery($classId: ID!) {
  class(classId: $classId) {
    users {
      id
      firstName
      lastName
      isActive
      roles { name }
      studentTargetGroups {
        id
        isCurrent
        targetGroup { id, name }
      }
      userClasses { isActive, class { id, name, section } }
    }
  }
}
```

### Updated Hook with Deferred Query

```typescript
// useGetClassesByRole.ts -- return immediately, stream results
export const useGetClassesByRole = (
  onlyClasses = false,
  storeOrNetworkPolicy = true,  // ← default cache-first
  classHasStudents: boolean | null = null,
) => {
  const userRedux = useAppSelector(selectUser);
  const [allClassesData, setAllClassesData] = useState<Class[]>([]);
  const [allClassesLoaded, setAllClassesLoaded] = useState<boolean>(false);
  const isAdmin = /* ... */;

  const userSiteIds = userRedux?.sites
    ?.filter(s => s?.id)
    ?.map(s => parseInt(s.id.split(':')[1]));

  const classesData = useLazyLoadQuery<ClassesForDropdownQuery>(
    classesForDropdown,
    {
      filter: {
        haveAtLeastOneStudent: classHasStudents,
        isActive: 'ACTIVE',
        siteIds: isAdmin ? userSiteIds : undefined,
      },
      first: 5000,
    },
    { fetchPolicy: storeOrNetworkPolicy ? 'store-or-network' : 'network-only' },
  );

  useEffect(() => {
    if (classesData?.classes?.nodes) {
      setAllClassesData(classesData.classes.nodes as Class[]);
      setAllClassesLoaded(true);
    }
  }, [classesData]);

  return { allClassesLoaded, allClassesData, isAdmin };
};
```

### Updated LeftSide: Remove `disabled`, Use Loading State

```tsx
// ClassesRosterLeftSide.tsx:144 -- replace disabled with loading
<AutoComplete
  placeholder="Choose a class"
  value={selectedClass}
  suggestions={sortClassesList(filteredClassesList).filter(c => c.id !== selectedClass?.id)}
  completeMethod={searchClasses}
  dropdown
  onChange={e => setSelectedClass(e.value)}
  className="flex-grow-1"
  field="sectionName"
  loading={!allClassesLoaded}  // ← loading spinner instead of disabled
  itemTemplate={element => element?.sectionName}
/>
```

## Recommended Changes (Priority Order)

1. **High**: Change `fetchPolicy` from `network-only` to `store-or-network`
2. **High**: Remove `disabled={!allClassesLoaded}` from `AutoComplete`, use `loading` prop
3. **High**: Fetch `first: 5000` in one request (no pagination)
4. **Medium**: Add `siteIds` filter for scoped admin queries
5. **Medium**: Create `classesForDropdown` minimal query
6. **Low**: Split `classById` into metadata + deferred users query

## Open Questions

- Redux `user.sites` IDs in `SiteNode:123` format? Need verify before parse.
- NetworkAdmin with 10 sites -- want all sites or single site select? (Current: fetches all then client-filters)
- `network-only` policy intentional? `store-or-network` would cache repeat visits.
- Does `ClassesRosters.tsx:24` calling `useGetClassesByRole(true)` actually hit `allClassesBasicData` path? Verify hook logic -- may have a bug routing to heavy query.
