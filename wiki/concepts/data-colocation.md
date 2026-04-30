---
description: Data colocation is the principle of keeping data declarations near where the data is used, enabling local reasoning and reducing coupling
tags: ["relay", "graphql", "data-colocation", "architecture", "concept"]
created: 2026-04-08
updated: 2026-04-08
sources: ["relay-fragment-composition.md", "relay-uselazyload-to-usefragment-migration.md"]
---

# Data Colocation

Data colocation is the principle of keeping data declarations near where the data is used. In Relay, this means components declare their GraphQL fragments right alongside their component code.

## The Principle

**Traditional approach:**
- Data fetching at top level
- Props passed down through many layers
- Changes require modifying parent queries

**Colocated approach:**
- Each component declares its own data needs
- Parents include child fragments, pass refs
- Changes stay local to component

## In Practice

```tsx
// Component + its data needs together
const fragment = graphql`
  fragment UserAvatar_user on User {
    avatarUrl
    name
  }
`;

function UserAvatar({ $ref }) {
  const user = useFragment(fragment, $ref);
  return <img src={user.avatarUrl} alt={user.name} />;
}
```

## Benefits

- **Local reasoning** — Understand data needs by looking at component
- **Independent evolution** — Modify component without touching parents
- **Clear boundaries** — Each component owns its requirements
- **Type safety** — Generated types from colocated fragments

## Related

[[relay]]
[[fragment-composition]]
[[local-reasoning]]
