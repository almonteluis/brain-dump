# Relay ESLint Rules: Fragment Usage Guide

Two key rules that enforce proper fragment usage in Relay.

---

## Overview

Relay's ESLint plugin provides rules to enforce best practices. Two rules work together:

1. **`relay/unused-fields`** — Error when queried fields aren't used
2. **`relay/must-colocate-fragment-spreads`** — Error when fragments aren't co-located

> **Key insight:** If `unused-fields` error pops up, it means you should use fragments instead of whatever you've been doing.

---

## Rule 1: relay/unused-fields

### What It Does

Ensures that every GraphQL field referenced is used within the module that includes it. This helps enable Relay's optimal data fetching by preventing unused fields from being sent to the server.

### When It Triggers

```typescript
// ❌ TRIGGERS ERROR: "profileImage" is queried but never used
const data = useLazyLoadQuery(
  graphql`
    query UserQuery($id: ID!) {
      user(id: $id) {
        name
        profileImage  // Queried but never used in component!
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

### The Problem

**Unused fields waste:**
- Network bandwidth — Data sent over the wire that's never used
- Server processing — Backend does unnecessary work
- Bundle size — Extra data in Relay store
- Cache inefficiency — More data to store and manage

### The Fix: Use Fragments

Instead of querying fields that might not all be used, co-locate data requirements with fragments. This way:

1. Each component declares what **it** needs
2. Parent combines all fragment spreads
3. Unused fields are automatically excluded

```typescript
// ✅ CORRECT: Child uses only name and email
// UserFragment.tsx
const UserFragment = graphql`
  fragment UserFragment on User {
    name
    email
  }
`;

// Parent.tsx
const ParentQuery = graphql`
  query ParentQuery($id: ID!) {
    user(id: $id) {
      ...UserFragment  // Only fetches name and email
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

---

## Rule 2: relay/must-colocate-fragment-spreads

### What It Does

Ensures that when a fragment spread is added within a module, that module directly imports the module which defines that fragment.

This prevents the anti-pattern when one component fetches a fragment that is not used by a direct child component.

### When It Triggers

```typescript
// ❌ TRIGGERS ERROR: UserFragment is spread but not imported here
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

// User.tsx (defines UserFragment)
import { graphql } from 'react-relay';

const UserFragment = graphql`
  fragment UserFragment on User {
    name
    email
  }
`;

export default function UserComponent({ user }) {
  // Directly using user data, not fragment
  return <div>{user.name} - {user.email}</div>;
}
```

### The Problem

**Why this is bad:**
1. **No data masking** — `ParentComponent` can access `user.name` directly
2. **Tight coupling** — Parent and child are coupled to query shape
3. **Fragile to change** — Can't add/remove fields without touching multiple files
4. **No type safety** — TypeScript doesn't know what child needs

### The Fix: Colocate + Use Fragment

```typescript
// ✅ CORRECT: Parent imports and uses UserFragment
// Parent.tsx
import { useLazyLoadQuery } from 'react-relay';
import { UserFragment } from './User';  // <-- IMPORT IT HERE

const ParentQuery = graphql`
  query ParentQuery {
    user {
      ...UserFragment  // Fragment defined in User.tsx
    }
  }
`;

function ParentComponent() {
  const data = useLazyLoadQuery(ParentQuery, {});

  // Pass fragment reference (not user data)
  return <UserComponent user={data.user} />;
}

// User.tsx
import { graphql, useFragment } from 'react-relay';
import type { UserFragment$key } from './__generated__/UserFragment.graphql';

// Define fragment
const UserFragment = graphql`
  fragment UserFragment on User {
    name
    email
  }
`;

// Export type for fragment key
export type { UserFragment$key };

export default function UserComponent({ user }: { user: UserFragment$key }) {
  // Use fragment to unmask data
  const userData = useFragment(UserFragment, user);
  return <div>{userData.name} - {userData.email}</div>;
}
```

---

## How the Rules Work Together

These two rules are designed to work together:

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

### The Flow

1. **`must-colocate-fragment-spreads`** ensures you use fragments properly
   - Forces fragments to be defined where they're used
   - Prevents accessing raw data without `useFragment`
   - Enables data masking

2. **`unused-fields`** catches waste
   - Automatically excludes fields not used in any fragment
   - Optimal data fetching — only fetch what's needed
   - No manual cleanup required

---

## Real-World Example: SingleSkill Refactor

### Before: Both Rules Triggered

```typescript
// ❌ relay/must-colocate-fragment-spreads ERROR
// SingleSkill.tsx (spreads TeacherSingleSkillFragment)
import { useLazyLoadQuery } from 'react-relay';
// Missing: import TeacherSingleSkillFragment

const SingleSkillQuery = graphql`
  query SingleSkillQuery($skillId: ID!) {
    skill(id: $skillId) {
      title
        description
        presignedUrls {
          url
        }
        ...TeacherSingleSkillFragment  // Not imported!
    }
  }
`;

// ❌ relay/unused-fields ERROR
// Query fetches presignedUrls but SingleSkill doesn't use it
function SingleSkill({ skillId }) {
  const data = useLazyLoadQuery(SingleSkillQuery, { skillId });
  return (
    <div>
      <h1>{data.skill?.title}</h1>
      <p>{data.skill?.description}</p>
      {data.skill?.presignedUrls && (
        <TeacherSingleSkill
          skillId={skillId}  // Triggers second query
        />
      )}
    </div>
  );
}

// TeacherSingleSkill.tsx (defines fragment)
import { graphql } from 'react-relay';

const TeacherSingleSkillFragment = graphql`
  fragment TeacherSingleSkillFragment on Skill {
    presignedUrls {
      url
    }
  }
`;
```

**Problems:**
- Fragment not imported → Triggers `must-colocate-fragment-spreads`
- `presignedUrls` queried but never used in `SingleSkill` → Triggers `unused-fields`
- `TeacherSingleSkill` receives `skillId` → Triggers separate query
- Result: 2+ network requests, wasted data

### After: Both Rules Pass

```typescript
// ✅ CORRECT: Both rules satisfied
// SingleSkill.tsx
import { useLazyLoadQuery } from 'react-relay';
import { TeacherSingleSkillFragment } from './TeacherSingleSkill';  // <-- Import fragment

const SingleSkillQuery = graphql`
  query SingleSkillQuery($skillId: ID!) {
    skill(id: $skillId) {
      title
        description
        ...TeacherSingleSkillFragment  // <-- Fragment is imported
    }
  }
`;

function SingleSkill({ skillId }: { skillId: string }) {
  const data = useLazyLoadQuery(SingleSkillQuery, { skillId });

  // Pass fragment reference ($ref), not skillId
  return <TeacherSingleSkill skill={data.skill} />;  // <-- Single query
}

// TeacherSingleSkill.tsx
import { graphql, useFragment } from 'react-relay';
import type { TeacherSingleSkillFragment$key } from './__generated__/TeacherSingleSkillFragment.graphql';

// Fragment definition
const TeacherSingleSkillFragment = graphql`
  fragment TeacherSingleSkillFragment on Skill {
    presignedUrls {
      url
    }
  }
`;

export default function TeacherSingleSkill({ skill }: { skill: TeacherSingleSkillFragment$key }) {
  // Unmask data with useFragment
  const data = useFragment(TeacherSingleSkillFragment, skill);
  return <PresignedURL urls={data.presignedUrls} />;
}
```

**Benefits:**
- Fragment imported → Passes `must-colocate-fragment-spreads`
- `presignedUrls` only used in `TeacherSingleSkill` → Passes `unused-fields`
- Single query for all data → Optimal data fetching
- No `skillId` prop → No second query
- Type-safe with generated `TeacherSingleSkillFragment$key`

---

## Common Mistakes

### 1. Ignoring the Rules

```typescript
// ❌ BAD: Disabling rules instead of fixing
// eslint-disable-next-line relay/unused-fields
const data = useLazyLoadQuery(
  graphql`
    query BadQuery {
      user {
        name
        unusedField  // Ignored warning!
      }
    }
  `,
  {}
);
```

**Why this is bad:**
- You're suppressing valid warnings about waste
- Over time, unused fields accumulate
- Performance degrades as codebase grows

### 2. Importing Fragment But Not Using

```typescript
// ❌ BAD: Imports fragment but still accesses raw data
import { UserFragment } from './User';  // Imported!

const ParentQuery = graphql`
  query ParentQuery {
    user {
      ...UserFragment
    }
  }
`;

function ParentComponent() {
  const data = useLazyLoadQuery(ParentQuery, {});
  // BAD: Passing raw data, still triggers unused-fields in child
  return <UserComponent user={data.user} />;
}
```

**The problem:** Import satisfies `must-colocate-fragment-spreads`, but child component doesn't use `useFragment`, so data masking doesn't happen.

### 3. Spreading Fragment in Multiple Places

```typescript
// ✅ GOOD: Fragment can be spread multiple times
const UserFragment = graphql`
  fragment UserFragment on User {
    name
    email
  }
`;

const ListQuery = graphql`
  query ListQuery {
    users {
      ...UserFragment  // Spread here
    }
  }
`;

const DetailQuery = graphql`
  query DetailQuery($id: ID!) {
    user(id: $id) {
      ...UserFragment  // And here
    }
  }
`;

// Both work fine! Fragment fetches name + email for both cases
```

---

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
    // Both rules enabled
    'relay/unused-fields': 'warn',
    'relay/must-colocate-fragment-spreads': 'error',
  },
};
```

### Suppressing Rules (When Necessary)

```typescript
// Only suppress when absolutely necessary
graphql`
  query MyQuery {
    user {
      ...SomeFragment  # eslint-disable-next-line relay/must-colocate-fragment-spreads
    }
  }
`;
```

**Note:** Only use `eslint-disable-next-line` as last resort. Document why it's needed in a comment.

---

## Quick Reference

| Rule | Severity | What It Catches | How to Fix |
|-------|-----------|-------------------|-------------|
| `relay/unused-fields` | Warn | Remove unused field or use fragments to co-locate requirements |
| `relay/must-colocate-fragment-spreads` | Error | Import fragment in file where it's spread, use `useFragment` in child |

---

## Summary

### Key Takeaways

1. **`unused-fields` = Use fragments**
   - When this error appears, extract unused fields into fragments
   - Let components declare their own data needs
   - Prevents wasted network bandwidth

2. **`must-colocate-fragment-spreads` = Colocation**
   - Import fragment where you spread it
   - Use `useFragment` in child components
   - Enables data masking and type safety

3. **Both rules together = Optimal Relay**
   - Fragments prevent unused fields
   - Colocation ensures proper usage
   - Result: Single optimized query, type-safe components

### The Anti-Pattern They Prevent

```
┌──────────────────────────────────────┐
│         Anti-Pattern              │
│  Query + pass raw data          │
│  (tightly coupled, waste)       │
└────────────┬─────────────────────┘
             │
             ▼
┌──────────────────────────────────────┐
│      Recommended Pattern            │
│  Query + fragment + useFragment    │
│  (decoupled, optimal)          │
└──────────────────────────────────────┘
```

---

## References

- [Relay ESLint Plugin](https://github.com/relayjs/eslint-plugin-relay)
- [Relay Lint Rules Documentation](https://relay.dev/docs/next/getting-started/lint-rules/)
- [Fragment Colocation Guide](https://www.emgoto.com/relay-graphql-fragments/)
- [Optimal Data Fetching](https://relay.dev/blog/2023/10/24/how-relay-enables-optimal-data-fetching/)
