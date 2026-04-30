---
description: Data masking hides fragment data from components that don't explicitly declare it, enabling local reasoning and safe refactoring
tags: ["relay", "data-masking", "encapsulation", "local-reasoning", "concept"]
created: 2026-04-09
updated: 2026-04-09
sources: ["data-masking-in-relay.md", "fragment-references-relay.md"]
---

# Data Masking

Data masking means Relay hides fragment data from components that don't explicitly ask for it via `useFragment`. Even if the data was fetched as part of the query, it's invisible without the proper fragment declaration.

## The Problem It Solves

Without data masking, implicit dependencies form between components:

```tsx
// Parent fetches data
const data = useLazyLoadQuery(graphql`
  query { user { name, email, avatar } }
`);

// Child could accidentally depend on fields it didn't declare
function Child({ user }) {
  // If this starts using user.email, parent can never remove it!
  return <div>{user.name}</div>;
}
```

## The Solution

With data masking, components only see what they declare:

```tsx
// Child declares its own needs
function Child({ user }) {
  const data = useFragment(graphql`
    fragment Child_user on User {
      name
      // email can be added later without parent changes
    }
  `, user);
  return <div>{data.name}</div>;
}
```

## Benefits

| Benefit | Description |
|---------|-------------|
| Safe Refactoring | Remove fields knowing exactly what breaks |
| Local Reasoning | No need to trace parent queries |
| Self-Containment | Components work in any context |

## How It Works

Fragment references contain hidden metadata:
- `__id`: Which node to read
- `__fragments`: What fragments are available

The data stays opaque until `useFragment` extracts it.

## Related

[[relay]]
[[fragment-references]]
[[fragment-composition]]
[[local-reasoning]]
