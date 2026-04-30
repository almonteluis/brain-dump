---
description: GraphQL global object ID specification for Marvin — Node interface, node query, ID format, and nested pagination
tags: ["marvin", "graphql", "relay", "global-object-id", "node-interface"]
created: 2026-04-30
updated: 2026-04-30
sources: ["Global Object IDs - Marvin.md"]
---

## Global Object IDs

Marvin follows the [Relay Global Object ID specification](https://relay.dev/graphql/objectidentification.htm).

### Node Interface

All types other than payloads and inputs implement the `Node` interface:

```graphql
interface Node {
  id: ID!
}
```

This ensures every piece of data has an ID, but uniqueness must be enforced by the implementation.

### node Query

Every Relay-compliant service provides a `node` query that takes a single ID and returns the corresponding object:

```graphql
type Query {
  node(id: ID!): Node
}
```

Example usage:

```graphql
query getSection {
  node(id: "SectionNode:1") {
    id
    __typename
    ... on SectionNode {
      isActive
    }
  }
}
```

### ID Format

IDs are constructed as: **`<TypeName>:<primary_key>`**

Example: `SectionNode:42` for the row in the `sections` table with primary key 42.

**Design decision:** IDs are intentionally *not* base64-encoded. While the Relay server spec suggests opacity, Marvin opts for plain-text IDs because:
- They are already meaningful (type name + primary key)
- Plain text makes debugging and non-technical communication easier
- Base64 provides no value once the ID is known to be meaningful

### Global Uniqueness

Database primary keys (integer) are not unique across tables. Concatenating the type name ensures global uniqueness within the GraphQL service, enabling:
- Easier caching
- Refetching: querying `node(id: ...)` guarantees the same object

### Nested Pagination

The `node` query is essential for nested pagination. When you have paginated nested connections and need to fetch subsequent pages of a child connection independently, use the parent node's ID plus the child's pagination cursor:

```graphql
# Get page 2 of products for a specific brand
node(id: "BrandNode:123") {
  ... on BrandNode {
    products(after: "<cursor>", first: 2) {
      edges { node { name } }
    }
  }
}
```

Note: The `node` field will eventually be replaced with the `@lookup` directive.

### Serialization

Both server and client use .NET's `System.Text.Json.JsonSerializer` to cast objects with IDs in the format `<Type>Node:<Id>` to POCOs, where `Id` is an integer.

### See Also

- [[relay]] — Relay framework overview
- [[relay-connections]] — Connection pagination patterns
- [[graphql-service]] — Marvin GraphQL service
- [[graphql-schema]] — GraphQL schema definitions
