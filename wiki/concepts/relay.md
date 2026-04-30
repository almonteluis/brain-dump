---
description: Relay is a React framework for data management and fetching with a GraphQL client that emphasizes data colocation, type safety, and efficient batching
tags: ["relay", "graphql", "react", "data-fetching", "concept"]
created: 2026-04-08
updated: 2026-04-08
sources: ["relay-fragment-composition.md", "relay-fragment-naming-and-typing.md", "relay-mutations-guide.md", "relay-uselazyload-to-usefragment-migration.md"]
---

# Relay

Relay is Meta's React framework for building data-driven applications with GraphQL. It emphasizes **data colocation** — components declare their data needs right where they use the data.

## Core Principles

1. **Data Colocation** — Components own their data requirements
2. **Fragment Composition** — Parent components compose child fragments
3. **Type Safety** — Generated TypeScript types from GraphQL schema
4. **Efficient Batching** — Single request for entire component tree

## Key APIs

### useLazyLoadQuery
For root-level data fetching and page initialization.

### useFragment
For child component data — components declare their own fragments.

### useMutation
For GraphQL mutations with optimistic updates and store management.

## Fragment Pattern

```tsx
// Component declares its data needs
const fragment = graphql`
  fragment ComponentName_data on Type {
    field1
    field2
  }
`;

function Component({ $ref }) {
  const data = useFragment(fragment, $ref);
  return <div>{data.field1}</div>;
}
```

## Naming Convention

Pattern: `{ComponentName}_{propName} on {Type}`

Generated type: `{ComponentName}_{propName}$key`

## Mutation Directives

| Directive | Purpose |
|-----------|---------|
| `@appendNode` | Add to end of connection |
| `@prependNode` | Add to front of connection |
| `@deleteRecord` | Remove item |
| `@prependEdge` | Add edge with cursor |

## Topics

| Topic | Page |
|-------|------|
| Fragment composition | [[relay-fragment-composition]] |
| Fragment naming and typing | [[relay-fragment-naming-and-typing]] |
| Fragment references | [[fragment-references-relay]] |
| Data masking | [[data-masking-in-relay]] |
| Mutations and optimistic updates | [[relay-mutations-guide]] |
| Subscriptions | [[relay-subscriptions-guide]] |
| Pagination / connections | [[connection-pattern-pagination]] |
| @alias directive | [[relay-alias-directive]] |
| Environment and network layer | [[relay-environment-setup]] |
| Compiler and build setup | [[relay-compiler-build-setup]] |
| useLazyLoadQuery → useFragment migration | [[relay-uselazyload-to-usefragment-migration]] |
| Query refactoring (multiple queries → fragments) | [[relay-query-refactoring-guide]] |
| Redux vs Relay architecture | [[redux-vs-relay]] |
| Relay ESLint rules | [[clawdbot-relay-eslint-rules]] |

## Related

[[graphql]]
[[react]]
[[fragment-composition]]
[[data-colocation]]
[[relay-overview]] — Official documentation summary
[[relay-fragments]] — Fragment patterns reference
[[classesroster-graphql-performance-issue]] — Real-world performance case study with useLazyLoadQuery
[[graphql-over-fetching]] — Query optimization patterns
[[hot-chocolate-graphql]] — NC's .NET GraphQL server framework
[[graphql-service]] — NC core GraphQL service
