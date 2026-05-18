---
description: "Scaffolded Challenges System - Implementation Plan"
tags: ['research']
raw_file: "adaptive-scribbling-charm.md"
created: 2026-05-17
---

# Scaffolded Challenges System - Implementation Plan

## Overview

Create a "Scaffolded Challenges" system that follows research-backed progression: **Tutorial → Guided Practice → Fading Support → Independent Mastery**.

## Scaffolding Stages

| Stage | Description | Hints | Guides | Templates |
|-------|-------------|-------|--------|-----------|
| **Tutorial** | Initial onboarding (already exists) | Unlimited | Yes | Yes |
| **Guided** | Full support with hints | 5 | Yes | Yes |
| **Fading** | Reduced support | 2 | Partial | No |
| **Independent** | No support, mastery | 0 | No | No |

---

## Phase 1: Foundation (Core State Management)

### 1.1 Create Scaffolding Types
**File:** `src/types/progression.ts`

Add types for:
- `ScaffoldingStage`: 'tutorial' | 'guided' | 'fading' | 'independent'
- `ChallengeCategory`: 'room-design' | 'budget-constraint' | 'multi-room' | 'efficiency'
- `ScaffoldedChallenge`: Challenge definition interface
- `ChallengeObjective`: Individual goal (room-area, budget-limit, room-count, efficiency)
- `ScaffoldingProgress`: User progress through stages

### 1.2 Create Scaffolding Store
**File:** `src/stores/scaffoldingStore.ts`

State structure:
```typescript
interface ScaffoldingStore {
  // Progress
  currentStage: ScaffoldingStage;
  challengesCompleted: { tutorial, guided, fading, independent };
  stageUnlocked: { guided, fading, independent };
  overallProficiency: number;

  // Challenges
  availableChallenges: ScaffoldedChallenge[];
  activeChallenge: ScaffoldedChallenge | null;

  // Actions
  startChallenge(id: string): void;
  updateObjective(objectiveId: string, value: number): void;
  useHint(): void;
  completeChallenge(id: string): void;
  skipChallenge(): void;
  advanceStage(): void;
}
```

Use Zustand pattern with localStorage persistence (like xpStore).

### 1.3 Define Challenge Templates
**File:** `src/constants/scaffoldedChallenges.ts`

Initial challenges (2 per stage):
- **Guided**: "Cozy Bedroom" (100 sq ft), "Budget Beginner" ($300 cap)
- **Fading**: "Two-Room Layout" (bedroom + kitchen), "Space Saver" (80% efficiency)
- **Independent**: "Tiny Home Master" (3 rooms, $1000), "Efficiency Expert" (90% efficiency)

### 1.4 Create Challenge Verification Hook
**File:** `src/hooks/useScaffoldedChallenge.ts`

Real-time objective verification:
- `room-area`: Sum of all room areas
- `budget-limit`: Check total cost vs target
- `room-count`: Count created rooms
- `efficiency`: (floor area / total area) * 100

---

## Phase 2: Core UI Components

### 2.1 Objective Tracker (In-Game Overlay)
**File:** `src/components/ui/ObjectiveTracker.tsx`

Minimal overlay during gameplay showing:
- Current objectives with live values
- Checkmarks for completed objectives
- Hint count remaining
- Progress bar

Design: Floating card similar to BudgetCard, positioned top-right.

### 2.2 Challenge Modal
**File:** `src/components/ui/ScaffoldedChallengeModal.tsx`

Main challenge interface:
- Challenge title and description
- Objective checklist
- Stage indicator with visual progression
- "Need Help?" button (integrates with hintStore)
- Accept/Dismiss buttons

Design pattern: Follow DailyChallengeModal (glassmorphism, backdrop-blur, rounded-[2rem]).

### 2.3 Scaffolding Progress Indicator
**File:** `src/components/ui/ScaffoldingProgress.tsx`

Visual progress through stages:
- Current stage badge with icon
- Progress bar to next stage
- Challenges completed count
- Locked/unlocked future stages

Design: Similar to XPBar but for scaffolding stages.

---

## Phase 3: Challenge Discovery & Completion

### 3.1 Challenge List
**File:** `src/components/ui/ChallengeList.tsx`

Browse available challenges:
- Cards for each challenge in current stage
- Lock status for unavailable challenges
- Stage badges (Guided, Fading, Independent)
- Start/Resume/Continue buttons

### 3.2 Stage Complete Modal
**File:** `src/components/ui/StageCompleteModal.tsx`

Celebration when completing all challenges in a stage:
- "You've mastered [Stage Name]!"
- Performance summary
- Preview of next stage
- Confetti celebration

---

## Phase 4: Integration

### 4.1 XP Integration
**Modify:** `src/stores/xpStore.ts`

Use existing `addXP()` to award challenge completion XP (30-120 XP based on difficulty).

### 4.2 Achievement Badges
**Modify:** `src/stores/achievementStore.ts`, `src/constants/progression.ts`

Add new badges:
- `bdg_guided_master` - Complete all guided challenges
- `bdg_fading_master` - Complete all fading challenges
- `bdg_independent_master` - Complete all independent challenges
- `bdg_no_hints_needed` - Complete 3 challenges without hints

### 4.3 Hint System
**Modify:** `src/stores/hintStore.ts`

Track hints used per challenge (affects proficiency score).

### 4.4 App Integration
**Modify:** `src/App.tsx`

Add modals to app:
- `<ScaffoldedChallengeModal />`
- `<ChallengeList />` (accessible from UI)
- `<StageCompleteModal />`
- `<ObjectiveTracker />` (during active challenge)

---

## File Summary

### New Files (8):
1. `src/types/progression.ts` - Type definitions
2. `src/stores/scaffoldingStore.ts` - Core state
3. `src/constants/scaffoldedChallenges.ts` - Challenge templates
4. `src/hooks/useScaffoldedChallenge.ts` - Verification logic
5. `src/components/ui/ObjectiveTracker.tsx` - In-game overlay
6. `src/components/ui/ScaffoldedChallengeModal.tsx` - Main modal
7. `src/components/ui/ScaffoldingProgress.tsx` - Progress indicator
8. `src/components/ui/ChallengeList.tsx` - Challenge browser

### Modify Files (5):
1. `src/stores/xpStore.ts` - XP integration
2. `src/stores/achievementStore.ts` - New badges
3. `src/stores/hintStore.ts` - Hint tracking
4. `src/constants/progression.ts` - Badge definitions
5. `src/App.tsx` - Modal integration

---

## Proficiency Calculation

Advance to next stage when proficiency >= 70:

```typescript
proficiency = (
  (completionRate * 40) +      // Challenges completed / started
  ((1 - hintUsageRatio) * 30) + // Fewer hints = better
  (timeEfficiency * 15) +       // Compared to average
  (budgetEfficiency * 15)       // Remaining budget percentage
);
```

---

## Verification

Test the complete flow:
1. New user sees Tutorial → Guided transition
2. User starts "Cozy Bedroom" challenge
3. ObjectiveTracker shows live progress
4. Completing objectives triggers celebration
5. XP awarded, progress updated
6. After sufficient proficiency, Fading stage unlocks
7. Support gradually reduces (fewer hints, no templates)
8. Eventually reach Independent mastery

---

## Design Patterns to Follow

- **Modal**: DailyChallengeModal (glassmorphism, framer-motion)
- **Store**: xpStore (Zustand + localStorage)
- **Progress**: XPBar (visual progress indicator)
- **Verification**: useChallengeVerification (existing pattern)

