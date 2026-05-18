---
description: Relay fragments let each component declare its own data needs independently while retaining single-query efficiency — co-location, data masking, and composition patterns for GraphQL data fetching.
tags:
  - relay
  - graphql
  - fragments
  - data/fetching
  - react
  - marvin/frontend
created: 2026-01-29
source: https://relay.dev/docs/tutorial/fragments-1/
---

# Relay Fragments

> Fragments are one of the distinguishing features of Relay. They let each component declare its own data needs independently, while retaining the efficiency of a single query.

## The Core Problem

Without fragments:

```tsx
// Parent fetches ALL the data
const data = useLazyLoadQuery(graphql`
  query getUserProfiles {
    userProfiles {
      profiles  // Child needs this
      otherField
    }
  }
`);

// Pass data as props
<UserDashboard profiles={data?.userProfiles?.profiles} />
```

**Problems:**
- Parent must know child's data requirements
- Changing child's data needs = changing parent
- Unused fields accumulate over time
- Components aren't self-contained

## The Fragment Pattern

### 1. Define fragment in component file

```tsx
const UserFragment = graphql`
  fragment UserFragment on User {
    name
    profile_picture(scale: 2) {
      uri
    }
  }
`;
```

### 2. Spread fragment in parent query

```tsx
const query = graphql`
  query AppQuery {
    user {
      ...UserFragment  # Spread here
    }
  }
`;
```

### 3. Pass fragment reference to child

```tsx
<User user={data.user} />  // Pass fragment ref, not raw data
```

### 4. Read data with useFragment

```tsx
function User({ user }: { user: UserFragment$key }) {
  const data = useFragment(UserFragment, user);
  return <h1>{data.name}</h1>;
}
```

## Key Concepts

### Fragment References (Fragment Keys)

A fragment reference is an opaque object that Relay uses to read data. It contains:
- Hidden fields telling Relay where to look for data
- Which node to read from
- What fields can be read

**The fragment ref specifies WHERE in the graph to read, not WHAT to read.**

### Data Masking

Relay hides fragment data from components that don't explicitly ask for it via `useFragment`.

**Why?** If data wasn't masked:
- You could never safely remove a field from a fragment
- Components would implicitly depend on each other's data
- Changes would ripple unpredictably

**Data masking enforces local reasoning.**

### Fragment Composition

Fragments can include other fragments:

```graphql
fragment UserFragment on User {
  name
  ...AnotherUserFragment  # Compose fragments
}

fragment AnotherUserFragment on User {
  username
  ...FooUserFragment  # And compose more
}
```

Parent components spread child fragments:

```tsx
// Parent includes child's fragment
const userFragment = graphql`
  fragment UserComponent_user on User {
    name
    ...UsernameSection_user  # Child fragment
  }
`;

// Pass fragment ref to child
<UsernameSection user={user} />
```

## Fragment Arguments

Fragments can accept arguments for runtime flexibility:

```graphql
fragment ImageFragment on Image
  @argumentDefinitions(
    width: { type: "Int", defaultValue: null }
    height: { type: "Int", defaultValue: null }
  )
{
  url(width: $width, height: $height)
  altText
}
```

Used at spread time:

```graphql
...ImageFragment @arguments(width: 400)
...ImageFragment @arguments(width: 60, height: 60)
```

## Benefits

| Benefit | Description |
|---------|-------------|
| **Self-contained** | Components declare own data needs |
| **Reusable** | Same fragment works in different graph contexts |
| **No unused fields** | ESLint enforces all queried fields are used |
| **Type-safe** | Generated types for fragment refs and data |
| **Auto-updates** | Components subscribe to fragment data changes |
| **Scalable** | Modify component's data needs without changing parents |

## ESLint Rules

Two key rules enforce fragment usage:
- `unused-fields` — Error when queried fields aren't used
- `must-colocate-fragment-spreads` — Error when fragments aren't co-located with components

---

## Related

[[relay-data-masking]]
[[relay-fragment-references]]
[[relay-fragment-composition]]
[[relay-usefragment]]
[[relay-graphql-patterns]]
