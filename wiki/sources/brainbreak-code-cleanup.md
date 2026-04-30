---
description: Code cleanup plan covering barrel file removal, state co-location, and reducer naming conventions
tags: ["cleanup", "barrel-files", "state-co-location", "reducers"]
sources: ["raw/05_archive/BrainBreak Code Cleanup Plan.md"]
created: 2026-04-11
updated: 2026-04-11
---

# BrainBreak Code Cleanup Plan

**Source:** raw/05_archive/BrainBreak Code Cleanup Plan.md
**Date ingested:** 2026-04-11
**Type:** Code quality improvement plan
**Focus:** Barrel file removal, reducer naming, state co-location

## Summary

Code cleanup plan addressing technical debt in the BrainBreak feature: duplicate reducer names, barrel file anti-pattern, misplaced data, and DRY violations. Based on Vercel React best practices and Kent C. Dodds' state co-location principles.

## Research Findings

### Barrel Files Are Anti-Patterns

According to Vercel's React Best Practices (`bundle-barrel-imports` rule): **"Import directly, avoid barrel files."**

Barrel files cause:
- **Tree-shaking issues** — bundlers can't eliminate unused code
- **Circular dependency risks**
- **Unnecessary indirection** — developers must open multiple files to trace imports
- **Coupling between unrelated modules**

### State Co-location (Kent C. Dodds)

**"Place code as close to where it's relevant as possible."**

Key principles:
- Start with local state (`useState`/`useReducer`)
- Lift state only when necessary (shared between siblings)
- Co-locating state improves both performance and maintainability
- Context providers should be placed "as close to where it's relevant as possible"

### Multiple Reducers Pattern

When multiple reducers exist in the same codebase:
- Use descriptive, domain-specific names (`loginReducer`, `modalStateReducer`)
- Never use the same generic name (`reducer`, `stateReducer`) for different concerns
- Consider naming convention: `[Domain]State` and `[Domain]Action`

## Goals

- Eliminate barrel file (direct imports only)
- Co-locate single-use code with its consumer
- Rename reducers for clarity
- Keep architectural boundaries (contexts in `contexts/`, shared types in `models/`)

## Files to Modify

### 1. Delete Barrel File
- **Delete:** `frontend/src/components/BrainBreak/index.ts`

### 2. Update Import Paths (14 files)

Change from barrel imports to direct imports:
```typescript
// From barrel
import { BrainBreakModal, ConfidenceSlider } from '../components/BrainBreak';

// Direct imports
import { BrainBreakModal } from '../components/BrainBreak/BrainBreakModalLazy';
import { ConfidenceSlider } from '../components/BrainBreak/ConfidenceSlider';
```

### 3. Rename Reducers (Critical Fix)

**In** `components/BrainBreak/BrainBreakModal.tsx`:
```typescript
// BEFORE - Generic/confusing names
function brainBreakReducer(state: BrainBreakState, action: BrainBreakAction): BrainBreakState { ... }

// AFTER - Domain-specific names
function brainBreakModalReducer(state: ModalUIState, action: ModalUIAction): ModalUIState { ... }
```

**In** `contexts/brainBreakContext.tsx`:
```typescript
// BEFORE
function brainBreakReducer(state: BrainBreakState, action: BrainBreakAction): BrainBreakState { ... }

// AFTER
function brainBreakContextReducer(state: BrainBreakContextState, action: BrainBreakContextAction): BrainBreakContextState { ... }
```

### 4. Co-locate Single-Use Code

**Move survey questions:**
- **From:** `models/BrainBreakQuestions.ts`
- **To:** `components/BrainBreak/surveyData.ts` (or inline in `BrainBreakModal.tsx`)
- **Delete:** `models/BrainBreakQuestions.ts`

### 5. Co-locate Cooldown Config

**Move to business logic:**
- **From:** `models/BrainBreakConfig.ts` — `COOLDOWN_CONFIG`
- **To:** `businessLogicService/brainBreakCooldown.ts`

## Additional Code Smells Found

### Dead Code in `models/BrainBreak.ts`
Duplicates `models/BrainBreakConfig.ts` — should be consolidated and deleted.

### Inconsistent Action Type Naming

Mixing snake_case and camelCase in action types:
```typescript
// Inconsistent
type: 'show_modal'
type: 'mark_as_viewed'
type: 'hydrate_from_db'

// Recommended: SCREAMING_SNAKE_CASE
type: 'APP/SHOW_MODAL'
type: 'APP/MARK_AS_VIEWED'
type: 'APP/HYDRATE_FROM_DB'
```

### Import Path Inconsistency

Some files import from `models/BrainBreak` (barrel), others from `models/BrainBreakConfig` (direct). Standardize to direct paths.

## Verification

1. Search for any remaining imports from `components/BrainBreak` (should be direct file imports)
2. Verify no duplicate `brainBreakReducer` names exist
3. Verify `models/BrainBreak.ts` is deleted (consolidated into BrainBreakConfig.ts)
4. Run TypeScript check: `tsc --noEmit`
5. Run tests if available
6. Manual smoke test — verify BrainBreak modal still opens/closes correctly

## Rollback Plan

If issues arise, revert:
1. Restore `index.ts` barrel file
2. Revert import path changes
3. Restore `models/BrainBreakQuestions.ts`
4. Keep reducer renames (they're just names, safe to keep)

## Concepts Covered

- [[barrel-files]] — Anti-pattern in module organization
- [[state-co-location]] — Kent C. Dodds principle
- [[reducer-naming]] — Domain-specific naming conventions
- [[tree-shaking]] — How bundlers eliminate unused code

## Related

- [[teame-218-brainbreak-postmortem]] — Implementation post-mortem
- [[teame-218-git-cleanup]] — Git cleanup strategy
