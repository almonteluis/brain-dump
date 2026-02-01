---
description: Complete guide to GraphQL Connection pattern in Relay — connection type structure, usePagination hook, @connection directive, cursor-based pagination, and infinite scroll patterns.
tags: ["relay", "pagination", "connection-pattern", "usePagination", "infinite-scroll", "graphql"]
created: 2026-02-02
---

# Connection Pattern & Pagination in Relay

## What is the Connection Pattern?

The **Connection pattern** is a standardized way to model paginated lists in GraphQL. It provides:

- Consistent structure for paginated data
- Cursor-based navigation (no page numbers)
- Metadata about list edges and page info
- Built-in support for infinite scroll

## Connection Type Structure

### GraphQL Schema Definition

```graphql
type User {
  id: ID!
  name: String!
  posts(first: Int, after: String): PostConnection!
}

type PostConnection {
  edges: [PostEdge]!
  pageInfo: PageInfo!
  totalCount: Int
}

type PostEdge {
  cursor: String!
  node: Post
}

type Post {
  id: ID!
  title: String!
  content: String!
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
3. **Node** — The actual item (Post, User, etc.)
4. **PageInfo** — Navigation metadata

### Querying Connections

```graphql
query UserPostsQuery($userId: ID!, $first: Int!, $after: String) {
  user(id: $userId) {
    posts(first: $first, after: $after) {
      edges {
        cursor
        node {
          id
          title
        }
      }
      pageInfo {
        hasNextPage
        hasPreviousPage
        endCursor
      }
      totalCount
    }
  }
}
```

## usePagination Hook

### Basic Usage

```typescript
import {graphql, usePaginationFragment} from 'react-relay';
import type {User_posts$key} from './__generated__/User_posts.graphql';

function User({user}: {user: User_posts$key}) {
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
    user
  );

  return (
    <div>
      <h2>Posts ({data.posts.edges.length})</h2>
      <ul>
        {data.posts.edges.map(edge => (
          <li key={edge.node.id}>{edge.node.title}</li>
        ))}
      </ul>
      {hasNext && (
        <button onClick={() => loadNext(10)} disabled={isLoadingNext}>
          {isLoadingNext ? 'Loading...' : 'Load More'}
        </button>
      )}
    </div>
  );
}
```

### Fragment Arguments

The `@argumentDefinitions` directive defines pagination parameters:

```graphql
@argumentDefinitions(
  count: {type: "Int", defaultValue: 10}
  cursor: {type: "String", defaultValue: null}
)
```

- `count` — How many items to fetch per page
- `cursor` — Where to start fetching from (null = beginning)

### @refetchable Directive

```graphql
@refetchable(queryName: "UserPostsPaginationQuery")
```

This tells Relay to:
- Generate a separate query for pagination
- Allow refetching with different variables
- Support dynamic `count` and `cursor` values

### usePaginationFragment Return Values

```typescript
const {
  data,              // Fragment data (read-only)
  isLoadingNext,     // Boolean, next page loading
  hasNext,           // Boolean, more pages available
  loadNext,          // Function(count) to load next page
  loadPrevious,      // Function(count) to load previous page
  hasPrevious,       // Boolean, previous pages available
  isLoadingPrevious, // Boolean, previous page loading
  refetch,           // Function(variables) to refetch from cursor
} = usePaginationFragment(fragment, fragmentRef);
```

## @connection Directive

### Why @connection Matters

The `@connection` directive ensures:
- Pagination state is isolated per component instance
- Multiple components can paginate the same connection independently
- Cache doesn't conflict between different lists

### Basic Usage

```graphql
fragment User_posts on User {
  posts(first: $count, after: $cursor)
  @connection(key: "User_posts", filters: []) {
    edges {
      node {
        id
        title
      }
    }
    pageInfo {
      hasNextPage
    }
  }
}
```

### Connection Key Format

```graphql
@connection(key: "{ComponentName}_{fieldName}", filters: [])
```

- **Key** — Unique identifier for this connection
- **Filters** — Array of variables that affect connection identity

### With Filters

```graphql
fragment UserPosts_user on User
@argumentDefinitions(
  count: {type: "Int", defaultValue: 10}
  cursor: {type: "String", defaultValue: null}
  filterBy: {type: "PostFilter", defaultValue: {active: true}}
)
@refetchable(queryName: "UserPostsPaginationQuery") {
  posts(first: $count, after: $cursor, filter: $filterBy)
  @connection(key: "UserPosts_user_posts", filters: ["filterBy"]) {
    edges {
      node {
        id
        title
        active
      }
    }
    pageInfo {
      hasNextPage
    }
  }
}
```

**Why filters?**
- Different filter values create different connections
- `active: true` and `active: false` are cached separately
- Prevents mixing items from different filters

### Multiple Connections in One Component

```graphql
fragment Dashboard_user on User {
  posts(first: $postCount, after: $postCursor)
  @connection(key: "Dashboard_user_posts", filters: []) {
    edges { node { id title } }
  }

  comments(first: $commentCount, after: $commentCursor)
  @connection(key: "Dashboard_user_comments", filters: []) {
    edges { node { id body } }
  }
}
```

## Cursor-Based Pagination

### How Cursors Work

Cursors are opaque strings that:
- Encode position in the list
- Are not human-readable
- Should never be parsed or modified by clients

### Forward Pagination

```typescript
const {data, hasNext, loadNext} = usePaginationFragment(
  graphql`
    fragment Posts_connection on PostConnection
    @argumentDefinitions(
      count: {type: "Int", defaultValue: 10}
      cursor: {type: "String", defaultValue: null}
    )
    @refetchable(queryName: "PostsForwardPaginationQuery") {
      edges {
        cursor
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
  `,
  connection
);

// Load next 10 items
loadNext(10);
```

### Backward Pagination

```graphql
fragment Posts_connection on PostConnection
@argumentDefinitions(
  count: {type: "Int", defaultValue: 10}
  before: {type: "String", defaultValue: null}
)
@refetchable(queryName: "PostsBackwardPaginationQuery") {
  edges {
    cursor
    node {
      id
      title
    }
  }
  pageInfo {
    hasPreviousPage
    startCursor
  }
}
```

```typescript
const {hasPrevious, loadPrevious} = usePaginationFragment(fragment, connection);

// Load previous 10 items
loadPrevious(10);
```

### Bi-directional Pagination

```graphql
fragment Posts_connection on PostConnection
@argumentDefinitions(
  count: {type: "Int", defaultValue: 10}
  after: {type: "String", defaultValue: null}
  before: {type: "String", defaultValue: null}
)
@refetchable(queryName: "PostsBiDirectionalPaginationQuery") {
  edges {
    cursor
    node {
      id
      title
    }
  }
  pageInfo {
    hasNextPage
    hasPreviousPage
    startCursor
    endCursor
  }
}
```

```typescript
const {hasNext, hasPrevious, loadNext, loadPrevious} = usePaginationFragment(
  fragment,
  connection
);

// Load in either direction
loadNext(10);
loadPrevious(10);
```

## Infinite Scroll Patterns

### Scroll-triggered Loading

```typescript
import {useEffect, useRef} from 'react';

function InfiniteScrollList({connection}) {
  const {data, hasNext, loadNext, isLoadingNext} = usePaginationFragment(
    graphql`
      fragment InfiniteScrollList_connection on PostConnection
      @argumentDefinitions(
        count: {type: "Int", defaultValue: 10}
        cursor: {type: "String", defaultValue: null}
      )
      @refetchable(queryName: "InfiniteScrollPaginationQuery") {
        edges {
          node {
            id
            title
          }
        }
        pageInfo {
          hasNextPage
        }
      }
    `,
    connection
  );

  const loadMoreRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const observer = new IntersectionObserver(
      entries => {
        if (entries[0].isIntersecting && hasNext && !isLoadingNext) {
          loadNext(10);
        }
      },
      {threshold: 1.0}
    );

    if (loadMoreRef.current) {
      observer.observe(loadMoreRef.current);
    }

    return () => observer.disconnect();
  }, [hasNext, isLoadingNext, loadNext]);

  return (
    <div>
      <ul>
        {data.edges.map(edge => (
          <li key={edge.node.id}>{edge.node.title}</li>
        ))}
      </ul>
      {hasNext && (
        <div ref={loadMoreRef} style={{height: '50px'}}>
          {isLoadingNext ? 'Loading...' : ''}
        </div>
      )}
    </div>
  );
}
```

### Button-based Load More

```typescript
function LoadMoreList({connection}) {
  const {data, hasNext, loadNext, isLoadingNext} = usePaginationFragment(
    graphql`
      fragment LoadMoreList_connection on PostConnection
      @argumentDefinitions(
        count: {type: "Int", defaultValue: 10}
        cursor: {type: "String", defaultValue: null}
      )
      @refetchable(queryName: "LoadMorePaginationQuery") {
        edges {
          node {
            id
            title
          }
        }
        pageInfo {
          hasNextPage
        }
      }
    `,
    connection
  );

  return (
    <div>
      <ul>
        {data.edges.map(edge => (
          <li key={edge.node.id}>{edge.node.title}</li>
        ))}
      </ul>
      {hasNext && (
        <button onClick={() => loadNext(10)} disabled={isLoadingNext}>
          {isLoadingNext ? 'Loading...' : 'Load More'}
        </button>
      )}
    </div>
  );
}
```

### Infinite Scroll with Debounce

```typescript
import {useEffect, useRef, useCallback} from 'react';

function DebouncedInfiniteScroll({connection}) {
  const {data, hasNext, loadNext, isLoadingNext} = usePaginationFragment(
    graphql`
      fragment DebouncedInfiniteScroll_connection on PostConnection
      @argumentDefinitions(
        count: {type: "Int", defaultValue: 10}
        cursor: {type: "String", defaultValue: null}
      )
      @refetchable(queryName: "DebouncedPaginationQuery") {
        edges {
          node { id title }
        }
        pageInfo { hasNextPage }
      }
    `,
    connection
  );

  const observerRef = useRef<IntersectionObserver | null>(null);
  const targetRef = useRef<HTMLDivElement>(null);

  const loadMore = useCallback(() => {
    if (hasNext && !isLoadingNext) {
      loadNext(10);
    }
  }, [hasNext, isLoadingNext, loadNext]);

  useEffect(() => {
    observerRef.current = new IntersectionObserver(
      entries => {
        if (entries[0].isIntersecting) {
          // Debounce to prevent rapid firing
          setTimeout(loadMore, 200);
        }
      },
      {threshold: 0.5, rootMargin: '100px'}
    );

    const currentObserver = observerRef.current;
    if (targetRef.current) {
      currentObserver.observe(targetRef.current);
    }

    return () => currentObserver.disconnect();
  }, [loadMore]);

  return (
    <div>
      <ul>
        {data.edges.map(edge => (
          <li key={edge.node.id}>{edge.node.title}</li>
        ))}
      </ul>
      {hasNext && <div ref={targetRef} />}
    </div>
  );
}
```

## Managing Pagination State

### Resetting Pagination

```typescript
function PostList({user}) {
  const {data, hasNext, loadNext, refetch} = usePaginationFragment(
    graphql`
      fragment PostList_user on User
      @argumentDefinitions(
        count: {type: "Int", defaultValue: 10}
        cursor: {type: "String", defaultValue: null}
      )
      @refetchable(queryName: "PostListPaginationQuery") {
        posts(first: $count, after: $cursor)
        @connection(key: "PostList_user_posts", filters: []) {
          edges {
            node {
              id
              title
            }
          }
          pageInfo {
            hasNextPage
          }
        }
      }
    `,
    user
  );

  const handleRefresh = () => {
    // Reset to first page
    refetch({count: 10, cursor: null}, {force: true});
  };

  return (
    <div>
      <button onClick={handleRefresh}>Refresh</button>
      <ul>
        {data.posts.edges.map(edge => (
          <li key={edge.node.id}>{edge.node.title}</li>
        ))}
      </ul>
      {hasNext && <button onClick={() => loadNext(10)}>Load More</button>}
    </div>
  );
}
```

### Dynamic Page Size

```typescript
function AdjustablePageSize({connection}) {
  const [pageSize, setPageSize] = useState(10);
  const {data, hasNext, loadNext} = usePaginationFragment(
    graphql`
      fragment AdjustablePagination_connection on PostConnection
      @argumentDefinitions(
        count: {type: "Int", defaultValue: 10}
        cursor: {type: "String", defaultValue: null}
      )
      @refetchable(queryName: "AdjustablePaginationQuery") {
        edges {
          node { id title }
        }
        pageInfo { hasNextPage }
      }
    `,
    connection
  );

  return (
    <div>
      <select value={pageSize} onChange={e => setPageSize(Number(e.target.value))}>
        <option value={5}>5 per page</option>
        <option value={10}>10 per page</option>
        <option value={20}>20 per page</option>
        <option value={50}>50 per page</option>
      </select>
      <ul>
        {data.edges.map(edge => (
          <li key={edge.node.id}>{edge.node.title}</li>
        ))}
      </ul>
      {hasNext && <button onClick={() => loadNext(pageSize)}>Load More</button>}
    </div>
  );
}
```

## Connection Updates in Mutations

### Adding to Connection with @appendNode

```graphql
mutation AddCommentMutation($input: CommentData!) {
  add_comment(data: $input) {
    comment_edge @appendNode(connection: "Post_comments") {
      node {
        id
        body
        ...CommentDisplay_comment
      }
    }
  }
}
```

### Prepending to Connection with @prependNode

```graphql
mutation AddPostMutation($input: PostData!) {
  add_post(data: $input) {
    post_edge @prependNode(connection: "User_posts") {
      node {
        id
        title
        ...PostDisplay_post
      }
    }
  }
}
```

### Removing from Connection with @deleteRecord

```graphql
mutation DeletePostMutation($input: DeletePostData!) {
  delete_post(data: $input) {
    deleted_post @deleteRecord {
      id
    }
  }
}
```

## Common Issues & Solutions

### Issue: Duplicate Items in List

**Problem:** After refetch, items appear twice.

**Cause:** Same connection used in multiple places without unique key.

**Solution:** Use unique connection keys:
```graphql
posts @connection(key: "ComponentName_uniqueKey", filters: [])
```

### Issue: Pagination Not Loading

**Problem:** `loadNext()` called but nothing happens.

**Cause:** `hasNext` is false or `pageInfo.hasNextPage` not queried.

**Solution:** Always query `pageInfo`:
```graphql
pageInfo {
  hasNextPage
  endCursor  # Required for loadNext
}
```

### Issue: Cursor Errors

**Problem:** "Invalid cursor" errors from server.

**Cause:** Cursor expired or list changed (items added/deleted).

**Solution:** Handle cursor errors gracefully:
```typescript
const handleLoadMore = () => {
  try {
    loadNext(10);
  } catch (error) {
    if (isCursorError(error)) {
      refetch({count: 10, cursor: null}); // Reset to first page
    }
  }
};
```

### Issue: Memory Growth with Infinite Scroll

**Problem:** List keeps growing, eventually slows down app.

**Solution:** Implement virtualization or limit cached items:
```typescript
const MAX_CACHED_ITEMS = 500;

useEffect(() => {
  if (data.edges.length > MAX_CACHED_ITEMS) {
    // Optionally truncate or paginate differently
    console.warn('Too many items loaded');
  }
}, [data.edges.length]);
```

## Use Cases

### Social Media Feed
- Infinite scroll with chronological ordering
- Optimistic new post insertion
- Connection mutations (add, delete)

### E-commerce Product List
- Filter-based connections
- Dynamic page sizes (grid vs list view)
- Sort order changes

### Data Table
- Pagination with page numbers
- Sort and filter changes
- Bidirectional navigation

### Comment Thread
- Infinite scroll for comments
- Cursor-based nesting
- Real-time insertion with subscriptions

## See Also

- [[Relay Environment Setup]] — Network and cache configuration
- [[Relay Compiler & Build Setup]] — Build pipeline for pagination queries
- [[Data Masking in Relay]] — Fragment data isolation
- [[Relay Mutations Guide]] — Connection manipulation in mutations
- [[Connection Pattern]] — GraphQL schema design

## External Resources

- [Relay Pagination Docs](https://relay.dev/docs/guided-tour/list-data/pagination/)
- [Relay API Reference - usePaginationFragment](https://relay.dev/docs/api-reference/use-pagination-fragment/)
- [GraphQL Connection Specification](https://relay.dev/graphql/connections.htm)
- [Relay Cursor Pagination Guide](https://relay.dev/docs/guided-tour/list-data/cursor-based-pagination/)
