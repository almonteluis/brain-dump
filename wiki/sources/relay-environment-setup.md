---
description: "Relay environment and network layer configuration"
tags: ["source", "relay", "environment", "network-layer", "authentication", "cache"]
sources: ["relay-environment-setup.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Relay Environment Setup

**Source:** raw/02_reference/approaches/relay-environment-setup.md
**Date ingested:** 2026-04-09
**Type:** Configuration guide

## Summary

Complete guide to setting up Relay Environment — configuration, network layer, authentication, cache policies, and error handling boundaries for production-ready Relay applications.

## Key Claims

- RelayEnvironment manages network, store, schedulers, logging
- One environment instance per application context
- Network layer must handle authentication, errors, retries
- Cache can be persisted to localStorage

## Basic Environment Setup

```typescript
import {Environment, Network, RecordSource, Store} from 'relay-runtime';

const recordSource = new RecordSource();
const store = new Store(recordSource);
const network = Network.create(async (operation, variables) => {
  const response = await fetch('/graphql', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify({query: operation.text, variables}),
  });
  return response.json();
});

const environment = new Environment({network, store});
```

## Authentication Integration

### Token-based Auth
```typescript
const network = Network.create(async (operation, variables) => {
  const token = localStorage.getItem('auth_token');

  const response = await fetch('/graphql', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${token}`,
    },
    body: JSON.stringify({query: operation.text, variables}),
  });

  if (response.status === 401) {
    logoutUser();
    throw new Error('Authentication required');
  }

  return response.json();
});
```

## Cache Configuration

### Fetch Policies
- `store-or-network` — Check cache first, fetch in background
- `store-only` — Return cache only
- `network-only` — Always fetch, ignore cache

### Cache Persistence
```typescript
// Load persisted cache
const loadCache = async (): Promise<RecordSource> => {
  const persisted = await localStorage.getItem('relay-cache');
  if (persisted) {
    return RecordSource.create(JSON.parse(persisted));
  }
  return new RecordSource();
};
```

## Error Handling

### Error Boundaries
```typescript
function App() {
  return (
    <RelayEnvironmentProvider environment={environment}>
      <ErrorBoundary fallback={<ErrorFallback />}>
        <AppContent />
      </ErrorBoundary>
    </RelayEnvironmentProvider>
  );
}
```

## Production-Ready Setup

```typescript
const network = Network.create(async (operation, variables) => {
  const startTime = performance.now();

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

    const result = await response.json();
    const duration = performance.now() - startTime;

    trackMetric('graphql_request_duration', duration, {
      operation: operation.name,
      success: !result.errors,
    });

    return result;
  } catch (error) {
    trackMetric('graphql_request_duration', performance.now() - startTime, {
      operation: operation.name,
      success: false,
    });
    throw error;
  }
});
```

## Entities Mentioned

- [[relay]] — GraphQL client framework
- [[react-patterns]] — UI library

## Concepts Covered

- [[relay-environment]] — Central configuration object
- [[network-layer]] — HTTP request handling
- [[authentication]] — Token-based and cookie-based auth
- [[cache-policies]] — Store vs network fetching
- [[error-handling]] — Boundaries and logging
