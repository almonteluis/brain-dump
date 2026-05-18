---
description: "Relay ESLint rules guide"
tags: [clawdbot, relay, graphql, eslint, fragments, linting, best-practices]
sources: [clawdbot/relay-eslint-rules-guide.md]
created: 2026-04-09
updated: 2026-04-09
---

# Relay ESLint Rules: Fragment Usage Guide

**Source:** raw/02_reference/tools/clawdbot/relay-eslint-rules-guide.md
**Date ingested:** 2026-04-09
**Type:** guide

## Summary

Guide to Relay's ESLint plugin rules that enforce proper fragment usage. Covers `unused-fields` and `must-colocate-fragment-spreads` rules with real-world examples.

## Key Claims

- Two key rules work together: `unused-fields` and `must-colocate-fragment-spreads`
- If `unused-fields` error pops up, it means you should use fragments instead
- These rules prevent wasted network bandwidth and enable data masking
- Both rules together = optimal Relay data fetching

## Overview

Relay's ESLint plugin provides rules to enforce best practices:

1. **`relay/unused-fields`** — Error when queried fields aren't used
2. **`relay/must-colocate-fragment-spreads`** — Error when fragments aren't co-located

> **Key insight:** If `unused-fields` error pops up, it means you should use fragments instead of whatever you've been doing.

## Rule 1: relay/unused-fields

### What It Does

Ensures that every GraphQL field referenced is used within the module that includes it.

### When It Triggers

```typescript
// ❌ TRIGGERS ERROR: "profileImage" is queried but never used
const data = useLazyLoadQuery(
  graphql`
    query UserQuery($id: ID!) {
      user(id: $id) {
        name
        profileImage  // Queried but never used!
        email
      }
    }
  `,
  {id: '1'}
);

function UserComponent() {
  // Only using name and email, not profileImage
  return (
    <div>
      <h1>{data.user?.name}</h1>
      <p>{data.user?.email}</p>
    </div>
  );
}
```

### The Fix: Use Fragments

```typescript
// ✅ CORRECT: Child uses only name and email
const UserFragment = graphql`
  fragment UserFragment on User {
    name
    email
  }
`;

const ParentQuery = graphql`
  query ParentQuery($id: ID!) {
    user(id: $id) {
      ...UserFragment
    }
  }
`;

function UserComponent() {
  const data = useFragment(UserFragment, props.user);
  return (
    <div>
      <h1>{data.name}</h1>
      <p>{data.email}</p>
    </div>
  );
}
```

## Rule 2: relay/must-colocate-fragment-spreads

### What It Does

Ensures that when a fragment spread is added within a module, that module directly imports the module which defines that fragment.

### When It Triggers

```typescript
// ❌ TRIGGERS ERROR: UserFragment is spread but not imported
// Parent.tsx (spreads UserFragment)
import { useLazyLoadQuery } from 'react-relay';

const ParentQuery = graphql`
  query ParentQuery {
    user {
      ...UserFragment  // Spread added here
    }
  }
`;

function ParentComponent() {
  const data = useLazyLoadQuery(ParentQuery, {});
  // UserFragment is NOT imported here!
  return <UserComponent user={data.user} />;
}
```

### The Fix: Colocate + Use Fragment

```typescript
// ✅ CORRECT: Parent imports and uses UserFragment
import { useLazyLoadQuery } from 'react-relay';
import { UserFragment } from './User';

const ParentQuery = graphql`
  query ParentQuery {
    user {
      ...UserFragment
    }
  }
`;

function ParentComponent() {
  const data = useLazyLoadQuery(ParentQuery, {});
  return <UserComponent user={data.user} />;
}
```

## How the Rules Work Together

```
┌─────────────────────────────────────────────┐
│  relay/must-colocate-fragment-spreads     │
│  Ensures fragments are defined where used  │
└────────────────┬────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────┐
│        relay/unused-fields                │
│  Ensures only used fields are fetched     │
└─────────────────────────────────────────────┘
                 │
                 ▼
        ┌──────────────────────┐
        │   Benefits:           │
        │   • No waste       │
        │   • Type safety    │
        │   • Decoupling    │
        │   • Maintainability  │
        └──────────────────────┘
```

## Rule Configuration

### Install ESLint Plugin

```bash
npm install --save-dev eslint-plugin-relay
```

### Configure ESLint

```javascript
// .eslintrc.js
module.exports = {
  plugins: ['relay'],
  rules: {
    'relay/unused-fields': 'warn',
    'relay/must-colocate-fragment-spreads': 'error',
  },
};
```

## Quick Reference

| Rule | Severity | What It Catches | How to Fix |
|-------|-----------|-------------------|-------------|
| `relay/unused-fields` | Warn | Queried fields not used | Remove unused field or use fragments |
| `relay/must-colocate-fragment-spreads` | Error | Fragments not co-located | Import fragment, use `useFragment` |

## Key Takeaways

1. **`unused-fields` = Use fragments**
2. **`must-colocate-fragment-spreads` = Colocation**
3. **Both rules together = Optimal Relay**

## Concepts Covered

- [[Relay ESLint]] — Linting for GraphQL
- [[Fragment Colocation]] — Import where spread
- [[Unused Fields]] — Waste prevention
- [[data-masking]] — Component encapsulation

## Related

- [[relay-overview]]
- [[relay-fragment-composition]]
- [[relay-alias-directive]]
