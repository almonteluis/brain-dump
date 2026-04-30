---
description: "Airbnb React style guide and component best practices"
tags: ["source", "react", "airbnb", "style-guide", "best-practices"]
sources: ["airbnb-react-patterns-summary.md"]
created: 2026-04-08
updated: 2026-04-08
---

# Airbnb React Patterns

**Source:** raw/02_reference/approaches/airbnb-react-patterns-summary.md
**Date ingested:** 2026-04-08
**Type:** Style guide summary

## Summary

Key takeaways from Airbnb's React/JSX Style Guide — covering component structure, naming conventions, JSX syntax, props best practices, and anti-patterns.

## Key Claims

- One component per file (multiple stateless components OK)
- Always use JSX syntax (no `React.createElement` except in non-JSX files)
- No mixins — use HOCs, utility modules, or composition instead
- Stateful: `class extends React.Component`, Stateless: normal functions (not arrow)
- Files: PascalCase with `.jsx` extension

## Naming Conventions

| Item | Convention | Example |
|------|------------|---------|
| Files | PascalCase | `ReservationCard.jsx` |
| Component refs | PascalCase | `ReservationCard` |
| Instances | camelCase | `reservationItem` |
| Props | camelCase | `myProp` |
| HOC displayName | Show relationship | `withFoo(${wrappedComponentName})` |

## JSX Syntax Rules

- **Attributes**: Double quotes `"bar"`
- **JS expressions**: Single quotes `'20px'`
- **Self-closing**: One space before slash `<Foo />`
- **Curly braces**: No padding `{bar}`

## Props Best Practices

- Boolean props: omit value when `true` (`<Foo hidden />` not `hidden={true}`)
- Always define `defaultProps` for non-required props
- Use stable IDs for keys, never array indexes
- Spread props sparingly, filter out unnecessary ones

## Methods & Events

- Bind handlers in constructor, not render
- OK to use arrow functions for passing additional data to handlers
- Don't use `_` prefix for "private" methods

## Component Ordering (Class Components)

1. Optional static methods
2. `constructor`
3. Lifecycle methods
4. Event handlers starting with `handle`
5. Event handlers starting with `on`
6. Getter methods for render
7. Optional render methods
8. `render`

## Accessibility

- Always include `alt` prop on images
- Don't use redundant words like "picture of" in alt text
- Use only valid, non-abstract ARIA roles
- Don't use `accessKey`

## Anti-Patterns to Avoid

- ==❌ `isMounted()` — deprecated==
- ❌ Array indexes as keys
- ❌ Mixins
- ❌ `React.createClass`
- ❌ Arrow function class properties for handlers
- ❌ String refs
