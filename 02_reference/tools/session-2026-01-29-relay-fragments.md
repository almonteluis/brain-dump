---
description: Session summary from Relay GraphQL fragments documentation processing — created 6 notes on fragment patterns, data masking, fragment references, composition, @alias directive, and fragment arguments.
tags: ["session-summary", "relay", "graphql", "fragments", "documentation-processed", "to-process"]
created: 2026-01-29
---

# Session: Relay GraphQL Fragments

## Processed Documentation

**Sources:**
1. Relay Tutorial - Fragments (official)
2. Relay Guided Tour - Rendering Fragments (official)
3. RescriptRelay - Using Fragments
4. Emma Goto - Relay GraphQL Fragments (practical guide)

**Date:** 2026-01-29

## Notes Created

| Note | Location | Key Insight |
|------|----------|-------------|
| [[Relay GraphQL Fragments]] | `00_inbox/Links/` | Main overview of fragment pattern and benefits |
| [[Data Masking in Relay]] | `02_reference/approaches/` | How Relay enforces component data isolation |
| [[Fragment References]] | `02_reference/approaches/` | Fragment refs as opaque pointers to graph data |
| [[Relay Fragment Composition]] | `02_reference/approaches/` | Parent-child fragment composition pattern |
| [[@alias Directive]] | `02_reference/tools/` | Solving conditional fragments and union types |

## Core Framework: The Fragment Pattern

```
┌─────────────────────────────────────────────────────────────┐
│                    THE FRAGMENT PATTERN                      │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  1. DEFINE   → fragment MyFragment on Type { fields }       │
│  2. SPREAD   → ...MyFragment in parent query/fragment       │
│  3. PASS     → <Child data={fragmentRef} />                │
│  4. READ     → const data = useFragment(fragment, ref)     │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

## Key Concepts Extracted

### 1. Fragment References (Fragment Keys)
- Opaque objects that Relay uses to read data
- Contain hidden metadata: node ID + available fragments
- Created at the point where fragment is spread
- Passed between components as props
- Exchanged for actual data via `useFragment`

### 2. Data Masking
- Relay hides data unless component explicitly requests it
- Enables safe refactoring (remove fields with confidence)
- Prevents implicit dependencies between components
- Enforces local reasoning about data needs

### 3. Fragment Composition
- Fragments can include other fragments
- Parent spreads child's fragment in its own fragment
- Parent passes fragment ref (not raw data) to child
- Modify child's data needs without touching parent
- All fragments compose into single query at runtime

### 4. @alias Directive
- Puts each fragment on its own property (not in `fragmentRefs`)
- Solves conditional fragments (`@include`/`@skip`)
- Solves union/interface fragment spreads
- Properties are optional if fragment is conditional

### 5. Fragment Arguments
- Fragments accept arguments via `@argumentDefinitions`
- Arguments passed at spread time via `@arguments`
- Enables context-specific data fetching
- Useful for things like image sizes, locale, etc.

## Benefits Summary

| Benefit | Impact |
|---------|--------|
| **Component self-containment** | Each component declares own data needs |
| **No unused fields** | ESLint enforces all queried fields are used |
| **Type safety** | Generated types for fragment refs and data |
| **Reusability** | Same fragment works in different graph contexts |
| **Local modifications** | Change data needs without touching parents |
| **Single query efficiency** | All fragments compose into one network request |

## ESLint Rules

Two key Relay ESLint rules enforce proper fragment usage:
- `unused-fields` — Error when queried fields aren't used
- `must-colocate-fragment-spreads` — Error when fragments aren't co-located with components

## Common Patterns

### Reusable Component Pattern
```tsx
// Image works in multiple contexts
const ImageFragment = graphql`
  fragment ImageFragment on Image {
    url(width: $width, height: $height)
  }
`;

// Used in Story (large image)
...ImageFragment @arguments(width: 400)

// Used in Profile (small avatar)
...ImageFragment @arguments(width: 60, height: 60)
```

### Conditional Rendering with @alias
```tsx
const fragment = graphql`
  fragment UserDetail on User {
    ...PremiumBadge_user @include(if: $showPremium) @alias
  }
`;

// Only render if fragment exists
{data.premiumBadge_user && <PremiumBadge user={data.premiumBadge_user} />}
```

---

## Related

[[Relay GraphQL Fragments]]
[[Data Masking in Relay]]
[[Fragment References]]
[[Relay Fragment Composition]]
