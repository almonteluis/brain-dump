---
description: Refactoring plan for DashboardStudent to use Relay fragments properly — component isolation, data colocation, eliminating prop drilling
tags: #leadership #relay #fragment-composition #refactoring #work-in-progress
date: 2026-01-31
---

# Relay Fragment Refactor Plan

## Current State Analysis

### Component Hierarchy
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

### Problems Identified

| Problem                            | Impact                                                                             | Fragment Solution                         |
| ---------------------------------- | ---------------------------------------------------------------------------------- | ----------------------------------------- |
| **No fragments used**              | All data fetched at page level                                                     | Colocate data with components             |
| **Query reference prop drilling**  | `queryReferenceExitSlip`, `queryReferenceRefresher`, etc. passed through 3+ levels | Each component owns its fragment          |
| **Redux + Relay mixing**           | Dual state sources, confusion                                                      | Relay for server data, local state for UI |
| **`useLazyLoadQuery` in children** | Multiple round trips, no composition                                               | Single composed query at root             |
| **Props explosion**                | `setStudentSkillStates`, `setSSSWithoutExtension`, `customCardMessage`, etc.       | Data flows via fragment refs              |
| **Child doesn't own its data**     | Parent decides what child needs                                                    | Child declares fragment, spreads at root  |

## Refactoring Strategy

### Phase 1: Create Fragments for Leaf Components

Start with components that have no Relay queries but receive data via props.

#### 1.1 DashboardCard Fragment

```graphql
# DashboardCard_card.graphql
fragment DashboardCard_card on StudentSkillState {
  id
  skill {
    code
    name
    targetSkills {
      target {
        targetGroup {
          id
        }
      }
    }
  }
  readinessScore
  completionStatus
  # ... other fields DashboardCard actually uses
}
```

```tsx
// DashboardCard.tsx
import { graphql, useFragment } from 'react-relay';

const fragment = graphql`
  fragment DashboardCard_card on StudentSkillState {
    id
    skill { code name }
    readinessScore
    completionStatus
  }
`;

interface Props {
  card: DashboardCard_card$key; // Fragment ref type
}

export default function DashboardCard({ card }: Props) {
  const data = useFragment(fragment, card);
  // Render using data — no props needed from parent
}
```

#### 1.2 DashboardRefresherCard Fragment

```graphql
# DashboardRefresherCard_data.graphql
fragment DashboardRefresherCard_data on Query
@argumentDefinitions(
  skillId: { type: "String!" }
  studentId: { type: "String!" }
  targetGroupId: { type: "String!" }
)
{
  studentSkillStateBySkillId(skillIds: [$skillId], studentId: $studentId) {
    id
    readinessScore
    # ... fields for refresher card
  }
  skillsAndTargetsByTargetGroup(targetGroupId: $targetGroupId) {
    # ... target skills data
  }
}
```

#### 1.3 DashboardExitSlipQuery Fragment

```graphql
# DashboardExitSlipQuery_data.graphql
fragment DashboardExitSlipQuery_data on Query
@argumentDefinitions(
  userId: { type: "String!" }
  filter: { type: "ExitSlipFilterInput" }
  learnosityFilter: { type: "LearnosityExitSlipSessionFilterInput" }
)
{
  exitSlips(userIds: [$userId], filter: $filter) {
    id
    dueOn
  }
  learnosityExitSlipSessions(filter: $learnosityFilter) {
    id
    sessionCompletedOn
  }
}
```

### Phase 2: Create Fragments for Middle Components

#### 2.1 DashboardCards Fragment

```graphql
# DashboardCards_data.graphql
fragment DashboardCards_data on Query
@argumentDefinitions(
  studentId: { type: "String!" }
  targetGroupId: { type: "String!" }
  customBranding: { type: "String" }
)
{
  # Include child fragments with their arguments
  ...DashboardExitSlipQuery_data
    @arguments(
      userId: $studentId
      filter: $filter
      learnosityFilter: $learnosityFilter
    )

  studentSkillStates(
    studentId: $studentId
    targetGroupId: $targetGroupId
  ) {
    # Include the card fragment
    ...DashboardCard_card @relay(plural: true)
  }
}
```

```tsx
// DashboardCards.tsx
const fragment = graphql`
  fragment DashboardCards_data on Query
  @argumentDefinitions(
    studentId: { type: "String!" }
    targetGroupId: { type: "String!" }
    filter: { type: "ExitSlipFilterInput" }
    learnosityFilter: { type: "LearnosityExitSlipSessionFilterInput" }
  )
  {
    exitSlips(userIds: [$studentId], filter: $filter) {
      ...DashboardExitSlipQuery_exitSlip
    }
    studentSkillStates(studentId: $studentId, targetGroupId: $targetGroupId) {
      ...DashboardCard_card @relay(plural: true)
    }
  }
`;

interface Props {
  data: DashboardCards_data$key;
}

export default function DashboardCards({ data }: Props) {
  const queryData = useFragment(fragment, data);

  return (
    <>
      {queryData.studentSkillStates.map(skillState => (
        <DashboardCard key={skillState.id} card={skillState} />
      ))}
      <DashboardExitSlipQuery exitSlip={queryData.exitSlips} />
    </>
  );
}
```

#### 2.2 DashboardContainerBody Fragment

```graphql
# DashboardContainerBody_data.graphql
fragment DashboardContainerBody_data on Query
@argumentDefinitions(
  studentId: { type: "String!" }
  targetGroupId: { type: "String!" }
  unitId: { type: "String" }
)
{
  ...DashboardCards_data
    @arguments(
      studentId: $studentId
      targetGroupId: $targetGroupId
    )

  assignments: studentSkillStates(
    studentId: $studentId
    targetGroupId: $targetGroupId
    unitId: $unitId
    first: 3
  ) {
    id
    dueDate
  }
}
```

### Phase 3: Create Root Fragment

#### 3.1 DashboardStudent Root Query

```graphql
# DashboardStudentQuery.graphql
query DashboardStudentQuery(
  $studentId: String!
  $targetGroupId: String
  $unitId: String
  $customBranding: String
  $exitSlipFilter: ExitSlipFilterInput
  $learnosityFilter: LearnosityExitSlipSessionFilterInput
) {
  # Diagnostic data
  latestCompletedStudentSkillDiagnostic(studentId: $studentId) {
    id
    isInferred
    retakeAssigned
  }

  # Target group
  currentTargetGroupByStudentId(studentId: $studentId, targetGroupId: $targetGroupId) {
    targetGroup {
      id
      name
      targets {
        id
        name
        ...UnitCard_unit
      }
    }
  }

  # All child data composed in one query
  ...DashboardContainerBody_data
    @arguments(
      studentId: $studentId
      targetGroupId: $targetGroupId
      unitId: $unitId
    )
}
```

```tsx
// DashboardStudent.tsx
import { graphql, usePreloadedQuery } from 'react-relay';

const query = graphql`
  query DashboardStudentQuery(
    $studentId: String!
    $targetGroupId: String
    $unitId: String
    $exitSlipFilter: ExitSlipFilterInput
    $learnosityFilter: LearnosityExitSlipSessionFilterInput
  ) {
    latestCompletedStudentSkillDiagnostic(studentId: $studentId) {
      id
      isInferred
      retakeAssigned
    }
    currentTargetGroupByStudentId(studentId: $studentId, targetGroupId: $targetGroupId) {
      targetGroup {
        id
        name
        targets {
          id
          name
          ...UnitCard_unit
        }
      }
    }
    ...DashboardContainerBody_data
      @arguments(
        studentId: $studentId
        targetGroupId: $targetGroupId
        unitId: $unitId
      )
  }
`;

interface Props {
  queryRef: PreloadedQuery<DashboardStudentQuery>;
}

export default function DashboardStudent({ queryRef }: Props) {
  const data = usePreloadedQuery(query, queryRef);

  return (
    <>
      {data.latestCompletedStudentSkillDiagnostic?.retakeAssigned && (
        <Diagnostic diagnostic={data.latestCompletedStudentSkillDiagnostic} />
      )}
      <DashboardHeader targets={data.currentTargetGroupByStudentId?.targetGroup?.targets} />
      <DashboardContainerBody data={data} />
    </>
  );
}
```

### Phase 4: Eliminate Redux for Server Data

| Current Redux State  | Move To                      |
| -------------------- | ---------------------------- |
| `targetGroupSlice`   | Relay fragment + useFragment |
| `studentSkillsSlice` | Relay fragment + useFragment |
| `unitSlice`          | Relay fragment + useFragment |
| `filterSlice`        | Keep (UI-only state)         |
| `studentTourSlice`   | Keep (UI-only state)         |

> See [[redux-vs-relay]] for the complete guide on when to use each.

## Benefits of This Refactor

1. **Single Network Request** — All data fetched in one composed query
2. **Data Isolation** — Components only see data they declare
3. **No Prop Drilling** — Fragment refs replace props
4. **Type Safety** — Generated types enforce correct usage
5. **Local Development** — Change child data needs without touching parents
6. **Clear Ownership** — Each component owns its data requirements

## Testing & Baseline Measurements

### Tools to Use

| Category | Tool | Purpose |
|----------|------|---------|
| **Performance** | Chrome DevTools Performance | Runtime performance, rendering metrics |
| **Network** | Chrome DevTools Network | Request count, payload size, timing |
| **Bundle Size** | webpack-bundle-analyzer | Bundle composition and size |
| **Rendering** | React DevTools Profiler | Component render counts, times |
| **Type Checking** | tsc --noEmit | TypeScript coverage, type errors |
| **Linting** | ESLint with relay plugin | Query validation, fragment rules |
| **Testing** | Jest + React Testing Library | Component behavior tests |
| **Monitoring** | Relay Network Logger | GraphQL query inspection |

### What to Measure

| Metric | Before | After | Target |
|--------|--------|-------|--------|
| **Network requests on load** | Count | Count | -50% or more |
| **Total payload size (KB)** | Size | Size | -20% or more (deduplication) |
| **Time to Interactive (ms)** | Measure | Measure | No regression |
| **Component re-renders** | Count | Count | -30% or more |
| **Bundle size (KB)** | Size | Size | ~same or smaller |
| **Props passed per component** | Count | Count | -60% or more |
| **Type coverage** | % | % | 100% |

### Step-by-Step Baseline Creation

#### Step 1: Set Up Measurement Tools

```bash
# Install dependencies
npm install --save-dev webpack-bundle-analyzer
npm install --save-dev @relaytools/shared

# Enable Relay network logger (add to entry point)
import { RelayNetworkLogger } from 'relay-runtime';
const network = new RelayNetworkLogger({
  log: true,
  includeQuery: true,
  includeVariables: true,
});
```

#### Step 2: Create Performance Test Script

```typescript
// __tests__/performance/dashboard-student.performance.test.ts
import { render, screen } from '@testing-library/react';
import DashboardStudent from '../DashboardStudent';

describe('DashboardStudent Performance', () => {
  it('baseline: should render within time budget', async () => {
    const startTime = performance.now();

    render(<DashboardStudent />);

    // Wait for all data to load
    await screen.findByTestId('dashboard-cards');

    const endTime = performance.now();
    const renderTime = endTime - startTime;

    // Baseline: document current performance
    console.log(`[BASELINE] Render time: ${renderTime}ms`);

    // Set threshold (current time + 10% buffer)
    expect(renderTime).toBeLessThan(5000); // 5 second max
  });

  it('baseline: should not make excessive network requests', () => {
    const mockFetch = jest.fn();
    global.fetch = mockFetch;

    render(<DashboardStudent />);

    // Count actual GraphQL requests
    const graphqlRequests = mockFetch.mock.calls.filter(
      call => call[0].includes('/graphql')
    );

    console.log(`[BASELINE] GraphQL requests: ${graphqlRequests.length}`);
    expect(graphqlRequests.length).toMatchSnapshot();
  });
});
```

#### Step 3: Measure Network Requests

1. Open Chrome DevTools → Network tab
2. Filter by "graphql" or your API endpoint
3. Hard refresh (Cmd+Shift+R)
4. Record:
   - Number of requests
   - Total payload size (response body)
   - Total time (wait + receive)
   - Waterfall timing

```bash
# Save network baseline
# In DevTools: Right-click → Save all as HAR
# Name: baseline-before-refactor.har
```

#### Step 4: Measure Component Renders

```tsx
// Add React Profiler wrapper temporarily
import { Profiler } from 'react';

function onRenderCallback(
  id: string,
  phase: 'mount' | 'update',
  actualDuration: number,
  baseDuration: number,
  startTime: number,
  commitTime: number,
) {
  console.log(`[PROFILER] ${id} ${phase}: ${actualDuration}ms`);
}

// Wrap DashboardStudent
<Profiler id="DashboardStudent" onRender={onRenderCallback}>
  <DashboardStudent />
</Profiler>
```

Record baseline render times for each component:
- DashboardStudent
- DashboardHeader
- DashboardList
- DashboardContainerBody
- DashboardCards

#### Step 5: Measure Bundle Size

```bash
# Add to package.json scripts
{
  "scripts": {
    "build:analyze": "npm run build -- --profile && npx webpack-bundle-analyzer dist/static/js/*.js"
  }
}

# Generate baseline
npm run build:analyze

# Save baseline screenshot
# Name: bundle-size-before.png
```

#### Step 6: Count Props (Complexity Metric)

```bash
# Run this script to count props being passed
grep -r "props\." src/components/Dashboard/ | wc -l
# Or manually count interface Props definitions
```

| Component | Props Count | Estimation |
|-----------|-------------|------------|
| DashboardStudent | 2 | `isInferred`, `setIsInferred` |
| DashboardHeader | 4 | `setStudentSkillStates`, `setSSSWithoutExtension`, `allTargetsGroup`, `currentTargets` |
| DashboardList | 4 | `studentSkillStates`, `firstRender`, `setFirstRender`, `queryReferenceExitSlip` |
| DashboardContainerBody | 2 | `customCardMessage`, `queryReferenceExitSlip` |
| DashboardCards | 6 | `customCardMessage`, `queryReferenceExitSlip`, `queryReferenceRefresher`, `queryReferenceRefresherTargetSkills`, `setSkillIdForRefresherCard`, `skillIdForRefresherCard` |
| **Total** | **22** | Fragment refs will replace most of these |

### Testing During Refactor

#### Before Each Phase

```bash
# 1. Run existing tests
npm test

# 2. Run performance test
npm test -- dashboard-student.performance.test.ts

# 3. Check TypeScript
npx tsc --noEmit

# 4. Build and analyze
npm run build:analyze
```

#### After Each Phase

```bash
# 1. Run same tests
npm test
npm test -- dashboard-student.performance.test.ts
npx tsc --noEmit

# 2. Compare results
# - Performance should not degrade
# - Bundle size should stay same or decrease
# - Network requests should decrease
# - Type errors should decrease
```

### Expected Improvements

| Phase | What Should Improve |
|-------|---------------------|
| **Phase 1** (Leaf fragments) | Component props count, type coverage |
| **Phase 2** (Middle fragments) | Network request count, payload size |
| **Phase 3** (Root query) | Network request count (-70%), render consistency |
| **Phase 4** (Remove Redux) | Bundle size, render re-renders (-30%) |

### Regression Testing Checklist

Before deploying each phase:

- [ ] All existing tests pass
- [ ] No new TypeScript errors
- [ ] Performance test within acceptable range
- [ ] Manual smoke test of DashboardStudent page
- [ ] Check for console errors or warnings
- [ ] Verify Relay queries in Network tab (should be fewer)
- [ ] Compare bundle size to baseline

### Creating Your Baseline Report

```markdown
## Baseline Report: DashboardStudent

**Date:** [DATE]
**Branch:** main

### Network Performance
- GraphQL requests: [COUNT]
- Total payload: [SIZE] KB
- Total time: [TIME] ms

### Component Performance
- Time to Interactive: [TIME] ms
- Total re-renders: [COUNT]
- Slowest component: [NAME] ([TIME] ms)

### Bundle Size
- Main bundle: [SIZE] KB
- Total JS: [SIZE] KB

### Code Quality
- TypeScript coverage: [%]
- Props count: [COUNT]
- ESLint errors: [COUNT]
```

Save this report — you'll compare against it after the refactor.

## Implementation Order

1. ✅ Analyze current structure
2. [ ] **Create performance baseline** — See Testing section above
3. [ ] Create fragments for leaf components (DashboardCard, DashboardRefresherCard)
4. [ ] Create fragments for middle components (DashboardCards, DashboardContainerBody)
5. [ ] Create root query with composed fragments
6. [ ] Migrate one component at a time, testing at each step
7. [ ] Compare to baseline — document improvements
8. [ ] Remove Redux slices for server data
9. [ ] Clean up unused query loaders

## Issues & Fixes

<!-- Track issues encountered during refactoring -->

## Related

- [[redux-vs-relay]] — Guidelines for when to use Redux vs Relay for state management
- [[Relay Fragment Composition]] — How fragments compose across components
- [[Data Masking in Relay]] — Why components only see what they declare

## Next Actions

- [ ] Get approval from team for refactoring approach
- [ ] Create feature branch
- [ ] Start with DashboardCard fragment (leaf component, low risk)
- [ ] Write tests for fragment-based components
