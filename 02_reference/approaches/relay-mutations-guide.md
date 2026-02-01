---
description: Complete guide to GraphQL mutations in Relay — mutation structure, useMutation hook, optimistic updates, connection manipulation, and store updaters.
tags: ["relay", "mutations", "optimistic-updates", "useMutation", "store-updaters"]
created: 2026-02-01
---

# GraphQL Mutations in Relay

## What Are Mutations?

In GraphQL, data is updated using **GraphQL mutations**. Mutations are read-write server operations that modify data on backend and query modified data in the same request.

## Writing Mutations

### Basic Mutation Structure

```graphql
mutation FeedbackLikeMutation($input: FeedbackLikeData!) {
  feedback_like(data: $input) {
    feedback {
      id
      viewer_does_like
      like_count
    }
  }
}
```

**Key points:**
- `mutation` keyword (not `query`)
- `feedback_like` is mutation root field
- Returns updated data for query response
- Two-step process: server update + query execution

## useMutation Hook

### Basic Usage

```typescript
import {graphql, useMutation} from 'react-relay';
import type {FeedbackLikeData, LikeButtonMutation} from 'LikeButtonMutation.graphql';

function LikeButton({feedbackId}: {feedbackId: string}) {
  const [commitMutation, isMutationInFlight] = useMutation<LikeButtonMutation>(
    graphql`
      mutation LikeButtonMutation($input: FeedbackLikeData!) {
        feedback_like(data: $input) {
          feedback {
            viewer_does_like
            like_count
          }
        }
      }
    `
  );

  return (
    <button
      onClick={() => commitMutation({
        variables: {input: {id: feedbackId}},
      })}
      disabled={isMutationInFlight}
    >
      Like
    </button>
  );
}
```

### Return Values

`useMutation` returns a tuple:
- **Callback** (`commitMutation`) — Accepts `UseMutationConfig`
- **In-flight status** (`isMutationInFlight`) — Boolean, mutation in progress

## Refreshing Components After Mutations

### Manual Field Selection

```graphql
mutation FeedbackLikeMutation($input: FeedbackLikeData!) {
  feedback_like(data: $input) {
    feedback {
      viewer_does_like
      like_count
    }
  }
}
```

**Issue:** Requires manual field selection.

### Fragment Spreading (Recommended)

```graphql
mutation FeedbackLikeMutation($input: FeedbackLikeData!) {
  feedback_like(data: $input) {
    feedback {
      ...FeedbackDisplay_feedback
      ...FeedbackDetail_feedback
    }
  }
}
```

**Why better:**
- Spreads all fragment fields automatically
- Components stay consistent if fragments change
- Refetches affected components in single request

## Mutation Callbacks

### onCompleted

```typescript
const [commitMutation] = useMutation<LikeButtonMutation>(
  mutationLikeMutation,
  {
    onCompleted: (response, errors) => {
      // response is mutation fragment (after updaters applied)
      // Data from masked fragments not available
      if (!errors) {
        console.log('Mutation successful!', response);
      }
    },
  }
);
```

**What you get:**
- Mutation response (at fragment spread boundaries)
- `onCompleted` called **after** declarative directives applied
- Masked fragment data is **not** included

### onError

```typescript
const [commitMutation] = useMutation<LikeButtonMutation>(
  mutationLikeMutation,
  {
    onError: (error) => {
      console.error('Mutation failed:', error);
      // Show error to user
      alert('Failed to like: ' + error.message);
    },
  }
);
```

## Declarative Mutation Directives

### @appendNode (Add to Connection)

```graphql
mutation AddCommentMutation($input: CommentData!) {
  add_comment(data: $input) {
    comment_edge @appendNode(connection: "Viewer_comments") {
      node {
        ...CommentDisplay_comment
      }
    }
  }
}
```

### @prependNode (Add to Front)

```graphql
mutation AddPostMutation($input: PostData!) {
  add_post(data: $input) {
    post_edge @prependNode(connection: "User_posts") {
      node {
        ...PostDisplay_post
      }
    }
  }
}
```

### @deleteRecord (Delete Item)

```graphql
mutation DeletePostMutation($input: DeletePostData!) {
  delete_post(data: $input) {
    deleted_post @deleteRecord {
      id
    }
  }
}
```

### @prependEdge (Add Edge)

```graphql
mutation InsertCommentMutation($input: CommentData!) {
  insert_comment(data: $input) {
    comment_edge @prependEdge(connection: "Post_comments", edgeTypeName: "CommentEdge") {
      cursor
      node {
        ...CommentDisplay_comment
      }
    }
  }
}
```

**No manual updaters needed** — Relay handles connection updates automatically!

## Imperative Store Updates

### When to Use

- Complex updates beyond field value changes
- Updates depending on current store state
- Cases not covered by declarative directives

### Optimistic Updaters

**For optimistic responses:**

```typescript
const [commitMutation] = useMutation<LikeButtonMutation>(
  mutationLikeMutation,
  {
    optimisticUpdater: (store) => {
      // Read current data from store
      const feedback = store.get(feedbackId);

      // Create optimistic record
      store.create(feedbackId, {
        ...feedback,
        viewer_does_like: true,
        like_count: feedback.like_count + 1,
      });
    },
  }
);
```

### Regular Updaters

```typescript
const [commitMutation] = useMutation<LikeButtonMutation>(
  mutationLikeMutation,
  {
    updater: (store, response) => {
      // Get mutation payload
      const payload = store.getRootField('feedback_like');

      // Update store
      if (payload?.feedback) {
        store.get(feedbackId).setValue(payload.feedback);
      }
    },
  }
);
```

**Payload access:**
- `store.getRootField('mutationName')` — Returns mutation root
- Field names from mutation response

## Optimistic Responses

### Basic Pattern

```graphql
mutation LikeButtonMutation($input: FeedbackLikeData!)
  @raw_response_type {
  feedback_like(data: $input) {
    feedback {
      viewer_does_like
      like_count
    }
  }
}
```

**Key directive:** `@raw_response_type` — Allows Flow-typed optimistic responses

### TypeScript Optimistic Response

```typescript
const [commitMutation] = useMutation<LikeButtonMutation>(
  mutationLikeMutation,
  {
    optimisticResponse: {
      feedback_like: {
        feedback: {
          id: feedbackId,
          viewer_does_like: true,
          like_count: currentLikeCount + 1,
        },
      },
    },
  }
);
```

### Reading Values for Optimistic Updates

```typescript
const data = useFragment(
  graphql`
    fragment LikeButton_feedback on Feedback {
      __id
      viewer_does_like @required(action: THROW)
      like_count @required(action: THROW)
    }
  `,
  feedback,
);

const changeToLikeCount = data.viewer_does_like ? -1 : 1;
```

**@required(action: THROW)** — Forces read, allows optimistic update calculation.

### ⚠️ Optimistic Response Pitfalls

**Don't use optimistic responses when:**
- Value depends on store (may cause inconsistencies)
- Multiple optimistic responses affect same value (race conditions)
- Fragment spreads in optimistic response (can cause partial data)
- Large optimistic responses (performance degradation)

**Better approach:** Use `optimisticUpdater` when possible.

## Execution Order

Relay processes mutations in this order:

1. **Optimistic response** → Written to store (if provided)
2. **Optimistic updater** → Executed (if provided)
3. **Declarative directives** → Processed on optimistic data
4. **Mutation succeeds:**
   - Roll back optimistic update
   - Write server response to store
5. **Updater** → Executed with server payload
6. **Declarative directives** → Processed on server data
7. **onCompleted** → Callback executed

**Mutation fails:**
- Roll back optimistic update
- Call `onError` callback

## Invalidating Data During Mutations

### Recommended: Refetch All Affected Data

Request all relevant data back from server:

```graphql
mutation FeedbackLikeMutation($input: FeedbackLikeData!) {
  feedback_like(data: $input) {
    feedback {
      ...FeedbackDisplay_feedback
      ...FeedbackDetail_feedback
    }
  }
}
```

### Advanced: Manual Invalidation

Use staleness APIs when declarative approach is infeasible:

```typescript
const [commitMutation] = useMutation<BlockUserMutation>(
  blockUserMutation,
  {
    onCompleted: () => {
      // Invalidate all user-related data
      requestSubscription.invalidate([
        {requestName: 'UserQuery', variables: {id: userId}},
        {requestName: 'UserPostsQuery', variables: {id: userId}},
      ]);
    },
  }
);
```

## See Also

- [[Data Masking in Relay]] — How fragment data masking works
- [[Fragment Composition]] — Building reusable fragments
- [[Fragment References]] — Using fragment keys in components
- [[useLazyLoadQuery]] — Query data fetching
- [[Connection Pattern]] — Managing list data

## External Resources

- [Official Relay Mutation Docs](https://relay.dev/docs/guided-tour/updating-data/graphql-mutations/)
- [Relay API Reference - useMutation](https://relay.dev/docs/api-reference/use-mutation/)
- [Relay API Reference - MutationConfig](https://relay.dev/docs/api-reference/types/MutationConfig/)
