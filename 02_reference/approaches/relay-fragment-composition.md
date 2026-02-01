---
description: Fragment composition lets components include child fragments in their own fragment declarations — parent spreads child's fragment, passes fragment ref, enabling isolated component development.
tags: ["relay", "fragment-composition", "graphql", "component-design"]
created: 2026-01-29
---

# Relay Fragment Composition

## The Pattern

Fragment composition mirrors React component composition:

```
Query → Parent Fragment → Child Fragment → Grandchild Fragment
```

Each component:
1. Declares its own data needs
2. Includes fragments of direct children
3. Passes fragment refs to children

## How It Works

### Child Component

```tsx
// UsernameSection.tsx
const fragment = graphql`
  fragment UsernameSection_user on User {
    username
  }
`;

function UsernameSection({ user }) {
  const data = useFragment(fragment, user);
  return <div>{data.username ?? 'Unknown'}</div>;
}
```

### Parent Component

```tsx
// UserComponent.tsx
const fragment = graphql`
  fragment UserComponent_user on User {
    name
    age

    # Include child fragment
    ...UsernameSection_user
  }
`;

function UserComponent({ user }) {
  const data = useFragment(fragment, user);

  return (
    <>
      <h1>{data.name}</h1>
      <div>{data.age}</div>

      {/* Pass fragment ref to child */}
      <UsernameSection user={data} />
    </>
  );
}
```
{for the parent component. I noticed we not using $ref}

### Root Query

```tsx
// App.tsx
const query = graphql`
  query AppQuery($id: ID!) {
    user(id: $id) {
      name

      # Include fragment (transitively includes child's fragment)
      ...UserComponent_user
    }
  }
`;
```

## Key Insights

### 1. Parent Renders Child AND Includes Child's Fragment

The parent must both:
- Render the child component in JSX
- Include the child's fragment in its GraphQL

This ensures all data is fetched in a single query.

### 2. Fragment Refs Flow Down

```
Query Result → Parent Fragment Ref → Child Fragment Ref → Grandchild Fragment Ref
```

The result of reading a parent fragment serves as the fragment reference for any child fragments included within it.

### 3. Data Isolation

Parent does NOT receive child's data:
- Parent only sees what it declared
- Child only sees what it declared
- Unless both declare the same field, data is isolated

### 4. Local Modification

Adding a field to child component:
```tsx
// Child adds new field
const fragment = graphql`
  fragment UsernameSection_user on User {
    username
    email  # NEW FIELD
  }
`;
```

Parent doesn't need to change! The Relay compiler automatically includes the new field in the query.

## Benefits

| Benefit | Description |
|---------|-------------|
| **Local development** | Change child data needs without touching parents |
| **Clear ownership** | Each component owns its data requirements |
| **Single query** | All fragments compose into one efficient query |
| **Type safety** | Generated types enforce correct fragment usage |
| **Reusable components** | Same component works in different graph contexts |

## Common Patterns

### Same Fragment in Multiple Places

```tsx
// Image component is used in two contexts
const Image = graphql`
  fragment ImageFragment on Image { url }
`;

// Story uses it
const Story = graphql`
  fragment StoryFragment on Story {
    thumbnail {
      ...ImageFragment  # Story thumbnail
    }
  }
`;

// Profile uses it
const Profile = graphql`
  fragment ProfileFragment on User {
    avatar {
      ...ImageFragment  # Profile avatar
    }
  }
`;
```

Modify `ImageFragment` once, updates everywhere.

### Fragment Arguments with Composition

```tsx
// Image fragment accepts size argument
const ImageFragment = graphql`
  fragment ImageFragment on Image
    @argumentDefinitions(width: { type: "Int" })
  {
    url(width: $width)
  }
`;

// Parent passes different sizes
const Story = graphql`
  fragment StoryFragment on Story {
    thumbnail {
      ...ImageFragment @arguments(width: 400)  # Large
    }
  }
`;

const Profile = graphql`
  fragment ProfileFragment on User {
    avatar {
      ...ImageFragment @arguments(width: 60)  # Small
    }
  }
`;
```

## The Golden Rule

> Each React component is responsible for fetching the data dependencies of its direct children — just as it has to know about its children's props to render them correctly.

This enables local reasoning while Relay derives a global view of the entire UI tree's data needs.

---

## Related

[[Data Masking in Relay]]
[[Fragment References]]
[[Relay GraphQL Fragments]]
