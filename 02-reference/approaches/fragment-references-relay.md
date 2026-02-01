---
description: Fragment references (or fragment keys) are opaque objects Relay uses to read data — they specify WHERE in the graph to read, not WHAT to read, enabling data masking and component isolation.
tags: ["relay", "fragment-references", "graphql", "data-fetching"]
created: 2026-01-29
---

# Fragment References in Relay

## What is a Fragment Reference?

A fragment reference is an **opaque object** that Relay uses to read data declared in a fragment definition.

Think of it as: **A pointer to a specific instance of a type that we want to read data from.**

## Anatomy of a Fragment Reference

```tsx
// The fragment ref looks like an empty object
const fragmentRef = data.user;  // { }

// But it contains hidden fields:
// - __id: "client:123"           // Which node to read
// - __fragments: [UserFragment]  // What fragments are available
```

The fragment reference is created at the point where the fragment is spread in a query.

## Creating Fragment References

### From a Query

```tsx
const data = usePreloadedQuery(
  graphql`
    query AppQuery {
      user(id: $id) {
        ...UserComponent_user  # This creates a fragment ref
      }
    }
  `,
  queryRef
);

// data.user IS the fragment reference for UserComponent_user
<UserComponent user={data.user} />
```

### From Another Fragment

```tsx
const user = useFragment(
  graphql`
    fragment Parent_user on User {
      name
      ...Child_user  # This creates a fragment ref
    }
  `,
  userRef
);

// user IS the fragment reference for Child_user
<ChildComponent user={user} />
```

## Type Safety with Fragment References

Relay generates types for fragment references:

```tsx
import type { UserComponent_user$key } from './UserComponent_user.graphql';

type Props = {
  user: UserComponent_user$key;  // Fragment ref type
};
```

The `$key` suffix indicates this is a **fragment reference type**, not the data type.

## Reading Fragment References

### useFragment (React render phase)

```tsx
function UserComponent({ user }: UserComponent_user$key) {
  const data = useFragment(
    graphql`
      fragment UserComponent_user on User {
        name
        profile_picture(scale: 2) { uri }
      }
    `,
    user  // Pass fragment ref
  );

  // data is now the actual data: { name: string, profile_picture: ... }
  return <h1>{data.name}</h1>;
}
```

### readInlineData (Outside React render)

```graphql
fragment Logger_user on User @inline {
  customerId
  metadata
}
```

```tsx
let logPurchase = (user) => {
  // Read data outside render phase
  const userData = Logger_user.readInline(user);

  LoggingService.log({
    customerId: userData.customerId,
    metadata: userData.metadata
  });
};
```

## Fragment References vs Data

| Concept | What | Where |
|---------|------|-------|
| **Fragment Reference** | Pointer to graph location | Passed as props |
| **Data** | Actual field values | Returned by useFragment |

## Common Pattern: Multiple Fragments on Same Object

```tsx
type Props = {
  user: UserComponent_user$key;  // Fragment ref
  viewer: UserComponent_viewer$key;  // Another fragment ref
};

function UserComponent(props: Props) {
  const userData = useFragment(UserFragment, props.user);
  const viewerData = useFragment(ViewerFragment, props.viewer);

  return (
    <>
      <h1>{userData.name}</h1>
      <div>Acting as: {viewerData.actor?.name}</div>
    </>
  );
}
```

## Key Points

1. Fragment refs are created where fragments are spread
2. They contain hidden metadata about WHERE and WHAT to read
3. They're passed between components as opaque objects
4. `useFragment` exchanges the ref for actual data
5. Generated types ensure correct fragment refs are passed

---

## Related

[[Data Masking in Relay]]
[[Relay GraphQL Fragments]]
[[Relay Fragment Composition]]
