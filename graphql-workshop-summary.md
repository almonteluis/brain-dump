# Fullstack GraphQL Workshop - Key Takeaways

Workshop covering GraphQL with ASP.NET Core/Hot Chocolate backend and React/Relay frontend.

---

## Tech Stack

### Backend
- **.NET 8 / ASP.NET Core 8**
- **Hot Chocolate** - GraphQL server for .NET
- **Entity Framework Core** - Database ORM
- **Open Telemetry** - Monitoring/observability

### Frontend
- **React** - UI framework
- **TypeScript** - Type-safe JavaScript
- **Relay** - GraphQL client for React

---

## GraphQL Server Patterns

### Core Concepts
- **Type System**: Strongly typed schema with types, inputs, enums, unions
- **Operations**: Query, Mutation, Subscription
- **Resolvers**: Functions that resolve field values
- **Schema-First or Code-First**: Approaches to building schemas

### Data Access Patterns

#### 1. Entity Framework Core Integration
```csharp
// Building APIs on top of EF Core
public class Query
{
    public IQueryable<User> GetUsers([Service] AppDbContext context) =>
        context.Users;
}
```

#### 2. Paging, Filtering, Sorting, Projections
- **Paging**: Skip/Take or cursor-based pagination
- **Filtering**: Where clauses on queryables
- **Sorting**: OrderBy expressions
- **Projections**: Select specific fields (avoid overfetching)

```graphql
query {
  users(first: 10, after: "cursor", orderBy: {name: ASC}) {
    edges {
      node {
        id
        name
        email
      }
    }
  }
}
```

#### 3. DataLoader Pattern
**Problem**: N+1 query problem (one query for parent + N queries for children)

**Solution**: Batch and cache related data in a single request

```csharp
// DataLoader batches multiple requests into one query
public class UserBatchDataLoader : DataLoaderBase<int, User>
{
    protected override async Task<IReadOnlyDictionary<int, User>> LoadBatchAsync(
        IReadOnlyList<int> keys,
        CancellationToken cancellationToken)
    {
        var users = await _context.Users
            .Where(u => keys.Contains(u.Id))
            .ToListAsync(cancellationToken);

        return users.ToDictionary(u => u.Id);
    }
}
```

---

## GraphQL Patterns

### 1. Entity Pattern
Standard structure for type definitions:

```graphql
type User {
  id: ID!
  name: String!
  email: String!
  posts: [Post!]!
}

type Post {
  id: ID!
  title: String!
  author: User!
  content: String
}
```

### 2. Connection Pattern (Pagination)
Standardized pagination structure:

```graphql
type UserConnection {
  edges: [UserEdge!]!
  pageInfo: PageInfo!
  totalCount: Int!
}

type UserEdge {
  node: User!
  cursor: String!
}

type PageInfo {
  hasNextPage: Boolean!
  hasPreviousPage: Boolean!
  startCursor: String
  endCursor: String
}
```

**Benefits:**
- Consistent pagination across all types
- Cursor-based for stability with inserts/deletes
- Metadata for infinite scroll

### 3. Mutation Pattern
Consistent structure for mutations:

```graphql
type Mutation {
  createUser(input: CreateUserInput!): CreateUserPayload!
  updateUser(input: UpdateUserInput!): UpdateUserPayload!
  deleteUser(input: DeleteUserInput!): DeleteUserPayload!
}

type CreateUserPayload {
  user: User
  errors: [UserError!]!
}

input CreateUserInput {
  name: String!
  email: String!
}

type UserError {
  field: [String!]!
  message: String!
}
```

**Benefits:**
- Consistent error handling
- Return both data and errors
- Type-safe inputs

### 4. Subscription Pattern
Real-time data updates:

```graphql
type Subscription {
  userCreated: User!
  postUpdated: Post!
}

# Client subscribes:
subscription {
  userCreated {
    id
    name
    email
  }
}
```

**Use cases:**
- Live feeds
- Notifications
- Real-time collaboration

---

## Architecture Patterns

### Simple Layering

```
┌─────────────────┐
│   GraphQL API   │  ← Schema & Resolvers
├─────────────────┤
│  Business Logic │  ← Services/Domain
├─────────────────┤
│ Data Access     │  ← Repositories/EF Core
├─────────────────┤
│   Database      │
└─────────────────┘
```

**Benefits:**
- Clear separation of concerns
- Testable layers
- Easy to maintain

### Distributed GraphQL
Multiple GraphQL services combined into one schema:

```
┌────────────────────────────────┐
│      GraphQL Gateway           │
│   (Schema Stitching/Federation)│
└────────────────────────────────┘
          ↓            ↓
┌─────────────┐  ┌─────────────┐
│  Users API  │  │ Posts API   │
└─────────────┘  └─────────────┘
```

**Use cases:**
- Microservices architecture
- Domain separation
- Team autonomy

### CQRS + DDD + GraphQL
- **CQRS**: Separate read and write operations
- **DDD**: Domain-driven design with bounded contexts
- **GraphQL**: Natural fit for CQRS (queries = read, mutations = write)

**Benefits:**
- Optimized read/write models
- Clear domain boundaries
- Type-safe communication between layers

---

## Schema Evolution

### Client Registry
Track which clients use which fields:

```json
{
  "client": "web-app-v1",
  "usedFields": ["User.id", "User.name"],
  "lastRequested": "2024-01-01"
}
```

### Schema Registry
Manage schema versions and deprecations:

- Track deprecated fields
- Warn clients before removal
- Version schemas for compatibility

### Open Telemetry Integration
Monitor GraphQL operations:

```csharp
services.AddGraphQLServer()
    .AddInstrumentation();  // Open Telemetry support
```

**Metrics to track:**
- Query latency
- Field resolver time
- Error rates
- Most used/unused fields

---

## Relay.js Patterns

### Core Concepts
- **Fragments**: Reusable data definitions
- **Container Components**: Data fetching + rendering
- **Query Renderer**: Execute queries at component mount
- **Mutation**: Update data on server + client

### 1. Query with Fragments

```javascript
import { graphql, useFragment } from 'react-relay';

const userFragment = graphql`
  fragment UserProfile_user on User {
    id
    name
    email
  }
`;

function UserProfile({ user }) {
  const data = useFragment(userFragment, user);
  return <div>{data.name} - {data.email}</div>;
}
```

**Benefits:**
- Co-locate data requirements with components
- Collected by Relay into single query
- Type-safe with TypeScript

### 2. Query Renderer

```javascript
import { QueryRenderer, graphql } from 'react-relay';

const query = graphql`
  query AppQuery($userId: ID!) {
    user(id: $userId) {
      ...UserProfile_user
    }
  }
`;

function App({ userId }) {
  return (
    <QueryRenderer
      query={query}
      variables={{ userId }}
      render={({ error, props }) => {
        if (error) return <div>Error!</div>;
        if (!props) return <div>Loading...</div>;
        return <UserProfile user={props.user} />;
      }}
    />
  );
}
```

### 3. Mutations with Optimistic Updates

```javascript
import { commitMutation, graphql } from 'react-relay';

const mutation = graphql`
  mutation UpdateUserNameMutation($input: UpdateUserNameInput!) {
    updateUser(input: $input) {
      user {
        id
        name
      }
    }
  }
`;

function updateUserName(name, user, environment) {
  return commitMutation(environment, {
    mutation,
    variables: { input: { userId: user.id, name } },

    // Optimistic update - update UI before server responds
    optimisticResponse: {
      updateUser: {
        user: {
          id: user.id,
          name: name,
        },
      },
    },

    // Update local store after mutation
    onCompleted: (response) => {
      console.log('Updated:', response.updateUser.user);
    },

    onError: (error) => {
      console.error('Error:', error);
    },
  });
}
```

### 4. Pagination

```javascript
import { createPaginationContainer, graphql } from 'react-relay';

const UserList = createPaginationContainer(
  function UserList({ user, relay }) {
    return (
      <div>
        {user.posts.edges.map(edge => (
          <Post key={edge.node.id} post={edge.node} />
        ))}
        <button
          onClick={() => relay.loadMore(10, () => {
            console.log('Loaded more');
          })}
          disabled={!relay.hasMore()}
        >
          Load More
        </button>
      </div>
    );
  },
  {
    user: graphql`
      fragment UserList_user on User
      @argumentDefinitions(
        count: { type: "Int!", defaultValue: 10 }
        cursor: { type: "String" }
      )
      @refetchable(queryName: "UserListPaginationQuery") {
        id
        posts(first: $count, after: $cursor)
          @connection(key: "UserList_posts") {
          edges {
            node {
              id
              title
            }
          }
          pageInfo {
            hasNextPage
            endCursor
          }
        }
      }
    `,
  }
);
```

### 5. Prefetching Data
Load data before user navigates:

```javascript
// Hover over link prefetches data
<Link
  to={`/user/${user.id}`}
  onMouseEnter={() => relay.prefetch(...)}
>
  {user.name}
</Link>
```

### 6. Transitions
Loading states during navigation:

```javascript
import { useTransition } from 'react-relay';

function App() {
  const { isTransitioning } = useTransition();

  return (
    <>
      {isTransitioning && <Spinner />}
      <Router />
    </>
  );
}
```

---

## Best Practices

### Server-Side
1. **Use DataLoader** to prevent N+1 queries
2. **Implement Connection pattern** for all list fields
3. **Consistent error handling** with mutation payloads
4. **Add Open Telemetry** for monitoring
5. **Version schemas** for evolution
6. **Use Input types** for complex arguments

### Client-Side (Relay)
1. **Use fragments** for data co-location
2. **Optimistic updates** for fast UX
3. **Pagination** for large datasets
4. **Prefetch** data on hover/intent
5. **TypeScript** for type safety
6. **One query per route** (Relay's philosophy)

### Architecture
1. **Simple layering** for maintainability
2. **Distributed GraphQL** for microservices
3. **CQRS + DDD** for complex domains
4. **Schema registry** for evolution tracking
5. **Client registry** for field usage tracking

---

## Key Takeaways

1. **DataLoader is critical** — prevents N+1 query problems
2. **Connection pattern standardizes pagination** — use it everywhere
3. **Relay's fragment model** keeps data requirements co-located
4. **Optimistic updates** improve perceived performance
5. **Schema evolution requires tracking** — use registries and telemetry
6. **CQRS + DDD fit well with GraphQL** — separate read/write concerns
7. **Distributed GraphQL** enables microservices while maintaining unified API
8. **Subscriptions** handle real-time updates cleanly

---

## Workshop Links

- Full Workshop: https://fullstack-workshop.chillicream.com
- Hot Chocolate (GraphQL Server): https://chillicream.com
- Relay (GraphQL Client): https://relay.dev
