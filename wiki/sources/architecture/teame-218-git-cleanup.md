---
description: Git cleanup strategy for squashing 19 commits into 5 logical commits with rebase plan
tags: ["git", "cleanup", "squash", "workflow", "branching"]
sources: ["raw/TEAME-218-GIT-CLEANUP-MASTER.md", "raw/TEAME-218-Rebase-Plan.md"]
created: 2026-04-11
updated: 2026-04-11
---

# TEAME-218 Git Cleanup Strategy
---

## Summary

Git cleanup plan for the TEAME-218 BrainBreak feature branch, consolidating 19 commits into 5 logical squashed commits for clean PR history.

## Current State

- **Total commits on branch:** 19
- **Status:** Branch has diverged from origin (19 local vs 17 remote)
- **Final commit:** `42ecbb37ceb9399d5ec06cd2d291140056010cf8`

## Proposed Cleanup Strategy

### Target: 5 Logical Commits

| # | Commit Message | Original Commits Covered |
|---|----------------|--------------------------|
| 1 | refactor(brainbreak): move components from experiments to production paths | 5f57d6817, 7bc3a2bd1, 9e4924022 |
| 2 | refactor(brainbreak): consolidate context with cooldown and recording service | cefbea2a3, a6e54c307 |
| 3 | refactor(brainbreak): eliminate anti-patterns and migrate to Redux | 3d5657c35, 31ede16a8, 6dd1527ea, 794782024 |
| 4 | refactor(brain-break-modal): redesign UI with Dialog component, spring animations | 582094df3, 40a8a2d96, b3dfe96c5, 28d8e2b01, 19c47be62 |
| 5 | refactor(brainbreak): slider UI, custom hooks, config paths, and navigation | 0724c3cab, 840a4611b, 34f9c0277, 9ba141ed7, a200857b2 |

**Dropped from final PR:**
- `42ecbb37c` (local bun config — not part of feature)

## Execution Commands

```bash
# Step 1: Create backup
git branch backup/TEAME-218-before-squash

# Step 2: Interactive rebase from main
git rebase -i $(git merge-base main HEAD)

# Step 3: Verify after squash
git diff backup/TEAME-218-before-squash HEAD

# Step 4: Force push (when ready)
git push origin feature/TEAME-218-LTS-Brain-Break --force-with-lease
```

## Detailed Rebase Plan

*Source: TEAME-218-Rebase-Plan.md*

### Prerequisites

1. Verify baseline builds: `npm run build`
2. Create backup: `git branch backup/TEAME-218-before-squash`
3. Confirm you're the only one working on this branch

### Rebase Todo File

```
pick 5f57d6817 Add rotating Math Mind Measures questions config
squash 7bc3a2bd1 Move BrainBreak from experiments to components folder
squash 9e4924022 Update flag name to LTS-shutoff

pick cefbea2a3 Add cooldown system for brain break eligibiity
squash a6e54c307 Refactor brainBreakContext

pick 3d5657c35 refactor(context): migrate state from React Context to Redux
squash 31ede16a8 refactor(brain break): eliminate useEffect anti-pattern
squash 6dd1527ea fixup SkillResources: time-based mechanisms
squash 794782024 refactor(brainbreak): code cleanup and efficiency improvements

pick 28d8e2b01 refactor(BrainBreak modal): replace reducer with useState, swap portal for Dialog
squash 582094df3 fixup(modal UI)
squash 40a8a2d96 countdown fixup with completed
squash b3dfe96c5 modal only
squash 19c47be62 removing console logs

pick 0724c3cab feat(BrainBreak): replace confidence buttons with slider
squash 840a4611b brain break config rename and path updates final version
squash 34f9c0277 fixed paths for brain break after rebasing timeline changes
squash 9ba141ed7 Refactor useBrainBreakNav
squash a200857b2 fixup custom hooks
```

### 5 Final Commit Messages

**Commit 1: Foundation**
```
refactor(brainbreak): move components from experiments to production paths

- Relocate BrainBreak components from experiments/TEAME-177 to components/BrainBreak
- Move BrainBreakContext to contexts/brainBreakContext.tsx
- Extract hooks to custom-hooks/
- Rename flag from TEAME-177-brain-break to LTS-shutoff-TEAME-218-Brain-Break
```

**Commit 2: Cooldown and Context**
```
refactor(brainbreak): consolidate context with cooldown and recording service

- Extract recording logic into useBrainBreakRecording hook with race-safe guards
- Add cooldown eligibility system with same-day prevention and 10-day cooldown
- Replace withBrainBreak HOC with useBrainBreakCallback hook
```

**Commit 3: Redux and Anti-patterns**
```
refactor(brainbreak): eliminate anti-patterns, migrate to Redux, improve code quality

- Remove isMountedRef workaround by extracting timer logic into callbacks
- Migrate state from context to Redux slice
- Use key-based remount pattern for BrainBreakProvider
- Replace manual date math with date-fns utilities
- Fix broken counter increment in useBrainBreakRecorder
- Clean up unnecessary comments and dead code
```

**Commit 4: Modal UI**
```
refactor(brain-break-modal): redesign UI with Dialog component and spring animations

- Replace createPortal with PrimeReact Dialog
- Replace useReducer with useState
- Inline header with spring-physics particle animations
- Swap countdown for completed screen with auto-exit timer
- Remove console.logs and debug code
```

**Commit 5: Slider and Navigation**
```
refactor(brainbreak): slider UI, custom hooks, config paths, and navigation

- Replace confidence buttons with PrimeReact Slider and custom SVG icons
- Rename useEngagementTimer to useBrainBreakPlacements
- Add useBrainBreakRecorder hook
- Refactor useBrainBreakNavigation with overloads
- Update paths after timeline rebase
```

### Post-Rebase Verification

```bash
# Verify no code differences from backup
git diff backup/TEAME-218-before-squash HEAD

# Build test
npm run build

# Type check
npx tsc --noEmit
```

## Architecture Reference

### BrainBreak Components
| File | Purpose |
|------|---------|
| BrainBreakModal.tsx | Main modal container with two-step survey |
| EmotionPicker.tsx | 4x4 emotion circumplex grid (16 emotions) |
| ConfidenceSlider.tsx | 5-point confidence slider with animated thumb |
| BrainBreakSurveySteps.tsx | Orchestration component for survey steps |
| EmotionIcons.tsx | All 16 emotion icon SVG components |
| BrainBreakCompleted.tsx | Completion screen with exit animation |

### Custom Hooks
| File | Purpose |
|------|---------|
| useBrainBreakRecorder.ts | Records survey responses via GraphQL |
| useBrainBreakNavigation.ts | Navigation handler for eligible links |
| useBrainBreakPlacements.ts | Qualifies placements via time-based engagement |

### Redux Slice Actions
- hydrateBrainBreakSession — Initialize after GraphQL load
- qualifyBrainBreakPlacement — Mark placement as qualified
- markBrainBreakViewed — Set hasSeenBrainBreak to true
- resetBrainBreakSession — Reset on user change
- showBrainBreakModal — Open modal
- closeBrainBreakModal — Close modal, mark viewed

## Verification Checklist

After squash, verify:
- [ ] Build passes: `npm run build`
- [ ] TypeScript check: `npx tsc --noEmit`
- [ ] Tests pass: `npm test`
- [ ] Linting passes: `npm run lint`
- [ ] Brain break modal opens correctly
- [ ] Survey flow works (both steps)
- [ ] Emotion picker functions
- [ ] Confidence slider works
- [ ] Auto-exit timer works
- [ ] Redux DevTools shows correct state

## Concepts Covered

- [[git-rebase]] — Interactive rebase for commit squashing
- [[git-workflow]] — Clean commit history practices
- [[force-with-lease]] — Safer force push pattern
- [[branching-strategy]] — Feature branch management

## Related

- [[teame-218-brainbreak-postmortem]] — Implementation post-mortem
- [[TEAME-218 Code Cleanup - TEAME-177 (In-Platform Polling)]] — Code quality improvements
