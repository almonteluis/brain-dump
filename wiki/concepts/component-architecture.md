---
description: Component architecture — patterns for structuring React components, from atoms to feature modules
tags: ["react", "components", "architecture", "patterns", "concept"]
created: 2026-04-23
---

# Component Architecture

Component architecture defines how React components are structured, composed, and organized. Good architecture balances reusability, testability, and developer experience.

## Component Types

| Type | Responsibility | Example |
|------|---------------|---------|
| **Presentation** | UI only, no logic | `<Button>`, `<Card>`, `<Badge>` |
| **Container** | Data fetching, state | `<UserDashboardContainer>` |
| **Layout** | Positioning, spacing | `<Stack>`, `<Grid>`, `<Sidebar>` |
| **Behavior** | Logic, no UI | `<FormValidator>`, `<ErrorHandler>` |
| **Composite** | Orchestrates children | `<DataTable>`, `<FormWizard>` |

See [[designing-component-apis]] for choosing the right type.

## Organization Patterns

### By Type (Feature-agnostic)
```
components/
  buttons/
  inputs/
  cards/
```
Good for: Shared component libraries, design systems.

### By Feature (Domain-driven)
```
features/
  auth/
    components/
    hooks/
    utils/
  dashboard/
    components/
    hooks/
```
Good for: Large apps with distinct domains. See [[nc-frontend-architecture]].

### Colocation (Near consumer)
```
pages/
  Dashboard/
    Dashboard.tsx
    DashboardHeader.tsx
    useDashboardData.ts
```
Good for: Feature-specific components used in one place. See [[data-colocation]].

## Composition Patterns

- **Props** — Simple data passing
- **Render props** — `<List renderItem={(item) => ...} />`  — see [[render-props-pattern]]
- **Compound components** — `<Select><Option /></Select>` — see [[compound-components]]
- **Slots** — Named insertion points for flexible layouts
- **Higher-order components** — Legacy pattern, replaced by hooks — see [[higher-order-components]]

## State Architecture

Where state lives matters:
- **Local state** — `useState` for UI-only state
- **Lifted state** — Nearest common parent for shared state
- **Context** — Avoid prop drilling — see [[state-context-reducer-pattern]]
- **External store** — Redux, Relay, Zustand for app-wide state — see [[redux-vs-relay]]

## Related

- [[atomic-design]] — Hierarchical component methodology
- [[designing-component-apis]] — Choosing the right component API
- [[container-presentational-pattern]] — Separating data from UI
- [[compound-components]] — Flexible composition pattern
- [[state-context-reducer-pattern]] — Performant state with Context + useReducer
- [[nc-frontend-architecture]] — Production React architecture case study
