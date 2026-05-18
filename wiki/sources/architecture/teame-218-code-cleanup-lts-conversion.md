---
description: TEAME-218 code cleanup — convert in-platform polling to LTS feature with expanded metrics and cooldown system
tags:
  - work
  - marvin/frontend/brain-break
  - LTS
  - TEAME
  - polling
  - metrics
sources:
  - TEAME-218 Code Cleanup - TEAME-177 (In-Platform Polling).md
created: 2026-04-30
updated: 2026-04-30
---

# TEAME-218: Code Cleanup — Convert In-Platform Polling to LTS Feature

**Source:** TEAME-218 Code Cleanup - TEAME-177 (In-Platform Polling).md
**Date ingested:** 2026-04-30
**Type:** Jira ticket / implementation plan
**Status:** In Progress (High Priority)
**Assignee:** Luis Almonte
**Parent:** PP-442 In-Platform Polling (LTS Feature?)
**URL:** https://newclassrooms.atlassian.net/browse/TEAME-218

## Summary

Convert the in-platform polling (BrainBreak) experiment into a full LTS (Long-Term Support) feature. Coordinate with Vale S on design considerations from HotJar footage. Expand question variety, add cooldown regulation, fix UI coverage, and enrich telemetry.

## Conversion Tasks

### 1. Expand Question Variety
- Include the full math motivation inventory
- Jordan can pull data if Sam unavailable

### 2. Cooldown Regulation
- Store date of last poll completion in `experiments_speculative_data` table
- Use stored date to regulate polling frequency
- Target: 10-calendar-day cool-off period
- Prevent same-day polling across multiple sessions

### 3. UI Coverage Fix
- Ensure brain break experience does not cover the header and logout chip
- Consult Vale S on whether this change is desirable

### 4. Per-Emoji Telemetry
- Add additional log on affect polling for each possible emoji
- Observation type takes value 1 if selected emoji, 0 otherwise

### 5. Experiment Guardrail Logging
- Add support for logging polling measurements for any experiments listed in `experiments-to-guardrail.ts` or similar
- Set flag and variant name based on experiment in question
- Keep existing observation types

## Progress

| Task | Status |
|------|--------|
| Cool-off period | Implemented |
| Per-emoji logging | Implemented |
| Brain break header coverage | Pending |
| Experiment guardrail logging | Pending |

## Related

- [[teame-177-in-platform-polling-cleanup]] — Original polling cleanup implementation
- [[teame-218-brainbreak-postmortem]] — Main TEAME-218 post-mortem
- [[lts-transition]] — LTS conversion process pattern
- [[experiment-speculative-data]] — Pattern for experiment transient data
- [[cooldown-system]] — Time-based eligibility gating
