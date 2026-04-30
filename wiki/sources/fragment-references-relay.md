---
description: "Fragment references as opaque pointers to GraphQL data"
tags: ["source", "relay", "fragment-references", "graphql", "data-fetching"]
sources: ["fragment-references-relay.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Fragment References in Relay

**Source:** raw/02_reference/approaches/fragment-references-relay.md
**Date ingested:** 2026-04-09
**Type:** Technical guide

## Summary

Fragment references (or fragment keys) are opaque objects Relay uses to read data. They specify WHERE in the graph to read, not WHAT to read, enabling data masking and component isolation.

## Key Claims

- Fragment refs are opaque objects containing hidden metadata
- They specify WHERE to read, not WHAT to read
- Created where fragments are spread in queries
- Generated types use `$key` suffix (e.g., `UserComponent_user$key`)

## Anatomy of a Fragment Reference

```tsx
// Looks like empty object
const fragmentRef = data.user;  // { }

// Contains hidden fields:
// - __id: "client:123"           // Which node to read
// - __fragments: [UserFragment]  // What fragments are available
```

## Creating Fragment References

### From a Query
```tsx
const data = usePreloadedQuery(
  graphql`
    query AppQuery {
      user(id: $id) {
        ...UserComponent_user  // Creates fragment ref
      }
    }
  `,
  queryRef
);
// data.user IS the fragment reference
```

### From Another Fragment
```tsx
const user = useFragment(
  graphql`
    fragment Parent_user on User {
      name
      ...Child_user  // Creates fragment ref
    }
  `,
  userRef
);
// user IS the fragment reference for Child_user
```

## Type Safety

```tsx
import type { UserComponent_user$key } from './UserComponent_user.graphql';

type Props = {
  user: UserComponent_user$key;  // Fragment ref type
};
```

## Fragment Refs vs Data

| Concept | What | Where |
|---------|------|-------|
| **Fragment Reference** | Pointer to graph location | Passed as props |
| **Data** | Actual field values | Returned by useFragment |

## Entities Mentioned

- [[relay]] — GraphQL client framework

## Concepts Covered

- [[fragment-references]] — Opaque pointers to graph nodes
- [[data-masking]] — Why refs hide data until extracted
- [[type-safety]] — Generated `$key` types
