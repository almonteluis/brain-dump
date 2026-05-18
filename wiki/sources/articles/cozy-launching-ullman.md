---
description: "Brain Break Integration Guide for Timeline Redesign"
tags: ['research', 'ai']
raw_file: "cozy-launching-ullman.md"
created: 2026-05-17
---

# Brain Break Integration Guide for Timeline Redesign

## Quick Reference for Your Meeting

### Location of Brain Break Code
- **Main folder**: `src/experiments/TEAME-177/`
- **Key files**:
  - `BrainBreakModal/BrainBreakContext.tsx` - Context provider and main hooks
  - `hooks/index.ts` - Convenience hooks for easy integration
  - `EmotionPicker.tsx`, `ConfidenceSlider.tsx` - Survey components

---

## How Brain Break Works (Two-Phase System)

### Phase 1: Qualification (Silent Background)
- Tracks user engagement with content (30+ seconds)
- Stores "qualified placements" in localStorage
- **No UI changes** - runs silently

### Phase 2: Display (On Navigation)
- When user tries to navigate away from a qualified placement
- Shows modal with confidence + emotion survey
- 10-second countdown before user can continue

---

## Integration Pattern - 3 Simple Steps

### Step 1: Import the hooks
```typescript
import { useBrainBreak, useQualifyPlacement, useBrainBreakNavigation } from '@/experiments/TEAME-177/hooks';
import type { BrainBreakPlacement } from '@/experiments/TEAME-177/BrainBreakModal/BrainBreakContext';
```

### Step 2: Qualify the placement (when user engages)
```typescript
// Call this when user has been on the page/step for 30+ seconds
const { qualifyPlacement } = useBrainBreak();

// Later, when engagement threshold is met:
qualifyPlacement('about-the-skill');
```

### Step 3: Wrap navigation (to trigger the modal)
```typescript
// Option A: Use the navigation wrapper helper
const { handleBrainBreakNavigation } = useBrainBreakNavigation();

onClick={() => handleBrainBreakNavigation(() => navigate('/somewhere'), 'about-the-skill')}

// Option B: Use withBrainBreak HOC
import { withBrainBreak } from '@/experiments/TEAME-177/hooks';

onClick={withBrainBreak(() => navigate('/somewhere'), 'about-the-skill')}
```

---

## Available Placement Types

These are the predefined placements in `BrainBreakPlacement`:

```typescript
type BrainBreakPlacement =
  | 'skill-selection'           // From dashboard to skill
  | 'about-the-skill'           // About the skill step
  | 'worked-example'            // After watching video
  | 'practice-problems'         // During/after practice
  | 'assessment-completed'      // After assessment
  | 'assessment-completed_passed'  // Passed assessment
  | 'assessment-completed_failed'; // Failed assessment
```

---

## Current Timeline Integration (SkillResource.tsx)

**File**: `src/components/SkillResource/SkillResource.tsx`

The timeline already has partial brain break integration:

```typescript
// Lines 532-539: Timeline events mapped to brain break placements
const timelinePlacementMap: Partial<Record<TimelineEventsEnums, BrainBreakPlacement>> = {
  [TimelineEventsEnums.GET_STARTED_BTN]: 'about-the-skill',
  [TimelineEventsEnums.PRACTICE_PROBLEMS_BTN]: 'worked-example',
  [TimelineEventsEnums.DIGITAL_LESSON_ENGLISH_BTN]: 'practice-problems',
  [TimelineEventsEnums.DIGITAL_LESSON_SPANISH_BTN]: 'practice-problems',
  [TimelineEventsEnums.ADDITIONAL_LESSONS_RESOURCES_BTN]: 'practice-problems',
  [TimelineEventsEnums.TAKE_SINGLE_SKILL_CHALLENGE_BTN]: 'practice-problems',
};

// Lines 558-561: Navigation is wrapped
handleTimelineClick(event, index) {
  const placement = timelinePlacementMap[event.eventType];
  if (placement) {
    handleBrainBreakNavigation(() => handleEventClick(event, index), placement);
  } else {
    handleEventClick(event, index);
  }
}
```

---

## Other Components Using Brain Break

| Component | File | Usage |
|-----------|------|-------|
| **WorkedExample** | `components/WorkedExample/WorkedExample.tsx` | Tracks video playback, qualifies after 30s |
| **DashboardCard** | `components/Dashboard/DashboardCard.tsx` | Wraps skill card navigation |
| **AssessmentCompleted** | `components/AssessmentCompleted/AssessmentCompleted.tsx` | Qualifies based on pass/fail, wraps continue buttons |

---

## For Timeline Redesign - What Your Coworker Needs to Do

1. **Add new placement to the type** (if needed):
   - Edit `BrainBreakContext.tsx` to add new placement to `BrainBreakPlacement`

2. **Import the hooks** in the new timeline component

3. **Map timeline steps to placements** - create a mapping object like:
   ```typescript
   const stepToPlacementMap = {
     'video-step': 'worked-example',
     'practice-step': 'practice-problems',
     // etc.
   };
   ```

4. **Wrap navigation handlers** with `handleBrainBreakNavigation` or `withBrainBreak`

5. **Optional: Add engagement timing** using `useEngagementTimer` if needed

---

## Key Context API (from `useBrainBreak()`)

```typescript
interface BrainBreakContextType {
  hasSeenBrainBreak: boolean;      // User already saw it this session
  isEligible: boolean;              // Feature flag is enabled
  showBrainBreak: (positionInput, navigationCallback?, placement?) => void;
  markAsViewed: () => void;
  qualifyPlacement: (placement: BrainBreakPlacement) => void;
}
```

---

## Constants (Timing Configuration)

File: `src/experiments/TEAME-177/constants.ts`

```typescript
PRACTICE_THRESHOLD_MS: 30_000      // 30 seconds
VIDEO_WATCH_THRESHOLD_S: 30        // 30 seconds
COUNTDOWN_DURATION_S: 10           // 10s countdown before user can continue
```

---

## Quick Checklist for Integration

- [ ] Import hooks from `@/experiments/TEAME-177/hooks`
- [ ] Determine which timeline steps map to which placements
- [ ] Call `qualifyPlacement()` when user engages with content
- [ ] Wrap navigation with `handleBrainBreakNavigation()` or `withBrainBreak()`
- [ ] Test with feature flag `TEAME-177-brain-break` enabled

