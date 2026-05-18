---
description: New Classrooms frontend architecture guide — React 18, Relay, Redux Toolkit, Tailwind, feature flags
tags:
  - source
  - react
  - relay
  - marvin/frontend/redux
  - architecture
  - feature-flags
  - tailwind
sources:
  - CLAUDE-frontend.md
created: 2026-04-09
updated: 2026-04-09
---

# New Classrooms Frontend Architecture

**Source:** `raw/00_inbox/work docs/CLAUDE-frontend.md`
**Date ingested:** 2026-04-09
**Type:** Architecture guide

## Summary

Production React 18 SPA architecture using Relay for GraphQL, Redux Toolkit for global state, Tailwind + PrimeReact for UI, and Unleash for feature flags.

## Architecture

```
src/
├── components/           # Feature folders (Dashboard/, Assignments/, etc.)
│   ├── common/          # Shared UI components (RatingDisplay, SkillStatusBadge)
│   └── [Feature]/       # One folder per feature with co-located files
├── pages/               # Route-level components, thin wrappers
├── graphQLOperations/   # Relay queries/mutations by domain
├── redux/reducers/      # Slice files (userSlice.ts, filterSlice.ts)
├── custom-hooks/        # Reusable data hooks
├── experiments/         # Feature flag experiments (TEAME-*/)
├── models/              # TypeScript interfaces
├── utils/               # Helper functions
├── contexts/            # React context (rarely used)
└── learnosity-regions/  # Assessment UI regions
```

## Component Patterns

### Structure
- `FC<Props>` pattern with explicit interface
- Co-locate component, tests, styles in same folder
- Props interfaces named `Props` for internal use

### Styling
- **Current:** Tailwind CSS with `tw-` prefix
- **Current:** PrimeReact for complex UI (Card, Dialog, Toast)
- **Legacy:** PrimeFlex `p-` classes coexist — prefer Tailwind

## State Management

### Global State (Redux Toolkit)
- Slices in `redux/reducers/[name]Slice.ts`
- Use `useAppSelector`/`useAppDispatch` from @redux/hooks.ts
- Keep Redux for: user, filters, auth tokens, cross-component state

### Local State
- `useState` for component-local UI state
- `useSearchParams` for shareable URL state
- Prefer local state over Redux when possible

### Custom Hooks
- Place in `custom-hooks/` with `use` prefix
- Return `{ data, loading, error, refetch }` shape
- Use Relay's `useLazyLoadQuery` inside hooks

## GraphQL & Data Fetching

### Relay Patterns
- Queries in `graphQLOperations/[Domain].ts` as exported const
- Use `graphql` template tag from `relay-runtime`
- Generate types: `npm run relay` (creates `__generated__/`, commit these)
- **useLazyLoadQuery** for component data fetching
- **useMutation** with `onCompleted`/`onError` callbacks

### Pagination
- Cursor-based with `first`/`after` or `last`/`before`
- Use `@skip(if: $skip)` directive for conditional fetching
- Store pageInfo in component state, not Redux

## Experiments & Feature Flags

### Unleash Integration
- **FlagSwitch component** for conditional rendering
- **useFlag/useVariant** hooks from `@unleash/proxy-client-react`
- Experiments in `experiments/[TEAME-XXX]/` folders

```tsx
<FlagSwitch
  flagId="brain-break-modal"
  default={<StandardModal />}
  conditions={{ on: <BrainBreakModal /> }}
/>
```

### Analytics
- Use `ExperimentTracker` for recording assignments/observations

## Workflow

```bash
npm run dev         # Start dev server (tsc + vite)
npm run relay       # Regenerate Relay types after schema changes
npm run lint        # ESLint + Prettier check
npm run format      # Prettier write
npm test            # Vitest
```

### Before Committing
1. `npm run relay` after any GraphQL query changes
2. `npm run lint` must pass
3. TypeScript strict mode enabled

## Gold Standard References

- @components/common/RatingDisplay.tsx - Clean component with variants
- @graphQLOperations/Classes.ts - Query/mutation organization
- @custom-hooks/useGetClassesByRole.ts - Role-aware data fetching
- @components/FlagSwitch/FlagSwitch.tsx - Feature flag abstraction

## Known Inconsistencies

- **Forms:** Mix of Formik and plain state - prefer plain state for simple forms
- **Styling:** Tailwind + PrimeFlex coexist - use Tailwind for new code
- **Data fetching:** Some prop drilling; newer code uses hooks
- **Tests:** Vitest used but coverage varies

## Key Concepts

- [[relay]] — GraphQL client patterns
- [[redux-toolkit]] — Global state management
- [[feature-flags]] — Unleash integration
- [[tailwind-css]] — Utility-first styling
- [[co-location]] — Keep related files together
