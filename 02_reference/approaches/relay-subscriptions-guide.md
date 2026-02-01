---
description: Complete guide to GraphQL subscriptions in Relay — real-time data updates, useSubscription hook, WebSocket configuration, connection manipulation, and store updaters.
tags: ["relay", "subscriptions", "real-time", "useSubscription", "websockets", "optimistic-updates", "store-updaters"]
created: 2026-02-01
---

# GraphQL Subscriptions in Relay

## What Are Subscriptions?

In GraphQL, **subscriptions** are a mechanism to allow clients to query for data in response to a stream of server-side events. Unlike queries (fetch data once) and mutations (modify data), subscriptions establish a long-lived connection that receives push-based updates when server-side events occur.

### Basic Subscription Structure

```graphql
subscription FeedbackLikeSubscription($input: FeedbackLikeSubscribeData!) {
  feedback_like_subscribe(data: $input) {
    feedback {
      id
      like_count
    }
  }
}
```

**Key points:**
- Uses `subscription` keyword (not `query` or `mutation`)
- `feedback_like_subscribe` is a **subscription root field** that sets up the subscription on the backend
- Two-step process: server-side event occurs → query is executed
- Returns updated data for each event in the stream

### Subscription Payload Example

When a subscription event fires, the client receives a payload like:

```json
{
  "feedback_like_subscribe": {
    "feedback": {
      "id": "feedback-id",
      "like_count": 321
    }
  }
}
```

## useSubscription Hook

### Basic Usage

```typescript
import {graphql, useSubscription} from 'react-relay';
import {useMemo} from 'react';
import type {FeedbackLikeSubscribeData} from 'FeedbackLikeSubscription.graphql';

function useFeedbackSubscription(input: FeedbackLikeSubscribeData) {
  const config = useMemo(() => ({
    subscription: graphql`
      subscription FeedbackLikeSubscription($input: FeedbackLikeSubscribeData!) {
        feedback_like_subscribe(data: $input) {
          feedback {
            like_count
          }
        }
      }
    `,
    variables: {input},
  }), [input]);

  useSubscription(config);
}

function FeedbackComponent({feedbackId}: {feedbackId: string}) {
  useFeedbackSubscription({feedbackId});
  // Component will re-render when like_count changes
  return <div>Watching feedback {feedbackId}</div>;
}
```

### Important Notes

**⚠️ Memoize your config!**

```typescript
// ❌ WRONG - creates new config on every render
function BadComponent({id}) {
  useSubscription({
    subscription: graphql`...`,
    variables: {id},
  });
}

// ✅ CORRECT - memoize config
function GoodComponent({id}) {
  const config = useMemo(() => ({
    subscription: graphql`...`,
    variables: {id},
  }), [id]);
  useSubscription(config);
}
```

Without memoization, `useSubscription` will dispose and re-establish the subscription on every render, causing unnecessary network traffic and potential memory leaks.

### GraphQLSubscriptionConfig

The config object accepts these fields:

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `subscription` | `GraphQLTaggedNode` | ✅ | GraphQL subscription literal |
| `variables` | `object` | ✅ | Variables for the subscription |
| `onNext` | `(payload) => void` | ❌ | Called when subscription event fires |
| `onError` | `(error) => void` | ❌ | Called when subscription errors |
| `onCompleted` | `() => void` | ❌ | Called when server ends subscription |
| `updater` | `SelectorStoreUpdater` | ❌ | Imperative store update function |
| `cacheConfig` | `CacheConfig` | ❌ | Cache behavior configuration |

## Subscription Behavior

### How Subscriptions Work

1. **Establish connection** - When `useSubscription` is called, Relay creates a WebSocket connection
2. **Register subscription** - Sends the subscription operation to the server
3. **Receive events** - Server pushes events as they occur
4. **Update store** - Relay updates the local store with each event payload
5. **Re-render components** - Components depending on changed data re-render

### Automatic ID Selection

If the subscription returns a type with an `id` field, Relay automatically adds a selection for it:

```graphql
# You write this:
subscription FeedbackLikeSubscription($input: FeedbackLikeSubscribeData!) {
  feedback_like_subscribe(data: $input) {
    feedback {
      like_count  # Only selected like_count
    }
  }
}

# Relay compiles to this (automatically adds id):
subscription FeedbackLikeSubscription($input: FeedbackLikeSubscribeData!) {
  feedback_like_subscribe(data: $input) {
    feedback {
      id  # Automatically added by Relay
      like_count
    }
  }
}
```

Relay uses the `id` to find the corresponding object in the store and update it.

### Component Refreshing

When a subscription payload is received:

1. Relay finds the object in the store by `id`
2. Updates fields with new values
3. If values changed, components that selected those fields re-render

**Example:**

```typescript
// This component will re-render when like_count changes
const feedback = useFragment(
  graphql`
    fragment FeedbackDisplay_feedback on Feedback {
      id
      like_count  # Will receive updates from subscription
    }
  `,
  feedbackRef,
);
```

## Refreshing Components with Fragments

### Manual Field Selection (Not Recommended)

```graphql
subscription FeedbackLikeSubscription($input: FeedbackLikeSubscribeData!) {
  feedback_like_subscribe(data: $input) {
    feedback {
      like_count  # Manually selecting specific fields
    }
  }
}
```

**Problem:**
- Requires knowing all fields components need
- Must stay in sync when components change
- Violates Relay's goal of avoiding global reasoning

### Fragment Spreading (Recommended)

```graphql
subscription FeedbackLikeSubscription($input: FeedbackLikeSubscribeData!) {
  feedback_like_subscribe(data: $input) {
    feedback {
      ...FeedbackDisplay_feedback  # Automatically includes all fragment fields
      ...FeedbackDetail_feedback   # Multiple fragments
    }
  }
}
```

**Benefits:**
- Automatically includes all fragment fields
- Components stay consistent if fragments change
- Single round trip to fetch all updated data
- No manual field management needed

## Subscription Callbacks

### onNext - Handle Subscription Events

```typescript
useSubscription({
  subscription: graphql`
    subscription MessageSubscription($input: MessageSubscribeData!) {
      message_subscribe(data: $input) {
        message {
          id
          content
        }
      }
    }
  `,
  variables: {input: {channelId: '123'}},
  onNext: (response) => {
    // Called when subscription event fires
    // response contains subscription data (at fragment spread boundaries)
    console.log('New message:', response);
  },
});
```

**What you get:**
- Subscription payload (at fragment spread boundaries)
- Masked fragment data is **not** included
- Called **before** declarative directives are applied

### onError - Handle Errors

```typescript
useSubscription({
  subscription: graphql`...`,
  variables: {input: {...}},
  onError: (error) => {
    console.error('Subscription error:', error);
    // Show error to user
    alert('Connection lost: ' + error.message);
  },
});
```

### onCompleted - Handle Server-Side Closes

```typescript
useSubscription({
  subscription: graphql`...`,
  variables: {input: {...}},
  onCompleted: () => {
    // Called when server ends the subscription
    console.log('Subscription closed by server');
  },
});
```

**Use cases:**
- Notify user subscription ended
- Clean up UI elements
- Attempt reconnection logic

## Declarative Mutation Directives in Subscriptions

Declarative directives that work in mutations also work in subscriptions, allowing automatic connection manipulation.

### @appendNode - Add to Connection

```graphql
subscription NewPostSubscription($input: PostSubscribeData!) {
  post_created(data: $input) {
    post_edge @appendNode(connection: "Viewer_posts") {
      node {
        id
        title
        ...PostDisplay_post
      }
    }
  }
}
```

**What happens:**
- When a new post is created via subscription
- Relay automatically appends it to the `Viewer_posts` connection
- No manual updater needed

### @prependNode - Add to Front

```graphql
subscription NewCommentSubscription($input: CommentSubscribeData!) {
  comment_created(data: $input) {
    comment_edge @prependNode(connection: "Post_comments") {
      node {
        id
        content
        ...CommentDisplay_comment
      }
    }
  }
}
```

### @prependEdge - Add Full Edge

```graphql
subscription NewMessageSubscription($input: MessageSubscribeData!) {
  message_created(data: $input) {
    message_edge @prependEdge(
      connection: "Chat_messages"
      edgeTypeName: "MessageEdge"
    ) {
      cursor
      node {
        id
        content
        ...MessageDisplay_message
      }
    }
  }
}
```

### @deleteRecord - Delete Item

```graphql
subscription DeletePostSubscription($input: DeletePostSubscribeData!) {
  delete_post_subscribe(data: $input) {
    deleted_post {
      id @deleteRecord  # Removes this record from store
    }
  }
}
```

**What happens:**
- When a post is deleted via subscription
- Relay automatically removes it from the store
- Components referencing this post receive `null` data

## Imperative Store Updaters

### When to Use Updaters

Use `updater` when:
- Updates are more complex than field value changes
- Updates depend on current store state
- Multiple records need coordinated updates
- Client schema extensions need initialization
- You need to invalidate or delete nodes

### Basic Updater Pattern

```typescript
useSubscription({
  subscription: graphql`
    subscription CommentSubscription($input: CommentSubscribeData!) {
      comment_subscribe(data: $input) {
        comment {
          id
          ...Comment_updatable
        }
      }
    }
  `,
  variables: {input: {postId: '123'}},
  updater: (store, response) => {
    // Step 1: Access subscription payload
    const payload = store.getRootField('comment_subscribe');
    if (!payload) return;

    // Step 2: Get the comment reference
    const commentRef = payload.getLinkedRecord('comment');
    if (!commentRef) return;

    // Step 3: Read updatable fragment
    const {updatableData} = store.readUpdatableFragment(
      graphql`
        fragment Comment_updatable on Comment @updatable {
          is_new
          read_count
        }
      `,
      commentRef
    );

    // Step 4: Update fields
    updatableData.is_new = true;
    updatableData.read_count = 0;
  },
});
```

### Connection Manipulation with Updaters

```typescript
import {ConnectionHandler} from 'relay-runtime';

useSubscription({
  subscription: graphql`...`,
  variables: {input: {...}},
  updater: (store, response) => {
    const payload = store.getRootField('post_created');
    const postEdge = payload.getLinkedRecord('post_edge');

    // Get the connection
    const viewer = store.getRoot().getLinkedRecord('viewer');
    const connection = ConnectionHandler.getConnection(
      viewer,
      'Viewer_posts'  // Connection name
    );

    // Insert edge into connection
    if (connection) {
      ConnectionHandler.insertEdgeAfter(connection, postEdge);
    }
  },
});
```

### Finding Connections

```typescript
useSubscription({
  subscription: graphql`...`,
  variables: {input: {...}},
  updater: (store, response) => {
    const payload = store.getRootField('user_updated');

    // Find all connections at a specific field
    const user = store.get(userId);
    const connections = ConnectionHandler.getConnections(
      user,
      'User_posts'  // Field name
    );

    // Update all connections
    connections.forEach(connection => {
      ConnectionHandler.deleteNode(connection, postId);
    });
  },
});
```

### Using readUpdatableQuery

```typescript
useSubscription({
  subscription: graphql`...`,
  variables: {input: {...}},
  updater: (store) => {
    // Access root query directly
    const {updatableData} = store.readUpdatableQuery(
      graphql`
        query UpdateViewerQuery @updatable {
          viewer {
            notification_count
          }
        }
      `,
      {}  // No variables needed
    );

    if (updatableData.viewer) {
      updatableData.viewer.notification_count = 0;
    }
  },
});
```

**When to use `readUpdatableQuery`:**
- You don't have ready access to a fragment reference
- You need to update top-level query fields
- You want to use variables in the updatable operation

## Network Layer Configuration (WebSockets)

Subscriptions require a WebSocket-capable network layer. GraphQL subscriptions are typically communicated over WebSockets.

### Using graphql-ws (Recommended)

```typescript
import {Network, Observable} from 'relay-runtime';
import {createClient} from 'graphql-ws';

// Create WebSocket client
const wsClient = createClient({
  url: 'ws://localhost:3000/graphql',
  connectionParams: () => ({
    authToken: localStorage.getItem('authToken'),
  }),
  on: {
    connected: () => console.log('WebSocket connected'),
    error: (error) => console.error('WebSocket error:', error),
  },
});

// Create subscribe function
const subscribe = (operation, variables) => {
  return Observable.create((sink) => {
    return wsClient.subscribe(
      {
        operationName: operation.name,
        query: operation.text,
        variables,
      },
      sink,
    );
  });
};

// Create network layer with both fetch and subscribe
const network = Network.create(fetchQuery, subscribe);
```

### Using subscriptions-transport-ws (Legacy)

```typescript
import {Network, Observable} from 'relay-runtime';
import {SubscriptionClient} from 'subscriptions-transport-ws';

// Create subscription client
const subscriptionClient = new SubscriptionClient('ws://localhost:3000/graphql', {
  reconnect: true,
  connectionParams: {
    authToken: localStorage.getItem('authToken'),
  },
});

// Create subscribe function
const subscribe = (request, variables) => {
  const subscribeObservable = subscriptionClient.request({
    query: request.text,
    operationName: request.name,
    variables,
  });

  // Convert subscriptions-transport-ws observable to Relay's Observable
  return Observable.from(subscribeObservable);
};

// Create network layer
const network = Network.create(fetchQuery, subscribe);
```

### Combining fetch and subscribe

```typescript
// Standard fetch function
const fetchQuery = async (operation, variables) => {
  const response = await fetch('http://localhost:3000/graphql', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      query: operation.text,
      variables,
    }),
  });

  return response.json();
};

// WebSocket subscribe function
const subscribe = (operation, variables) => {
  return Observable.create((sink) => {
    return wsClient.subscribe(
      {
        operationName: operation.name,
        query: operation.text,
        variables,
      },
      sink,
    );
  });
};

// Create Relay environment
const network = Network.create(fetchQuery, subscribe);
const environment = new Environment({network, store});
```

## requestSubscription API

### Imperative Subscription Creation

For cases where you need imperative control (outside of React components), use `requestSubscription`:

```typescript
import {graphql, requestSubscription} from 'react-relay';

const subscription = graphql`
  subscription UserDataSubscription($input: InputData!) {
    user_updated(data: $input) {
      user {
        id
        name
      }
    }
  }
`;

function createSubscription(environment, userId) {
  return requestSubscription(environment, {
    subscription,
    variables: {input: {userId}},
    onNext: (response) => {
      console.log('User updated:', response);
    },
    onError: (error) => {
      console.error('Subscription error:', error);
    },
  });
}
```

### Disposing Subscriptions

`requestSubscription` returns a `Disposable` object:

```typescript
const disposable = createSubscription(environment, userId);

// Later, dispose of the subscription
disposable.dispose();
```

**Common patterns:**

```typescript
// In a component
useEffect(() => {
  const disposable = requestSubscription(environment, {
    subscription,
    variables: {input: {userId}},
  });

  return () => disposable.dispose(); // Cleanup on unmount
}, [userId]);
```

## Subscription Lifecycle Management

### Lifecycle Stages

1. **Mount** - Component mounts → subscription config created
2. **Establish** - WebSocket connection established → subscription registered
3. **Active** - Server pushes events → store updates → components re-render
4. **Error** - If connection fails → `onError` called → may reconnect
5. **Close** - Server closes subscription → `onCompleted` called
6. **Unmount** - Component unmounts → subscription disposed

### Handling Reconnection

```typescript
useSubscription({
  subscription: graphql`...`,
  variables: {input: {userId}},
  onError: (error) => {
    console.error('Subscription error:', error);

    // Show user message
    toast.error('Real-time updates unavailable. Retrying...');

    // Relay automatically handles reconnection with graphql-ws
    // No manual retry logic needed
  },
});
```

### Conditional Subscriptions

```typescript
function CommentSection({postId, isAuthenticated}) {
  const config = useMemo(() => {
    if (!isAuthenticated) {
      // Don't subscribe if not authenticated
      return null;
    }

    return {
      subscription: graphql`
        subscription CommentSubscription($postId: ID!) {
          comment_added(postId: $postId) {
            comment {
              ...CommentDisplay_comment
            }
          }
        }
      `,
      variables: {postId},
    };
  }, [postId, isAuthenticated]);

  if (config) {
    useSubscription(config);
  }

  // Render component
}
```

### Multiple Subscriptions

```typescript
function NotificationCenter() {
  // Subscribe to all notification types
  useSubscription({
    subscription: graphql`...`,
    variables: {input: {type: 'MESSAGE'}},
  });

  useSubscription({
    subscription: graphql`...`,
    variables: {input: {type: 'LIKE'}},
  });

  useSubscription({
    subscription: graphql`...`,
    variables: {input: {type: 'COMMENT'}},
  });

  // All three subscriptions will be active
}
```

## Best Practices

### ✅ Do

- **Memoize config** - Use `useMemo` to prevent unnecessary re-subscriptions
- **Spread fragments** - Let Relay handle field selection automatically
- **Use declarative directives** - Prefer `@appendNode`, `@deleteRecord` over updaters
- **Handle errors** - Provide user feedback for connection issues
- **Clean up subscriptions** - Let `useSubscription` handle cleanup automatically

### ❌ Don't

- **Forget memoization** - Causes constant re-subscriptions
- **Manually select fields** - Creates maintenance burden
- **Use complex optimistic responses** - Can cause race conditions
- **Ignore errors** - Users should know if real-time features fail
- **Subscribe to unneeded data** - Only subscribe to what you display

### Performance Tips

1. **Use specific subscriptions** - Subscribe only to data you need
2. **Debounce rapid updates** - If server sends many events, consider debouncing
3. **Limit subscription scope** - Use filters/variables to reduce event frequency
4. **Monitor connection health** - Alert if WebSocket disconnects frequently

## See Also

- [[GraphQL Mutations in Relay]] — Updating data with mutations
- [[Connection Pattern]] — Managing list data with connections
- [[useFragment]] — Reading data from the store
- [[useLazyLoadQuery]] — Fetching data on mount
- [[Data Masking in Relay]] — How fragment data masking works

## External Resources

- [Official Relay Subscriptions Docs](https://relay.dev/docs/guided-tour/updating-data/graphql-subscriptions/)
- [Relay API Reference - useSubscription](https://relay.dev/docs/api-reference/use-subscription/)
- [Relay API Reference - requestSubscription](https://relay.dev/docs/api-reference/request-subscription/)
- [graphql-ws Library](https://github.com/enisdenjo/graphql-ws) — WebSocket client for GraphQL
- [subscriptions-transport-ws Library](https://github.com/apollographql/subscriptions-transport-ws) — Legacy WebSocket client
