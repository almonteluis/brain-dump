---
description: Comparison of Redux and Relay for state management
tags:
  - source
  - relay
  - marvin/frontend/redux
  - state-management
  - architecture
sources:
  - redux-vs-relay.md
created: 2026-04-09
updated: 2026-04-09
---

# Redux vs Relay: When to Use Which

**Source:** raw/02_reference/approaches/redux-vs-relay.md
**Date ingested:** 2026-04-09
**Type:** Architecture guide

## Summary

Guidelines for choosing between Redux and Relay: **Relay for server data, Redux for UI state**. Mixing these concerns creates maintenance problems.

## The Golden Rule

> **Relay for server data, Redux for UI state.**

## Use Relay For

| Concern | Example |
|---------|---------|
| Server-fetched data | User profiles, assignments |
| Normalized data | Entities with IDs appearing multiple places |
| Data relationships | Nested objects, connections |
| Cache management | Automatic updates, garbage collection |
| Mutations | CRUD with optimistic updates |

## Use Redux For

| Concern | Example |
|---------|---------|
| UI-only state | Modal open/closed, active tab |
| Transient client state | Form inputs, selection state |
| Global UI config | Theme preferences, tour mode |
| Cross-component UI flags | "Show all" vs "Show skills" |

## Anti-Patterns

### ❌ Storing Server Data in Redux
```tsx
// DON'T: Duplicate caching (Relay + Redux)
useEffect(() => {
  fetchStudentSkills().then(data => dispatch(setStudentSkills(data)));
}, []);
```

### ❌ Storing UI State in Relay
```graphql
# DON'T: Overcomplicating Relay
query UIStateQuery {
  modalOpen @client(always: true)
}
```

## Decision Flowchart

```
Is this data from an API?
├── Yes → Use Relay
└── No
    Is it used across many components?
    ├── Yes → Use Redux
    └── No → Use React useState
```

## Industry Usage (2025)

| Company | Server Data | UI State |
|---------|-------------|----------|
| Meta | Relay + GraphQL | React state |
| Netflix | Apollo + GraphQL | Redux/RxJS |
| Airbnb | Apollo + GraphQL | Redux |
| Google | gRPC (internal) | NgRx/RxJS |

## Relay vs Apollo

| Factor | Relay | Apollo |
|--------|-------|--------|
| Created by | Meta | Apollo Graph |
| Compilation | Build-time | Runtime |
| Type safety | Stronger | Good |
| Learning curve | Steeper | Easier |
| Best for | Very large apps | Most apps |

## Entities Mentioned

- [[relay]] — Meta's GraphQL client
- [[Redux]] — State management library
- [[Apollo]] — GraphQL client alternative
- [[Meta]] — Facebook, Instagram, WhatsApp
- [[Netflix]] — Streaming service
- [[Airbnb]] — Rental marketplace

## Concepts Covered

- [[state-separation]] — Server vs UI state concerns
- [[data-fetching]] — Relay for API data
- [[ui-state]] — Redux for interface state
