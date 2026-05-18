---
description: "Full-stack GraphQL workshop with .NET/Hot Chocolate backend and React/Relay frontend — patterns, DataLoader, mutations, subscriptions, CQRS"
tags: [software-engineering, graphql, relay, dotnet, react, workshop]
sources: [fullstack-graphql-workshop.md, graphql-workshop-summary.md]
created: 2026-04-09
updated: 2026-04-21
---

# Fullstack GraphQL Workshop

**Source:** graphql-workshop-summary.md (enriched from original)
**Date ingested:** 2026-04-09 (updated 2026-04-21)
**Type:** Technical workshop reference

## Summary

Comprehensive fullstack GraphQL workshop covering .NET/Hot Chocolate backend and React/Relay frontend. Includes DataLoader pattern, Connection pagination, mutations with error handling, subscriptions, and architecture patterns (CQRS + DDD + distributed GraphQL).

## Technology Stack

### Backend
- **.NET 8 / ASP.NET Core 8** - Web framework
- **Hot Chocolate** - GraphQL server for .NET
- **Entity Framework Core** - ORM
- **Open Telemetry** - Observability

### Frontend
- **React** - UI library
- **TypeScript** - Type-safe JavaScript
- **Relay** - GraphQL client for React

## Server-Side Patterns

### DataLoader Pattern (N+1 Solution)
Batches multiple requests into one query. Critical for production GraphQL APIs.

```csharp
public class UserBatchDataLoader : DataLoaderBase<int, User>
{
    protected override async Task<IReadOnlyDictionary<int, User>> LoadBatchAsync(
        IReadOnlyList<int> keys, CancellationToken ct)
    {
        var users = await _context.Users
            .Where(u => keys.Contains(u.Id))
            .ToListAsync(ct);
        return users.ToDictionary(u => u.Id);
    }
}
```

### Connection Pattern (Pagination)
Standardized cursor-based pagination across all list fields.

```graphql
type UserConnection {
  edges: [UserEdge!]!
  pageInfo: PageInfo!
  totalCount: Int!
}
```

### Mutation Pattern
Consistent structure with input/payload/error types.

```graphql
type Mutation {
  createUser(input: CreateUserInput!): CreateUserPayload!
}
type CreateUserPayload {
  user: User
  errors: [UserError!]!
}
```

### Subscription Pattern
Real-time updates via WebSocket.

```graphql
type Subscription {
  userCreated: User!
  postUpdated: Post!
}
```

## Relay Client Patterns

### Fragment Composition
Co-locate data requirements with components.

```javascript
const userFragment = graphql`
  fragment UserProfile_user on User {
    id name email
  }
`;
```

### Optimistic Updates
Update UI before server confirms.

```javascript
optimisticResponse: {
  updateUser: { user: { id: user.id, name } }
}
```

### Pagination with @connection
Efficient cursor-based loading in Relay.

```graphql
fragment UserList_user on User
@argumentDefinitions(count: {type: "Int!", defaultValue: 10}, cursor: {type: "String"})
@refetchable(queryName: "UserListPaginationQuery") {
  posts(first: $count, after: $cursor)
    @connection(key: "UserList_posts") {
    edges { node { id title } }
    pageInfo { hasNextPage endCursor }
  }
}
```

## Architecture Patterns

| Pattern | Use Case |
|---------|----------|
| Simple Layering | API → Business Logic → Data Access → DB |
| Distributed GraphQL | Microservices (Schema Stitching/Federation) |
| CQRS + DDD | Complex domains (queries = read, mutations = write) |

## Best Practices

**Server:** DataLoader everywhere, Connection pattern for all lists, consistent error handling, Open Telemetry for monitoring, schema versioning.

**Client:** Fragments for co-location, optimistic updates for UX, prefetch on hover, TypeScript for safety, one query per route.

**Key metrics to track:** Query latency, field resolver time, error rates, most used/unused fields.

## Concepts Covered

- [[relay]] — Client-side framework
- [[fragment-composition]] — Parent-child fragment patterns
- [[data-masking]] — Hiding data from non-declaring components
- [[connection-pattern-pagination]] — Cursor-based pagination
