---
description: "Relay GraphQL fragments official documentation summary"
tags: ["source", "relay", "graphql", "fragments", "data-fetching"]
sources: ["Relay GraphQL Fragments.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Relay GraphQL Fragments

**Source:** raw/00_inbox/Links/Relay GraphQL Fragments.md
**Original:** https://relay.dev/docs/tutorial/fragments-1/
**Date ingested:** 2026-04-09
**Type:** Documentation

## Summary

Official Relay documentation on fragments — the distinguishing feature that lets each component declare its own data needs independently while retaining single-query efficiency. Covers fragment references, data masking, and composition patterns.

## Key Claims

- Fragments let components declare data needs independently
- Parent queries spread child fragments for single-query efficiency
- Fragment refs are opaque — specify WHERE to read, not WHAT
- Data masking enforces local reasoning (components only see their own data)
- ESLint rules enforce proper fragment usage

## The Fragment Pattern

### 1. Define Fragment in Component
```tsx
const UserFragment = graphql`
  fragment UserFragment on User {
    name
    profile_picture(scale: 2) {
      uri
    }
  }
`;
```

### 2. Spread in Parent Query
```tsx
const query = graphql`
  query AppQuery {
    user {
      ...UserFragment
    }
  }
`;
```

### 3. Read with useFragment
```tsx
function User({ user }: { user: UserFragment$key }) {
  const data = useFragment(UserFragment, user);
  return <h1>{data.name}</h1>;
}
```

## Key Concepts

### Fragment References (Fragment Keys)
- Opaque objects containing hidden fields
- Tell Relay: which node, where to read, what fields available
- **Specify WHERE, not WHAT**

### Data Masking
- Relay hides fragment data from components that don't explicitly ask
- Enforces local reasoning
- Changes don't ripple unpredictably

### Fragment Composition
- Fragments can include other fragments
- Parent components spread child fragments
- Enables reusable, self-contained components

### Fragment Arguments
- Runtime flexibility via `@argumentDefinitions`
- Used at spread time with `@arguments`

## Benefits

| Benefit | Description |
|---------|-------------|
| Self-contained | Components declare own data needs |
| Reusable | Same fragment in different contexts |
| No unused fields | ESLint enforces field usage |
| Type-safe | Generated types for refs and data |
| Auto-updates | Components subscribe to changes |
| Scalable | Modify without changing parents |

## ESLint Rules

- `unused-fields` — Error when queried fields aren't used
- `must-colocate-fragment-spreads` — Error when fragments not co-located

## Related

- [[relay]] — Meta's React GraphQL framework
- [[fragment-composition]] — Parent-child fragment patterns
- [[data-masking]] — Why fragment refs are opaque
- [[fragment-references]] — Using fragment keys in components
