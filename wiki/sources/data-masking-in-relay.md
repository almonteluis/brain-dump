---
description: "Data masking patterns in Relay for component encapsulation"
tags: ["source", "relay", "data-masking", "fragments", "encapsulation"]
sources: ["data-masking-in-relay.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Data Masking in Relay

**Source:** raw/02_reference/approaches/data-masking-in-relay.md
**Date ingested:** 2026-04-09
**Type:** Technical guide

## Summary

Data masking is Relay's enforcement that components only access data they explicitly declare. Fragment references hide data until `useFragment` extracts it, enabling local reasoning and safe refactoring.

## Key Claims

- Without `useFragment`, fragment data is invisible even if fetched
- Data masking prevents implicit dependencies between components
- Enables safe refactoring — remove fields with confidence
- Supports local reasoning — understand data needs by looking at component only

## What Data Masking Enables

| Benefit | Description |
|---------|-------------|
| Safe Refactoring | Remove fields knowing exactly what breaks |
| Local Reasoning | No need to trace through parent queries |
| Self-Containment | Components are portable and isolated |

## How It Works

```tsx
// Fragment ref looks empty
console.log(fragmentRef);  // { }

// useFragment extracts the data
const data = useFragment(MyFragment, fragmentRef);
console.log(data.name);  // "Alice"
```

## Anti-Pattern: Prop Drilling Raw Data

```tsx
// BAD: Prop drilling raw data
const ProfileCard = ({ userName, avatar }) => (
  <Header userName={userName} avatar={avatar} />
);
// Removing 'icon' requires changes to ALL 3 components
```

## Pattern: Fragment Refs

```tsx
// GOOD: Passing fragment refs
const ProfileCard = ({ userRef }) => (
  <Header userRef={userRef} />
);
// Removing 'icon' only requires changing NameFragment
```

## Entities Mentioned

- [[relay]] — GraphQL client framework

## Concepts Covered

- [[data-masking]] — Hiding fragment data from non-declaring components
- [[fragment-references]] — Opaque pointers to graph data
- [[local-reasoning]] — Understanding components in isolation
