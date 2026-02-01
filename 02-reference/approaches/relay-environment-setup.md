---
description: Complete guide to setting up Relay Environment — configuration, network layer, authentication, cache policies, and error handling boundaries for production-ready Relay applications.
tags: ["relay", "environment-setup", "network-layer", "authentication", "cache", "error-handling"]
created: 2026-02-02
---

# Relay Environment Setup

## What is Relay Environment?

The **RelayEnvironment** is the central object that manages:
- Network communication (fetching queries, mutations)
- Store (cache for GraphQL data)
- Schedulers (handling network/store operations)
- Logging and observability

Every Relay app needs exactly one RelayEnvironment instance per application context.

## Basic Environment Setup

### Minimal Configuration

```typescript
import {Environment, Network, RecordSource, Store} from 'relay-runtime';

// 1. Create a record source (holds normalized cache)
const recordSource = new RecordSource();

// 2. Create a store (manages records, subscriptions)
const store = new Store(recordSource);

// 3. Create network layer (handles GraphQL requests)
const network = Network.create(async (operation, variables) => {
  const response = await fetch('/graphql', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify({
      query: operation.text,
      variables,
    }),
  });

  return response.json();
});

// 4. Create environment
const relayEnvironment = new Environment({
  network,
  store,
});
```

## Network Layer Setup

### Custom Network Layer with Headers

```typescript
const network = Network.create(async (operation, variables) => {
  const token = localStorage.getItem('auth_token');

  const response = await fetch('/graphql', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': token ? `Bearer ${token}` : '',
    },
    body: JSON.stringify({
      query: operation.text,
      variables,
      operationName: operation.name,
    }),
  });

  const json = await response.json();

  // Handle GraphQL errors
  if (json.errors) {
    throw new Error(json.errors[0].message);
  }

  return json;
});
```

### Fetch Function with Error Handling

```typescript
const network = Network.create(
  // fetchFunction
  async (operation, variables, cacheConfig, uploadables) => {
    try {
      const response = await fetch('/graphql', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${getAuthToken()}`,
        },
        body: JSON.stringify({
          query: operation.text,
          variables,
          operationName: operation.name,
        }),
      });

      if (!response.ok) {
        throw new Error(`Network error: ${response.status}`);
      }

      const result = await response.json();

      // Log errors to error tracking
      if (result.errors) {
        logErrorToService({
          type: 'GRAPHQL_ERROR',
          errors: result.errors,
          operation: operation.name,
        });
      }

      return result;
    } catch (error) {
      // Log network errors
      logErrorToService({
        type: 'NETWORK_ERROR',
        error: error.message,
        operation: operation.name,
      });
      throw error;
    }
  },
  // subscribeFunction (for subscriptions)
  async (operation, variables) => {
    const subscriptionClient = createSubscriptionClient();
    return subscriptionClient.request({
      query: operation.text,
      variables,
    });
  }
);
```

## Authentication Integration

### Token-based Authentication

```typescript
function getAuthToken(): string | null {
  return localStorage.getItem('auth_token');
}

function refreshAuthToken(): Promise<string> {
  return fetch('/auth/refresh', {
    method: 'POST',
    credentials: 'include',
  })
    .then(res => res.json())
    .then(data => {
      localStorage.setItem('auth_token', data.token);
      return data.token;
    });
}

const network = Network.create(async (operation, variables) => {
  let token = getAuthToken();

  // Refresh token if needed
  if (shouldRefreshToken(token)) {
    token = await refreshAuthToken();
  }

  const response = await fetch('/graphql', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${token}`,
    },
    body: JSON.stringify({
      query: operation.text,
      variables,
    }),
  });

  // Handle 401 Unauthorized
  if (response.status === 401) {
    logoutUser();
    throw new Error('Authentication required');
  }

  return response.json();
});
```

### Cookie-based Authentication

```typescript
const network = Network.create(async (operation, variables) => {
  const response = await fetch('/graphql', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': getCsrfToken(),
    },
    credentials: 'include', // Include cookies
    body: JSON.stringify({
      query: operation.text,
      variables,
    }),
  });

  // Handle CSRF errors
  if (response.status === 403) {
    const csrfToken = await refreshCsrfToken();
    // Retry with new CSRF token
    return fetch('/graphql', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken,
      },
      credentials: 'include',
      body: JSON.stringify({
        query: operation.text,
        variables,
      }),
    }).then(res => res.json());
  }

  return response.json();
});
```

## Cache Configuration

### Default Cache Behavior

Relay's default cache:
- Stores query responses normalized by `__id`
- Reuses data across queries
- Persists in memory only
- No automatic expiration

### Cache Persistence

```typescript
import {Environment, Network, RecordSource, Store} from 'relay-runtime';

// Load persisted cache
const loadCache = async (): Promise<RecordSource> => {
  const persistedCache = await localStorage.getItem('relay-cache');
  if (persistedCache) {
    return RecordSource.create(JSON.parse(persistedCache));
  }
  return new RecordSource();
};

// Persist cache on changes
const persistCache = (recordSource: RecordSource) => {
  const cacheData = recordSource.toJSON();
  localStorage.setItem('relay-cache', JSON.stringify(cacheData));
};

// Create environment with cache persistence
export const createEnvironment = async () => {
  const recordSource = await loadCache();
  const store = new Store(recordSource, {
    // Update cache on each change
    gcReleaseBufferSize: 10, // Release garbage after 10 updates
  });

  // Persist cache periodically
  store.subscribe(() => {
    persistCache(store.getSource());
  });

  return new Environment({
    network,
    store,
    // Enable garbage collection
    gcScheduler: (callback) => setTimeout(callback, 5000),
  });
};
```

### Cache Policies

```typescript
const environment = new Environment({
  network,
  store,
  // Configurable cache behavior
  handlerProvider: (handle) => {
    // Override how records are stored/updated
    return undefined; // Use default handlers
  },
  // Enable query caching
  queryCacheExpirationTime: 30 * 1000, // 30 seconds
});
```

### Using CacheConfig in Queries

```typescript
const data = useLazyLoadQuery(
  query,
  variables,
  {
    fetchPolicy: 'store-or-network',  // Check cache first
    networkCacheConfig: {
      force: true,  // Always fetch from network
    },
  }
);
```

**Fetch policies:**
- `store-or-network` — Return cache if available, fetch in background
- `store-only` — Return cache only, don't fetch
- `network-only` — Always fetch, ignore cache

## Error Handling Boundaries

### Error Boundary for Relay

```typescript
import {RelayErrorBoundary} from 'react-relay';

function App() {
  return (
    <RelayEnvironmentProvider environment={relayEnvironment}>
      <ErrorBoundary fallback={<ErrorFallback />}>
        <AppContent />
      </ErrorBoundary>
    </RelayEnvironmentProvider>
  );
}

function ErrorFallback({error, resetErrorBoundary}) {
  return (
    <div className="error-container">
      <h2>Something went wrong</h2>
      <p>{error.message}</p>
      <button onClick={resetErrorBoundary}>Try again</button>
    </div>
  );
}
```

### Custom Error Boundary with Relay Integration

```typescript
import {Component, ReactNode} from 'react';

interface ErrorBoundaryProps {
  children: ReactNode;
  fallback: (error: Error, reset: () => void) => ReactNode;
}

interface ErrorBoundaryState {
  hasError: boolean;
  error: Error | null;
}

class RelayErrorBoundary extends Component<
  ErrorBoundaryProps,
  ErrorBoundaryState
> {
  constructor(props: ErrorBoundaryProps) {
    super(props);
    this.state = {hasError: false, error: null};
  }

  static getDerivedStateFromError(error: Error): ErrorBoundaryState {
    return {hasError: true, error};
  }

  componentDidCatch(error: Error, errorInfo: any) {
    // Log error to monitoring service
    logErrorToService({
      error,
      componentStack: errorInfo.componentStack,
    });

    // Optionally clear Relay cache on error
    if (isAuthError(error)) {
      relayEnvironment.getStore().clearCache();
    }
  }

  handleReset = () => {
    this.setState({hasError: false, error: null});
  };

  render() {
    if (this.state.hasError) {
      return this.props.fallback(this.state.error!, this.handleReset);
    }

    return this.props.children;
  }
}
```

### Global Error Logging

```typescript
const network = Network.create(async (operation, variables) => {
  try {
    const response = await fetch('/graphql', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${getAuthToken()}`,
      },
      body: JSON.stringify({
        query: operation.text,
        variables,
        operationName: operation.name,
      }),
    });

    const result = await response.json();

    // Handle GraphQL errors
    if (result.errors) {
      result.errors.forEach((error: any) => {
        logToErrorTracking({
          message: error.message,
          path: error.path,
          extensions: error.extensions,
          operation: operation.name,
          variables,
        });
      });
    }

    return result;
  } catch (error) {
    // Handle network errors
    logToErrorTracking({
      message: error.message,
      type: 'network',
      operation: operation.name,
    });
    throw error;
  }
});
```

## Production-Ready Environment

### Complete Setup with Observability

```typescript
import {Environment, Network, RecordSource, Store} from 'relay-runtime';
import type {RequestParameters, Variables, CacheConfig} from 'relay-runtime';

// Logging
const logRequest = (operation: RequestParameters, variables: Variables) => {
  console.log(`[Relay] Request: ${operation.name}`, variables);
};

const logResponse = (
  operation: RequestParameters,
  response: any,
  duration: number
) => {
  console.log(
    `[Relay] Response: ${operation.name} (${duration}ms)`,
    response
  );
};

// Network layer with metrics
const network = Network.create(async (operation, variables) => {
  const startTime = performance.now();
  logRequest(operation, variables);

  try {
    const response = await fetch('/graphql', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${getAuthToken()}`,
        'X-Client-Version': process.env.VERSION || 'dev',
      },
      body: JSON.stringify({
        query: operation.text,
        variables,
        operationName: operation.name,
      }),
    });

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    const result = await response.json();
    const duration = performance.now() - startTime;
    logResponse(operation, result, duration);

    // Track metrics
    trackMetric('graphql_request_duration', duration, {
      operation: operation.name,
      success: !result.errors,
    });

    return result;
  } catch (error) {
    const duration = performance.now() - startTime;
    trackMetric('graphql_request_duration', duration, {
      operation: operation.name,
      success: false,
    });
    throw error;
  }
});

// Environment with all features
export const createRelayEnvironment = () => {
  const recordSource = new RecordSource();
  const store = new Store(recordSource, {
    gcReleaseBufferSize: 10,
  });

  return new Environment({
    network,
    store,
    log: console.log, // Enable Relay internal logging in dev
    handlerProvider: undefined,
  });
};

export const relayEnvironment = createRelayEnvironment();
```

## Environment Provider

### React Provider Setup

```typescript
import {RelayEnvironmentProvider} from 'react-relay';

function App() {
  return (
    <RelayEnvironmentProvider environment={relayEnvironment}>
      <Suspense fallback={<LoadingFallback />}>
        <MainApp />
      </Suspense>
    </RelayEnvironmentProvider>
  );
}

function LoadingFallback() {
  return <div>Loading...</div>;
}
```

### Testing with Environment

```typescript
import {createMockEnvironment} from 'relay-test-utils';

describe('MyComponent', () => {
  it('renders correctly', () => {
    const environment = createMockEnvironment();
    const renderer = createMockRenderer({
      environment,
    });

    renderer.getFragmentVariables.mockImplementation(
      (fragmentDef, vars) => ({...vars, count: 10})
    );

    renderer.mockResolvers = {
      User: () => ({
        name: 'Test User',
        email: 'test@example.com',
      }),
    };

    const {getByText} = render(
      <RelayEnvironmentProvider environment={environment}>
        <MyComponent userId="123" />
      </RelayEnvironmentProvider>
    );

    expect(getByText('Test User')).toBeInTheDocument();
  });
});
```

## Use Cases

### Multi-tenant Applications

```typescript
const createTenantEnvironment = (tenantId: string) => {
  const network = Network.create(async (operation, variables) => {
    return fetch('/graphql', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Tenant-ID': tenantId,
      },
      body: JSON.stringify({
        query: operation.text,
        variables,
      }),
    }).then(res => res.json());
  });

  return new Environment({
    network,
    store: new Store(new RecordSource()),
  });
};
```

### Offline-first with Cache

```typescript
// Use cache when offline, sync when online
const network = Network.create(async (operation, variables) => {
  if (!navigator.onLine) {
    throw new Error('Offline - using cached data');
  }

  // Normal fetch
  return fetch('/graphql', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify({
      query: operation.text,
      variables,
    }),
  }).then(res => res.json());
});

// Handle offline state
window.addEventListener('online', () => {
  // Refetch all active queries
  relayEnvironment.getStore().notify();
});
```

## Common Issues & Solutions

### Issue: Stale Data After Login

**Problem:** User logs in, but cache still shows unauthenticated state.

**Solution:** Clear cache on auth state change:
```typescript
function onLogin(token: string) {
  localStorage.setItem('auth_token', token);
  relayEnvironment.getStore().clearCache();
}
```

### Issue: Memory Leaks

**Problem:** Cache grows unbounded over time.

**Solution:** Enable garbage collection:
```typescript
const store = new Store(recordSource, {
  gcReleaseBufferSize: 10, // Run GC after 10 updates
});

const environment = new Environment({
  network,
  store,
  gcScheduler: (callback) => setTimeout(callback, 5000), // Run every 5s
});
```

### Issue: Auth Token Not Refreshing

**Problem:** Requests fail with 401 after token expires.

**Solution:** Implement token refresh interceptor in network layer (see Authentication Integration section).

## See Also

- [[Connection Pattern & Pagination]] — Pagination in Relay
- [[Relay Compiler & Build Setup]] — Build pipeline configuration
- [[Data Masking in Relay]] — How Relay isolates data
- [[Relay Mutations Guide]] — Mutation handling
- [[Relay ESLint Rules Guide]] — Linting Relay code

## External Resources

- [Relay Environment Docs](https://relay.dev/docs/guides/network-layer/)
- [Relay API Reference - Environment](https://relay.dev/docs/api-reference/environment/)
- [Relay API Reference - Network](https://relay.dev/docs/api-reference/network/)
