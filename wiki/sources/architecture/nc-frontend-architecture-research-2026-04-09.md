---
description: Comprehensive analysis of New Classrooms frontend architecture — React 18, Redux, Relay/GraphQL, Tailwind, PrimeReact
tags:
  - source
  - react
  - marvin/frontend/redux
  - relay
  - graphql
  - tailwind
  - primereact
  - architecture
  - research
sources:
  - 2026-04-09-frontend-ui-state-graphql-redux-tailwind.md
created: 2026-04-09
updated: 2026-04-09
---

# NC Frontend Architecture Research (2026-04-09)

**Source:** `raw/00_inbox/2026-04-09-frontend-ui-state-graphql-redux-tailwind.md`
**Date ingested:** 2026-04-09
**Type:** Architecture research

## Summary

Comprehensive analysis of the New Classrooms Marvin frontend — a React 18 + TypeScript + Vite application using PrimeReact for UI, Redux Toolkit for state, Relay for GraphQL, and hybrid SCSS + Tailwind CSS styling.

## Key Technologies

| Category | Technology | Version |
|----------|------------|---------|
| Framework | React | 18.2.0 |
| Language | TypeScript | 5.4.5 |
| Build Tool | Vite | 7.3.1 |
| UI Library | PrimeReact | 10.6.5 |
| State Management | Redux Toolkit | 2.2.1 |
| GraphQL | Relay Runtime | 16.0.0 |
| Styling | Tailwind CSS | 3.4.1 |
| Auth | Auth0 React SDK | 2.2.1 |
| Feature Flags | Unleash Proxy Client | 5.0.1 |

## Scale Statistics

| Metric | Count |
|--------|-------|
| Component Files | 319+ |
| Component Directories | 59 |
| Page Components | 28 |
| Redux Slices | 22 |
| Custom Hooks | 17 |
| GraphQL Operations | 24 |
| Generated Types | 149 files (~31,535 lines) |
| SCSS Files | 104 |

## UI Components (PrimeReact)

**Most Used Components:**

| Component | Usage Count |
|-----------|-------------|
| Button | 200+ files |
| Dialog | 30+ files |
| DataTable | 25+ files |
| Card | 20+ files |
| InputSwitch | 15+ files |
| Toast | 15+ files |
| Toolbar | 10+ files |

**Component Organization:**
```
src/components/
├── Dashboard/              # 15 files
├── TeacherDashboard/       # 28 files
├── Assignments/            # 17 files
├── ClassesRoster/          # 22 files
├── Progress/               # 18 files
├── ReportHub/              # 16 files
├── common/                 # Shared components
└── [feature dirs]/         # Feature-specific
```

## Redux State Management

**22 Slices Organized By Category:**

| Category | Slices |
|----------|--------|
| User/Auth | user, accessToken |
| Student Data | studentSkills, studentSkillsForAllRoadmaps, studentSkillAfterTakeAssessment, studentTour |
| Filters | filter, reportsFilter, reportHubFilter, exitSlipFilter, diagnosticReportFilters, teacherDashboardFilter, filterCount |
| UI State | targetGroup, unit, suggestedView, mutationInProgress, csvProcess, reportHubQuerysInProgress, exitSlipFinished |
| Modals | exitSlipModal |
| Assignments | assignmentSkill |
| Reports | individualStudentReport |

**Pattern Example:**
```typescript
export const userSlice = createSlice({
  name: 'user',
  initialState: { value: null },
  reducers: {
    setUser: (state, action: PayloadAction<User>) => {
      state.value = action.payload;
    },
    resetUser: (state) => {
      state.value = null;
    },
  },
});
```

**Key Observations:**
- No async thunks — async operations via Relay/Auth0
- No persistence configured (redux-persist in deps but unused)
- Modern pattern — uses Redux Toolkit exclusively (no connect API)
- Consistent ~24-45 line patterns across all slices

## Custom Hooks (16 hooks)

| Hook | Purpose |
|------|---------|
| useComponentTracking | Analytics tracking |
| useCurrentSkillResult | Skill result selection |
| useGetClassesByRole | Role-based class fetching |
| useStudentSkillStates | Skill state management |
| useWindowSize | Window dimensions |
| useExperimentSpeculativeData | Experiment data handling |
| useEngagementTimer | Brain break timer (TEAME-177) |

## GraphQL/Relay Patterns

**Relay Configuration:**
- Custom fetch function with Auth0 token refresh
- Sentry error reporting integration
- 401/403 triggers automatic logout

**Operations:** 24 files in `graphQLOperations/`

**Relay Hooks Usage:**
| Hook | Files | Instances |
|------|-------|-----------|
| useLazyLoadQuery | 137 | 348 |
| useMutation | 20+ | - |
| useQueryLoader | - | Manual loading |
| usePreloadedQuery | - | Preloaded refs |

**Generated Types:** 149 TypeScript files (~31,535 lines) in `__generated__/`

## Styling Architecture

**Tailwind Configuration:**
- Prefix: `tw-` (e.g., `tw-flex`, `tw-bg-white`)
- Preflight disabled
- Custom fonts: Sora, Atkinson Hyperlegible
- Custom colors: neutral, blue, yellow, green, stone

**Hybrid Approach:**
- Tailwind: Utility classes for layout and spacing
- SCSS: 104 files for component-specific styles
- PrimeReact: BEM-like naming (`.p-button`, `.p-dialog`)

**Class Naming Conventions:**
1. Tailwind: `tw-{property}-{value}`
2. PrimeReact: `p-{component}`
3. Custom: `nc_{component}`

## Provider Hierarchy (11 levels)

```
Auth0Provider
  → Provider (Redux)
    → RelayEnvironmentProvider
      → CustomErrorBoundary
        → Suspense
          → Auth0ToRedux
            → PersistingQuerysWrapper
              → FlagProvider (Unleash)
                → BrainBreakProvider
                  → TimeOnPlatformTracker
                    → RouterProvider
```

## Key Design Patterns

1. **Component Composition** — Wrapper components (LayoutWrapper, Protected)
2. **Container/Presentational** — Some separation with page containers
3. **Custom Hooks for Logic** — Business logic in hooks
4. **GraphQL Fragment Colocation** — Relay fragments with components
5. **Redux for Global State** — UI state, filters, auth
6. **Feature-Based Organization** — Components grouped by domain

## Data Flow

```
User Action → Component → Custom Hook → Relay Hook → GraphQL API
                          ↓
                    Redux Action (UI state)
                          ↓
                    Redux Store → Re-render
```

## Open Questions Identified

1. Redux persistence planned but not configured?
2. Tailwind migration ongoing (TEAME-183)?
3. Relay compiler integration into build pipeline?
4. Hook duplicates in `custom-hooks/` vs `hooks/`?
5. Test coverage strategy (only 3 test files)?

## Code References

- Redux Store: `frontend/src/redux/store.ts`
- Relay Environment: `frontend/src/relay.ts`
- Tailwind Config: `frontend/tailwind.config.js`
- Main Entry: `frontend/src/main.tsx`
- Router: `frontend/src/router.tsx`

## Related

- [[nc-frontend-architecture]] — Architecture guide
- [[brainbreak-mvc-refactor]] — State management patterns
- [[relay]] — Relay/GraphQL patterns
- [[redux-toolkit]] — Redux state management
