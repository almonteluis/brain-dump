---
description: "Relay GraphQL subscriptions for real-time data updates"
tags: ["source", "relay", "subscriptions", "real-time", "websockets"]
sources: ["relay-subscriptions-guide.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Relay Subscriptions Guide

**Source:** raw/02_reference/approaches/relay-subscriptions-guide.md
**Date ingested:** 2026-04-09
**Type:** Technical guide

## Summary

Complete guide to GraphQL subscriptions in Relay — real-time data updates via WebSockets, `useSubscription` hook, declarative directives for connection manipulation, and imperative store updaters.

## Key Claims

- Subscriptions establish long-lived connections for push-based updates
- **Must memoize config** with `useMemo` to prevent re-subscriptions
- Fragment spreading in subscriptions recommended over manual field selection
- Declarative directives (`@appendNode`, `@deleteRecord`) work in subscriptions
- WebSocket network layer required (graphql-ws recommended)

## useSubscription Hook

```tsx
function useFeedbackSubscription(input: FeedbackLikeSubscribeData) {
  const config = useMemo(() => ({
    subscription: graphql`
      subscription FeedbackLikeSubscription($input: FeedbackLikeSubscribeData!) {
        feedback_like_subscribe(data: $input) {
          feedback { like_count }
        }
      }
    `,
    variables: {input},
  }), [input]);  // ⚠️ MUST memoize!

  useSubscription(config);
}
```

## Declarative Directives in Subscriptions

| Directive | Purpose |
|-----------|---------|
| `@appendNode` | Add to connection when event fires |
| `@prependNode` | Add to front of connection |
| `@deleteRecord` | Remove item from store |
| `@prependEdge` | Add full edge with cursor |

## WebSocket Configuration

```tsx
import {createClient} from 'graphql-ws';

const wsClient = createClient({
  url: 'ws://localhost:3000/graphql',
  connectionParams: () => ({
    authToken: localStorage.getItem('authToken'),
  }),
});
```

## Best Practices

### ✅ Do
- Memoize config with `useMemo`
- Spread fragments for automatic field selection
- Use declarative directives over updaters
- Handle errors for user feedback

### ❌ Don't
- Forget memoization (causes re-subscriptions)
- Manually select fields (maintenance burden)
- Ignore connection errors

## Entities Mentioned

- [[relay]] — GraphQL client framework
- [[graphql-ws]] — WebSocket client library

## Concepts Covered

- [[useSubscription]] — Hook for real-time updates
- [[subscriptions]] — Push-based data updates
- [[websockets]] — Transport layer for subscriptions
- [[declarative-directives]] — Automatic connection manipulation
