---
description: GraphQL query filter pattern — conjunctive filters, comparison operators, and design rationale
tags: ["marvin", "graphql", "filter", "query", "pattern"]
created: 2026-04-30
updated: 2026-04-30
sources: ["Query Filters - Marvin.md"]
---

## Query Filters

Pattern for implementing server-side filtering of GraphQL query results. There is no published standard for this — it is a team-designed convention.

### Design Goals

1. Simple set of **conjunctive ("and")** filters in any combination
2. Allow filter conditions **other than simple equality**
3. Clearly **separate optional filters** from required parameters
4. **Query signature stability** — does not change when new filters are added

Notably: **no disjunctions ("or")** are supported. Run multiple queries if multiple data sets are needed.

### Pattern

Given a query `foo`:

1. Add an optional (nullable) parameter `filter`
2. Type of `filter` is `FooFilterInput`
3. `FooFilterInput` has multiple attributes, all optional (nullable)
4. For comparisons other than equality, append `_<comparison>` to the attribute name

### Example

```graphql
query allBirds(filter: {family: "Trochilidae", wingspan_lt: 5}) {
  edges {
    node {
      commonName
      binomen
      canFly
      wingspan
    }
  }
}
```

Schema:

```graphql
type Query {
  allBirds(
    filter: AllBirdsFilterInput
    before: String
    after: String
    first: Int
    last: Int
  ): BirdNodeConnection
}

type AllBirdsFilterInput {
  family: String
  wingspan_lt: Int
  canFly: Boolean
}
```

### Mandatory Parameters

Some queries have **mandatory parameters** (e.g. `skillAssessmentsByStudentId` requiring `studentId`). These must be **top-level query parameters**, not inside the filter object. They are identifiable by being in the query name ("by such and such").

### Connection Integration

Filter inputs work alongside [[relay-connections|connection]] pagination parameters (`before`/`after`/`first`/`last`).

### See Also

- [[relay-connections]] — Connection pagination patterns
- [[global-object-ids]] — Global object identification
- [[graphql-service]] — Marvin GraphQL service
- [[querying-graphql]] — GraphQL query fundamentals
