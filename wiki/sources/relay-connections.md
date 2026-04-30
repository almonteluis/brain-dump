---
description: Relay connection specification for GraphQL pagination — edges, nodes, pageInfo, and cursor-based pagination
tags: ["marvin", "graphql", "relay", "pagination", "connections"]
created: 2026-04-30
updated: 2026-04-30
sources: ["Connections - Marvin.md"]
---

## Relay Connections

Connections are a standardized mechanism for handling pagination of large result sets in GraphQL, while also organizing information about how data types relate.

### Core Concept

In the Relay model, relationships between types are modeled as **connections** with **edges** and **nodes**:

- **Node** — The actual data object (e.g. `SkillNode`)
- **Edge** — The relationship between two nodes, can carry edge-specific properties (e.g. `state` on a student-skill edge)
- **Connection** — Contains the list of edges plus pagination metadata

### Type Definitions

```graphql
type PageInfo {
  hasNextPage: Boolean!
  hasPreviousPage: Boolean!
  startCursor: String
  endCursor: String
}

type SkillStateNodeConnection {
  edges: [SkillStateNodeEdge!]!
  pageInfo: PageInfo!
}

type SkillStateNodeEdge {
  node: SkillNode!
  state: SkillStateNode!
}
```

### Deviation from Relay Standard

Marvin deviates slightly: **edges within a connection must not be null**. If a resolver fails for any edge, the whole query fails. This forces triage rather than asking clients to handle incomplete data.

### Pagination Pattern

Cursor-based (not limit/offset):

1. Query for results
2. While `pageInfo.hasNextPage` is true:
3. Pass `pageInfo.endCursor` as the `after` parameter for the next query

### Avoid Nested Paginated Connections

Do not nest connections that must be paginated within a single query. There is no established pattern for passing multiple sets of pagination parameters (e.g. "3rd page of skills for the 2nd page of ladders").

### See Also

- [[connection-pattern-pagination]] — Cursor-based pagination in Relay
- [[global-object-ids]] — GraphQL global object identification
- [[query-filters]] — Server-side query filtering
- [[relay]] — Relay framework overview
- [[graphql-service]] — Marvin GraphQL service
