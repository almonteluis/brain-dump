---
description: "DashboardStudent Relay refactoring plan and implementation"
tags: [relay, refactoring, dashboard, fragments, redux, performance]
sources: ["Relay refactor.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Relay Refactor Plan

**Source:** raw/01_thinking/notes/Relay refactor.md
**Date ingested:** 2026-04-09
**Type:** thinking note

## Summary

Comprehensive refactoring plan for migrating DashboardStudent component to use Relay fragments properly. Addresses component isolation, data colocation, and elimination of prop drilling through a phased approach from leaf components to root query.

## Key Claims

- Current DashboardStudent has no fragments — all data fetched at page level
- Query reference prop drilling passes `queryReferenceExitSlip`, `queryReferenceRefresher` through 3+ levels
- Mixing Redux + Relay creates dual state sources and confusion
- Using `useLazyLoadQuery` in children causes multiple round trips with no composition
- Props explosion includes `setStudentSkillStates`, `setSSSWithoutExtension`, `customCardMessage`

## Component Hierarchy

```
DashboardStudent (page)
├── Diagnostic (modal)
├── DashboardHeader
│   └── SearchBox
├── DashboardList
    └── DashboardContainerBody
        ├── StudentDashboardAssignments
        ├── UnitCard
        └── DashboardCards
            ├── DashboardCard (via DataView)
            ├── DashboardRefresherCard
            └── DashboardExitSlipQuery
```

## Refactoring Phases

### Phase 1: Create Fragments for Leaf Components
- DashboardCard fragment on StudentSkillState
- DashboardRefresherCard fragment with argument definitions
- DashboardExitSlipQuery fragment on Query

### Phase 2: Create Fragments for Middle Components
- DashboardCards fragment composing child fragments
- DashboardContainerBody fragment with argument passing

### Phase 3: Create Root Fragment
- DashboardStudent root query with all composed fragments
- Single network request instead of multiple round trips

### Phase 4: Eliminate Redux for Server Data
| Current Redux State | Move To |
|--------------------|---------|
| targetGroupSlice | Relay fragment + useFragment |
| studentSkillsSlice | Relay fragment + useFragment |
| unitSlice | Relay fragment + useFragment |
| filterSlice | Keep (UI-only state) |
| studentTourSlice | Keep (UI-only state) |

## Testing & Baseline Measurements

### Metrics to Track
| Metric | Before | After | Target |
|--------|--------|-------|--------|
| Network requests on load | Count | Count | -50% or more |
| Total payload size (KB) | Size | Size | -20% or more |
| Time to Interactive (ms) | Measure | Measure | No regression |
| Component re-renders | Count | Count | -30% or more |
| Props passed per component | Count | Count | -60% or more |

### Tools
- Chrome DevTools Performance — Runtime metrics
- Chrome DevTools Network — Request count, payload size
- webpack-bundle-analyzer — Bundle composition
- React DevTools Profiler — Render counts and times
- tsc --noEmit — TypeScript coverage
- ESLint with relay plugin — Query validation

## Benefits

1. Single Network Request — All data fetched in one composed query
2. Data Isolation — Components only see data they declare
3. No Prop Drilling — Fragment refs replace props
4. Type Safety — Generated types enforce correct usage
5. Local Development — Change child data needs without touching parents
6. Clear Ownership — Each component owns its data requirements

## Entities Mentioned

- DashboardStudent — Root page component
- DashboardCard — Leaf component needing fragment
- DashboardRefresherCard — Component with complex data needs
- DashboardExitSlipQuery — Query component to convert to fragment
- DashboardContainerBody — Middle component in hierarchy

## Concepts Covered

- [[fragment-composition]] — Building fragments from child fragments
- [[Data Colocation]] — Moving data requirements to components
- [[Prop Drilling Elimination]] — Using fragment refs instead of props
- [[Redux vs Relay]] — Guidelines for state management choice
- [[Performance Baseline]] — Measuring before/after metrics

## Related

- [[redux-vs-relay]]
- [[relay-fragment-composition]]
- [[data-masking-in-relay]]
- [[relay-fragment-research-presentation]]
