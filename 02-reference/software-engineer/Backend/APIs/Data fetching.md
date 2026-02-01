---
description: Notes about Data fetching.
tags: #data-fetching #react #frontend #api #state-management
---

## Definition
> Data fetching in React refers to the process of requesting and retrieving data from external sources (APIs, databases, etc.) and managing that data within your application. It encompasses loading states, error handling, caching, and data synchronization.

## Key Points
- Multiple fetching approaches
- Loading state management
- Error handling
- Caching strategies
- Request optimization
- Data synchronization

## Common Approaches

### 1. React Query / TanStack Query
```javascript
function TodoList() {
  const { data, isLoading, error } = useQuery({
    queryKey: ['todos'],
    queryFn: async () => {
      const response = await fetch('/api/todos');
      return response.json();
    },
  });

  if (isLoading) return <Spinner />;
  if (error) return <Error message={error.message} />;

  return (
    <ul>
      {data.map(todo => (
        <TodoItem key={todo.id} todo={todo} />
      ))}
    </ul>
  );
}
```

### 2. SWR (Stale-While-Revalidate)
```javascript
function Profile() {
  const { data, error, isValidating } = useSWR(
    '/api/user',
    async url => {
      const response = await fetch(url);
      return response.json();
    }
  );

  if (error) return <ErrorComponent />;
  if (!data && isValidating) return <Loading />;

  return <UserProfile user={data} />;
}
```

### 3. Custom Hooks Pattern
```javascript
function useData(url) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    async function fetchData() {
      try {
        const response = await fetch(url);
        const json = await response.json();
        setData(json);
      } catch (err) {
        setError(err);
      } finally {
        setLoading(false);
      }
    }
    fetchData();
  }, [url]);

  return { data, loading, error };
}
```

## Best Practices

### 1. Error Boundaries
```javascript
class DataErrorBoundary extends React.Component {
  state = { hasError: false, error: null };
  
  static getDerivedStateFromError(error) {
    return { hasError: true, error };
  }

  render() {
    if (this.state.hasError) {
      return <ErrorFallback error={this.state.error} />;
    }
    return this.props.children;
  }
}
```

### 2. Loading States
```javascript
function DataComponent({ data, loading, error }) {
  if (loading) {
    return (
      <div className="loading-state">
        <Skeleton />
        <LoadingSpinner />
      </div>
    );
  }

  if (error) {
    return (
      <div className="error-state">
        <ErrorMessage error={error} />
        <RetryButton />
      </div>
    );
  }

  return <DataDisplay data={data} />;
}
```

## Common Patterns

### 1. Optimistic Updates
```javascript
function TodoList() {
  const queryClient = useQueryClient();

  const mutation = useMutation({
    mutationFn: updateTodo,
    onMutate: async (newTodo) => {
      // Cancel outgoing refetches
      await queryClient.cancelQueries(['todos']);

      // Snapshot previous value
      const previousTodos = queryClient.getQueryData(['todos']);

      // Optimistically update
      queryClient.setQueryData(['todos'], old => [...old, newTodo]);

      return { previousTodos };
    },
    onError: (err, newTodo, context) => {
      // Rollback on error
      queryClient.setQueryData(['todos'], context.previousTodos);
    }
  });
}
```

### 2. Infinite Loading
```javascript
function InfiniteList() {
  const {
    data,
    fetchNextPage,
    hasNextPage,
    isFetchingNextPage
  } = useInfiniteQuery({
    queryKey: ['posts'],
    queryFn: fetchPostPage,
    getNextPageParam: (lastPage) => lastPage.nextCursor,
  });

  return (
    <div>
      {data.pages.map((page) => (
        <Posts posts={page.posts} />
      ))}
      <button
        onClick={() => fetchNextPage()}
        disabled={!hasNextPage || isFetchingNextPage}
      >
        {isFetchingNextPage
          ? 'Loading more...'
          : hasNextPage
          ? 'Load more'
          : 'Nothing more to load'}
      </button>
    </div>
  );
}
```

## Performance Patterns

### 1. Caching Configuration
```javascript
const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 1000 * 60 * 5, // 5 minutes
      cacheTime: 1000 * 60 * 30, // 30 minutes
      retry: 3,
      retryDelay: attemptIndex => Math.min(1000 * 2 ** attemptIndex, 30000),
    },
  },
});
```

### 2. Prefetching
```javascript
function PostList() {
  const queryClient = useQueryClient();

  // Prefetch on hover
  const prefetchPost = (postId) => {
    queryClient.prefetchQuery({
      queryKey: ['post', postId],
      queryFn: () => fetchPost(postId),
    });
  };

  return (
    <div>
      {posts.map(post => (
        <div 
          key={post.id}
          onMouseEnter={() => prefetchPost(post.id)}
        >
          <PostPreview post={post} />
        </div>
      ))}
    </div>
  );
}
```

## Error Handling
```javascript
function DataFetcher() {
  const { data, error, refetch } = useQuery({
    queryKey: ['data'],
    queryFn: fetchData,
    retry: (failureCount, error) => {
      // Custom retry logic
      if (error.status === 404) return false;
      return failureCount < 3;
    },
    onError: (error) => {
      // Log error or show notification
      notifyError(error);
    },
  });

  if (error) {
    return (
      <ErrorDisplay 
        error={error}
        onRetry={refetch}
      />
    );
  }

  return <DataDisplay data={data} />;
}
```

## Summary
- Choose appropriate data fetching library
- Implement proper loading states
- Handle errors gracefully
- Use caching strategies
- Consider optimistic updates
- Implement proper retry logic

## Resources
- [React Query Documentation](https://tanstack.com/query/latest)
- [SWR Documentation](https://swr.vercel.app/)
- [React Suspense for Data Fetching](https://react.dev/reference/react/Suspense)
- [Data Fetching Best Practices](https://react.dev/learn/synchronizing-with-effects)
