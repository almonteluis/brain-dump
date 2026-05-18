---
description: Component API design patterns — props, slots, render props, compound components across React, Vue, Svelte, and web components
tags:
  - source
  - react
  - component-design
  - api/design
  - frontend
  - pattern
sources:
  - Designing Component APIs.md
created: 2026-04-17
updated: 2026-04-17
---

# Designing Component APIs

**Source:** `raw/Designing Component APIs.md`
**Date ingested:** 2026-04-17
**Type:** Technical guide (frontendpatterns.dev)
**Author:** Den Odell

## Summary

Framework-agnostic guide to designing component APIs. Covers props, slots, render props, compound components, and event callbacks with examples in React, Vue, Svelte, and web components.

## Key Claims

1. **Assess component purpose first** — Presentation, Container, Layout, and Behavior components need different API patterns
2. **Props are the foundation** — Use for simple values. Keep under 7-8 props per component
3. **Slots invert content control** — Parent decides what to render; child decides where. Better than prop-based content passing
4. **Render props delegate rendering** — Give consumers data and let them decide how to render it
5. **Compound components share implicit state** — Tabs, Accordion, Menu patterns where parent manages state and children consume it

## Component Purpose Categories

| Type | Focus | Example |
|------|-------|---------|
| Presentation | Appearance config | Button |
| Container | Data flow + behavior | DataTable, Form |
| Layout | Spatial arrangement | Card with header/body/footer |
| Behavior | Add functionality without rendering | Tooltip trigger, focus trap |

## API Technique Selection

| Technique | Best When |
|-----------|-----------|
| Props | Simple values, finite config options |
| Slots | Fixed structure, variable content |
| Render Props | Consumer needs data + rendering control |
| Compound Components | Related components sharing state |
| Event Callbacks | Parent reacts to child actions |

## Concepts Covered

- [[container-presentational-pattern]] — Data/UI separation
- [[render-props-pattern]] — JSX through function props
- [[atomic-design]] — Component hierarchy methodology
- [[react-patterns]] — React best practices

## Related

- [[container-presentational-pattern]] — Container vs presentation pattern
- [[render-props-pattern]] — Render props pattern
- [[atomic-design]] — Atomic design methodology
- [[react-patterns]] — React patterns reference
