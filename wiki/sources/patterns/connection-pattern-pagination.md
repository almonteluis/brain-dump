---
description: "Relay Connection pattern for cursor-based pagination"
tags: [relay, pagination, connection-pattern, usePagination, infinite-scroll, graphql, cursor-pagination]
sources: ["connection-pattern-pagination.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Connection Pattern & Pagination in Relay

**Source:** raw/02_reference/approaches/connection-pattern-pagination.md
**Date ingested:** 2026-04-09
**Type:** technical guide

## Summary

Complete guide to GraphQL Connection pattern in Relay — connection type structure, usePagination hook, @connection directive, cursor-based pagination, and infinite scroll patterns.

## Key Claims

- Connection pattern provides consistent structure for paginated data
- Cursor-based navigation is preferred over page numbers
- @connection directive ensures pagination state is isolated per component instance
- usePaginationFragment handles forward, backward, and bi-directional pagination

## Connection Type Structure

### GraphQL Schema
```graphql
type PostConnection {
  edges: [PostEdge]!
  pageInfo: PageInfo!
  totalCount: Int
}

type PostEdge {
  cursor: String!
  node: Post
}

type PageInfo {
  hasNextPage: Boolean!
  hasPreviousPage: Boolean!
  startCursor: String
  endCursor: String
}
```

### Key Components
1. **Connection Type** — Container for edges and metadata
2. **Edge Type** — Wraps each item with a cursor
3. **Node** — The actual item
4. **PageInfo** — Navigation metadata

## usePaginationFragment Hook

### Basic Usage
```typescript
const {data, hasNext, loadNext, isLoadingNext} = usePaginationFragment(
  graphql`
    fragment User_posts on User
    @argumentDefinitions(
      count: {type: "Int", defaultValue: 10}
      cursor: {type: "String", defaultValue: null}
    )
    @refetchable(queryName: "UserPostsPaginationQuery") {
      posts(first: $count, after: $cursor)
      @connection(key: "User_posts", filters: []) {
        edges { node { id title } }
        pageInfo { hasNextPage endCursor }
      }
    }
  `,
  user
);
```

### Return Values
- `data` — Fragment data (read-only)
- `isLoadingNext/isLoadingPrevious` — Loading states
- `hasNext/hasPrevious` — Boolean flags for more data
- `loadNext/loadPrevious` — Functions to load more
- `refetch` — Function to refetch from cursor

## @connection Directive

### Purpose
- Isolates pagination state per component instance
- Allows multiple components to paginate same connection independently
- Prevents cache conflicts between different lists

### With Filters
```graphql
posts(first: $count, after: $cursor, filter: $filterBy)
@connection(key: "UserPosts_user_posts", filters: ["filterBy"])
```

Different filter values create different connections cached separately.

## Pagination Patterns

### Scroll-Triggered Loading (Infinite Scroll)
```typescript
useEffect(() => {
  const observer = new IntersectionObserver(
    entries => {
      if (entries[0].isIntersecting && hasNext && !isLoadingNext) {
        loadNext(10);
      }
    },
    {threshold: 1.0}
  );
  // ...
}, [hasNext, isLoadingNext, loadNext]);
```

### Button-Based Load More
```typescript
{hasNext && (
  <button onClick={() => loadNext(10)} disabled={isLoadingNext}>
    {isLoadingNext ? 'Loading...' : 'Load More'}
  </button>
)}
```

### Resetting Pagination
```typescript
const handleRefresh = () => {
  refetch({count: 10, cursor: null}, {force: true});
};
```

## Connection Mutations

### Adding to Connection
```graphql
mutation AddCommentMutation($input: CommentData!) {
  add_comment(data: $input) {
    comment_edge @appendNode(connection: "Post_comments") {
      node { id body }
    }
  }
}
```

### Prepending to Connection
```graphql
post_edge @prependNode(connection: "User_posts")
```

### Removing from Connection
```graphql
deleted_post @deleteRecord
```

## Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| Duplicate items | Use unique connection keys |
| Pagination not loading | Query `pageInfo.hasNextPage` and `endCursor` |
| Cursor errors | Handle gracefully, reset to first page |
| Memory growth | Implement virtualization or limit cached items |

## Use Cases

- **Social Media Feed** — Infinite scroll, optimistic insertion
- **E-commerce Product List** — Filter-based connections, dynamic page sizes
- **Data Table** — Pagination with page numbers, sort/filter changes
- **Comment Thread** — Nested cursor-based pagination

## Concepts Covered

- [[Cursor Pagination]] — Opaque cursor-based navigation
- [[Connection Pattern]] — GraphQL standard for paginated lists
- [[Infinite Scroll]] — Scroll-triggered loading patterns
- [[Relay Cache Management]] — Connection state isolation

## Related

- [[relay-fragment-composition]]
- [[relay-mutations-guide]]
- [[data-masking-in-relay]]
- [[relay-environment-setup]]
