---
description: Time-based eligibility gating pattern — prevent repeated actions within a cooldown window with same-day prevention
tags: [pattern, cooldown, eligibility, time-gating, frontend, concept]
created: 2026-04-30
updated: 2026-04-30
sources: ["brainbreak-context-cleanup-implementation", "teame-177-in-platform-polling-cleanup", "teame-218-brainbreak-postmortem"]
---

# Cooldown System

Pattern for preventing repeated user actions within a time window. Used in the BrainBreak feature to prevent students from seeing the survey modal too frequently.

## Rules

1. **Same-day prevention** — Cannot trigger twice on the same calendar day
2. **Cooldown period** — Fixed window (e.g., 10 calendar days) between eligible triggers
3. **Cross-device persistence** — Cooldown state stored in database, not localStorage

## Implementation

```typescript
function checkCooldownEligibility(
  cooldownData: CooldownData | undefined,
): CooldownEligibilityResult {
  if (!cooldownData?.lastCompletionDate) {
    return { eligible: true, cooldownData };
  }

  const lastCompletion = new Date(cooldownData.lastCompletionDate);
  const now = new Date();

  // Same-day prevention
  const lastCompletionDay = new Date(
    lastCompletion.getFullYear(),
    lastCompletion.getMonth(),
    lastCompletion.getDate(),
  );
  const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());

  if (lastCompletionDay.getTime() === today.getTime()) {
    return { eligible: false, reason: 'same-day', cooldownData };
  }

  // Cooldown period check
  const daysSinceLastCompletion = Math.floor(
    (now.getTime() - lastCompletion.getTime()) / (1000 * 60 * 60 * 24),
  );
  if (daysSinceLastCompletion < COOLDOWN_DAYS) {
    return {
      eligible: false,
      reason: 'cooldown',
      cooldownData: {
        ...cooldownData,
        daysRemaining: COOLDOWN_DAYS - daysSinceLastCompletion,
      },
    };
  }

  return { eligible: true, cooldownData };
}
```

## Key Decisions

- **Local timezone is correct** for student-facing "daily" features — a student in NY at 11 PM and LA at 11 PM should both see their local day's question
- **Database persistence** required for cross-device consistency
- **date-fns preferred** over manual date math to avoid daylight saving bugs

## Related

- [[brainbreak-context-cleanup-implementation]] — DB migration plan for cooldown data
- [[teame-177-in-platform-polling-cleanup]] — Original cooldown requirements
- [[teame-218-brainbreak-postmortem]] — Cooldown implementation post-mortem
- [[localstorage-to-database-migration]] — Pattern for moving client state to server
