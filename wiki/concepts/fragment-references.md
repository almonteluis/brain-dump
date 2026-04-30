---
description: Fragment references — Relay's opaque pointers to GraphQL data, enabling data masking and colocation
tags: ["relay", "graphql", "fragments", "data-fetching", "concept"]
created: 2026-04-23
---

# Fragment References

In Relay, a fragment reference is an opaque pointer that links a parent component's data to a child component's fragment. It's the mechanism that makes [[data-masking]] and [[data-colocation]] work.

## How It Works

```graphql
# Parent component query
query DashboardQuery {
  user(id: "123") {
    ...UserProfile_user  # This creates a fragment reference
    ...UserStats_user    # Another reference
  }
}

# Child component fragment
fragment UserProfile_user on User {
  name
  email
  avatarUrl
}
```

The parent spreads child fragments into its query. Relay compiler extracts each fragment's fields and generates TypeScript types. At runtime, the parent passes the fragment reference (not raw data) to the child via props.

## Key Properties

1. **Opaque** — Components can't peek into fragment references; they must declare what they need
2. **Type-safe** — Compiler generates exact types for each fragment's data
3. **Composable** — Fragments can reference other fragments (see [[fragment-composition]])
4. **Masked** — Each component sees only the data it declared (see [[data-masking]])

## Usage Pattern

```tsx
// Parent passes fragment reference
function Dashboard({ queryRef }) {
  const data = usePreloadedQuery(DashboardQuery, queryRef);
  return <UserProfile user={data.user} />;
}

// Child reads its fragment
function UserProfile({ user }) {
  const data = useFragment(UserProfile_user, user);
  // data has { name, email, avatarUrl } — type-safe
}
```

## Common Mistakes

- **Passing raw data instead of refs** — `user={data.user.name}` breaks the fragment contract
- **Forgetting `useFragment`** — Reading props directly bypasses Relay's data masking
- **Nested fragment spreads** — Keep fragments flat; use [[fragment-composition]] for parent-child patterns

## Related

- [[relay]] — Meta's React GraphQL framework
- [[data-masking]] — Why components can't see each other's data
- [[data-colocation]] — Keeping data declarations near usage
- [[fragment-composition]] — Parent-child fragment patterns
- [[relay-query-refactoring-guide]] — Migrating from multiple queries to fragment-based architecture
