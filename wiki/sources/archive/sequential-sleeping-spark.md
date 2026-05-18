---
description: "Fix Plan: TEAME-189 - Failed loading Skill assessment after page refresh"
tags: ['research']
raw_file: "sequential-sleeping-spark.md"
created: 2026-05-17
---

# Fix Plan: TEAME-189 - Failed loading Skill assessment after page refresh

## Bug Description

When a Skill has multiple previous assessment attempts:
1. User starts a NEW assessment iteration
2. User answers some questions (creates incomplete session)
3. User refreshes the page
4. **Bug**: Practice Problems and Skill Assessment 'Start' button don't load

## Root Cause Analysis

The bug occurs due to a race condition in `buildTimeline.ts`:

### Current Code Flow (Buggy):

In `buildTimeline.ts:51-58`, when the last timeline event is a completed `SKILL_CHALLENGE`:

```typescript
if (
  lastEvent.id === TimelineEventsEnums.SKILL_CHALLENGE_TXT &&
  lastEvent.lrnSessionId &&
  lastEvent.previousActivityId
) {
  loadPreviousSession(lastEvent?.lrnSessionId, lastEvent.previousActivityId, true);
  setAssessmentState('review');  // ← Sets data to 'review' state
  orderedTimeline.push(lessonButtons(disabledKhanContent));
  // ❌ Never calls setSkipRequest(false) !!
}
```

### Why This Breaks:

1. `loadPreviousSession` sets `data` in `useLrnSessionBySkill` hook with state='review'
2. `setAssessmentState('review')` also sets the state to 'review'
3. **But `skipRequest` is never set to `false`**
4. Meanwhile, there's an **incomplete** session in the backend that should be loaded
5. The `useLrnSessionBySkill` useEffect (lines 59-83) needs `skipRequest === false` to fetch:

```typescript
useEffect(() => {
  if (!skipRequest) {  // ← Still true because buildTimeline never set it to false!
    getAssessmentStatusMutation({...});  // Never runs!
  }
}, [refetch, accessTokenRedux, skipRequest]);
```

6. Result: The incomplete session is never fetched, `data` remains in 'review' state with old session info
7. The UI renders the wrong state and Start button doesn't work

### Other branches work correctly:

All other branches in `buildTimeline` call `setSkipRequest(false)`:
- Line 61: WORKED_EXAMPLE_VIDE_TXT
- Line 69: PRACTICE_PROBLEMS_TXT and others
- Line 72: ABOUT_THE_SKILL_TXT
- Line 85: LESSON_EVENT

## Solution

Add `setSkipRequest(false)` in the SKILL_CHALLENGE_TXT branch to ensure the incomplete session fetch happens.

## Files to Modify

1. **frontend/src/utils/buildTimeline.ts** (line 51-59)
   - Add `setSkipRequest(false)` after `loadPreviousSession` call

## Verification

1. Create a skill with multiple completed assessments
2. Start a new assessment and answer a few questions
3. Refresh the page
4. Verify Practice Problems load
5. Verify Start button loads and starts the incomplete session
6. Run existing tests to ensure no regressions

## Alternative Consideration

The bug might have a secondary component - when loading a previous session for review, we might want to also check if there's an incomplete session and prioritize that. However, adding `setSkipRequest(false)` should fix the primary issue by allowing the useEffect to fetch and potentially override the review state with the incomplete session.

