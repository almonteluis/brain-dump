---
description: Data masking is Relay's enforcement that components only access data they explicitly declare — fragment references hide data until useFragment extracts it, enabling local reasoning and safe refactoring.
tags: ["relay", "data-masking", "fragments", "encapsulation", "graphql"]
created: 2026-01-29
---

# Data Masking in Relay

## What is Data Masking?

Data masking means: **Relay hides fragment data from components that don't explicitly ask for it.**

Without `useFragment`, the data is invisible — even if it was fetched as part of the query.

## Why Data Masking Exists

### The Problem: Implicit Dependencies

Without data masking, you could accidentally create dependencies between components:

```tsx
// Parent fetches data
const data = useLazyLoadQuery(graphql`
  query AppQuery {
    user { name, email, avatar }
  }
`);

// Child component receives raw data
function Child({ user }) {
  // What if this component starts using user.email?
  // Now the parent can never remove email without breaking this child!
  return <div>{user.name}</div>;
}
```

### The Solution: Explicit Declaration

With data masking:
```tsx
// Parent passes fragment ref
function Parent() {
  const user = useFragment(graphql`
    fragment Parent_user on User {
      name
      ...Child_user  # Child's data needs
    }
  `, userRef);
  return <Child user={user} />;
}

// Child declares its own needs
function Child({ user }) {
  const data = useFragment(graphql`
    fragment Child_user on User {
      name
      # email  # Can add this later, parent doesn't need to know
    }
  `, user);
  return <div>{data.name}</div>;
}
```

## What Data Masking Enables

### 1. Safe Refactoring

You can remove fields from fragments with confidence:
- If no component uses it → safe to remove
- If something breaks → you know exactly where

### 2. Local Reasoning

To understand a component's data needs, you only look at that component:
- No need to trace through parent queries
- No hidden dependencies
- Changes stay local

### 3. Component Self-Containment

Components are portable and isolated:
- Can move component anywhere
- Can reuse in different contexts
- Parent doesn't need to know implementation details

## How It Works

```tsx
const fragmentRef = { /* opaque object */ };

// BEFORE useFragment: data is hidden
console.log(fragmentRef.name);  // undefined!
console.log(fragmentRef);  // Looks empty

// AFTER useFragment: data is extracted
const data = useFragment(MyFragment, fragmentRef);
console.log(data.name);  // "Alice"
```

The fragment reference contains:
- Hidden fields telling Relay where to look
- A pointer to the specific graph node
- Metadata about what fields are readable

## The Anti-Pattern: Prop Drilling Raw Data

```tsx
// BAD: Prop drilling raw data
const ProfileCard = ({ userName, avatar }) => (
  <Header userName={userName} avatar={avatar} />
);
const Header = ({ userName, avatar }) => (
  <Name userName={userName} avatar={avatar} />
);
const Name = ({ userName, avatar }) => (
  <div>{avatar}{userName}</div>
);

// Removing 'icon' requires changes to ALL 3 components
```

## The Pattern: Fragment Refs

```tsx
// GOOD: Passing fragment refs
const ProfileCard = ({ userRef }) => {
  const data = useFragment(...);
  return <Header userRef={userRef} />;
};

const Header = ({ userRef }) => (
  <Name userRef={userRef} />
);

const Name = ({ userRef }) => {
  const data = useFragment(
    graphql`fragment NameFragment on User { avatar, userName }`,
    userRef
  );
  return <div>{data.avatar}{data.userName}</div>;
};

// Removing 'icon' only requires changing NameFragment
```

## Key Insight

> Data masking prevents separate components from even accidentally having implicit dependencies on each other. If this wasn't the case, modifying a component could break other components!

---

## Related

[[Relay GraphQL Fragments]]
[[Fragment References]]
[[Relay Fragment Composition]]
