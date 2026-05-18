---
description: "Relay @alias directive for fragment renaming and type narrowing"
tags: [tools, relay, graphql, alias-directive, fragments, conditional-fragments]
sources: [relay-alias-directive.md]
created: 2026-04-09
updated: 2026-04-09
---

# Relay @alias Directive

**Source:** raw/02_reference/tools/relay-alias-directive.md
**Date ingested:** 2026-04-09
**Type:** guide

## Summary

The @alias directive in Relay puts each fragment on its own property instead of nesting in fragmentRefs. Solves conditional fragments and abstract type matching issues.

## Key Claims

- Without @alias, all fragment references are nested in `fragmentRefs` with no way to know if conditional fragments were included
- @alias puts each fragment on its own property, enabling conditional rendering based on fragment presence
- Essential for handling @include/@skip directives and union/interface fragment spreads

## The Problem

```tsx
// Without @alias - all refs in one place
const fragment = graphql`
  fragment Parent on User {
    ...Child1_user
    ...Child2_user @include(if: $showChild2)
  }
`;

data.fragmentRefs  // Contains both, can't tell if Child2 was included
```

## The Solution

```tsx
// With @alias - each fragment on its own property
const fragment = graphql`
  fragment Parent on User {
    ...Child1_user @alias
    ...Child2_user @include(if: $showChild2) @alias
  }
`;

data.child1_user  // Always present
data.child2_user  // Optional - only present if included
```

## Usage in RescriptRelay

```res
module UserFragment = %relay(`
  fragment UserProfileHeader_user on User {
    firstName
    lastName
    ...Avatar_user @alias
  }
`)

@react.component
let make = (~user) => {
  let user = UserFragment.use(user)
  <Avatar user={user.avatar_user} />
}
```

## Enabling @alias

```javascript
// relay.config.js
module.exports = {
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

## Concepts Covered

- [[relay]] — Meta's React GraphQL framework
- [[Fragment Aliases]] — @alias directive
- [[Conditional Fragments]] — @include/@skip
- [[data-masking]] — Fragment encapsulation
- [[Type Safety]] — Generated TypeScript types

## Related

- [[relay-graphql-fragments]]
- [[fragment-references-relay]]
- [[relay-fragment-composition]]
