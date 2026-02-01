---
description: The @alias directive in Relay puts each fragment on its own property instead of nesting in fragmentRefs — solves conditional fragments and abstract type matching issues.
tags: ["relay", "graphql", "alias-directive", "fragments", "conditional-fragments"]
created: 2026-01-29
---

# Relay @alias Directive

## The Problem

By default, ALL fragment references on the same object are nested within `fragmentRefs`:

```tsx
// When you spread multiple fragments
const fragment = graphql`
  fragment Parent on User {
    ...Child1_user
    ...Child2_user @include(if: $showChild2)
  }
`;

// All fragment refs are in one place
data.fragmentRefs  // Contains both Child1 and Child2 refs
```

This causes problems with:
1. **Conditional fragments** (`@include`, `@skip`) — No way to know if fragment was included
2. **Abstract types** — Union/interface fragment spreads

## The Solution: @alias

```tsx
const fragment = graphql`
  fragment Parent on User {
    ...Child1_user @alias
    ...Child2_user @include(if: $showChild2) @alias
  }
`;

// Now each fragment is on its own property
data.child1_user  // Always present
data.child2_user  // Optional - only present if included
```

## How It Works

### Without @alias

```tsx
// Can't tell if fragment was included
<Child2 user={data.fragmentRefs} />  // Always renders, might break
```

### With @alias

```tsx
// Can conditionally render based on fragment presence
{data.child2_user && <Child2 user={data.child2_user} />}
```

## Usage in RescriptRelay

```res
/* UserProfileHeader.res */
module UserFragment = %relay(`
  fragment UserProfileHeader_user on User {
    firstName
    lastName
    ...Avatar_user @alias  # Separate property
  }
`)

@react.component
let make = (~user) => {
  let user = UserFragment.use(user)

  <div>
    <Avatar user={user.avatar_user} />  # Access via aliased property
    {React.string(user.firstName ++ " " ++ user.lastName)}
  </div>
}
```

## Enabling @alias (RescriptRelay < 3.1.0)

```javascript
// relay.config.js
module.exports = {
  schema: "./schema.graphql",
  artifactDirectory: "./src/__generated__",
  src: "./src",
  featureFlags: {
    enable_relay_resolver_transform: true,
    enable_fragment_aliases: {
      kind: "enabled",
    },
  },
};
```

## Benefits

| Benefit | Description |
|---------|-------------|
| **Type safety** | Optional types reflect conditional inclusion |
| **Explicit control** | Know exactly which fragments are present |
| **Conditional rendering** | Render components only when fragment data exists |
| **Unions/interfaces** | Handle polymorphic types safely |

## Common Patterns

### Conditional Fragment

```tsx
const fragment = graphql`
  fragment UserDetail on User @argumentDefinitions(showPremium: {type: "Boolean!"}) {
    name
    ...PremiumBadge_user @include(if: $showPremium) @alias
  }
`;

function UserDetail({ user }) {
  const data = useFragment(fragment, user);

  return (
    <>
      <h1>{data.name}</h1>
      {data.premiumBadge_user && <PremiumBadge user={data.premiumBadge_user} />}
    </>
  );
}
```

---

## Related

[[Relay GraphQL Fragments]]
[[Fragment References]]
