---
description: Code cleanup ticket converting In-Platform Polling from experiment to LTS feature with design coordination, MMI expansion, cooldown logic, and enhanced logging
tags: [source, work, brainbreak, polling, lts, experiment, logging, ab-testing, teame]
sources: ["TEAME-177-in-platform-polling-cleanup.md"]
created: 2026-04-30
updated: 2026-04-30
---

# TEAME-177: In-Platform Polling Cleanup

**Source:** `TEAME-177-in-platform-polling-cleanup.md`
**Date ingested:** 2026-04-30
**Type:** work-doc

## Summary

Jira ticket (TEAME-177) for converting the In-Platform Polling / BrainBreak feature from an A/B experiment to a Long-Term Support (LTS) feature. Covers design coordination with Vale S, Math Motivation Inventory (MMI) question expansion, cooldown frequency logic, UI fixes, per-emoji binary logging, and experiment guardrail logging. Superseded by TEAME-218.

## Key Claims

- Polling feature needs LTS conversion — experiment code is temporary, LTS is permanent
- Cooldown requires cross-device persistence (database, not localStorage)
- Per-emoji binary logging (`1` = selected, `0` = not selected) simplifies analysis vs parsing a single emoji field
- Experiment guardrail logging should read from `experiments-to-guardrail.ts` and log flag + variant for each active experiment
- Brain break modal z-index may intentionally cover header — requires design approval before changing

## Requirements

### 1. Design Coordination
- Review HotJar footage with Vale S for usability concerns, design cohesion, completion/intention improvements

### 2. Expand Question Variety (Possibility)
- Source full Math Motivation Inventory (MMI) question set
- Create rotation/selection logic for expanded question pool

### 3. Change Polling Frequency (Possibility)
- Store `date_of_last_poll_completion` in experiment speculative data table
- 10-calendar-day cool-off period
- Same-day completion guard (prevent multiple completions per day, even across sessions)

### 4. UI Fix: Brain Break Header Coverage (Possibility)
- Issue: brain break modal covers header and logout chip
- Requires Vale S approval — may be intentional design

### 5. Enhanced Logging: Affect Polling
- Add separate observation type per emoji option
- Binary encoding: `1` if selected, `0` if not selected
- Example: `affect_poll_emoji_happy`, `affect_poll_emoji_neutral`, etc.

### 6. Experiment Guardrail Logging
- Read experiments from `experiments-to-guardrail.ts`
- For each experiment: log `polling_experiment_flag` (experiment ID) and `polling_experiment_variant` (treatment/control)
- Keep existing observation types intact

## Open Questions

1. What is the full list of emojis used in affect polling?
2. Where is `experiments-to-guardrail.ts` located?
3. What is the current polling frequency (before cool-off)?
4. Should cool-off period be configurable or hardcoded?
5. Does Vale S approve the header coverage fix?
6. Should all MMI questions be used or a curated subset?

## Definition of Done

- [ ] HotJar footage reviewed, design updates implemented (if any)
- [ ] Cool-off period implemented with same-day guard
- [ ] Brain break no longer covers header (if approved)
- [ ] Per-emoji logging added (binary encoding)
- [ ] Experiment guardrail logging implemented
- [ ] QA passes all scenarios
- [ ] Documentation updated

## Entities Mentioned

- [[BrainBreak]] — Student-facing survey modal
- [[Math Motivation Inventory]] — Full MMI question set for polling expansion
- [[Vale S]] — Design stakeholder for BrainBreak UI
- [[experiments-to-guardrail.ts]] — Experiment configuration file
- [[experiment-speculative-data]] — Database table for transient experiment data

## Concepts Covered

- [[lts-transition]] — Converting A/B experiment code to permanent feature
- [[ab-testing-lifecycle]] — Three-stage process: Design → In-Platform Testing → LTS
- [[cooldown-system]] — Time-based gating with same-day prevention
- [[experiment-guardrail-logging]] — Logging experiment context alongside feature metrics
- [[per-emoji-binary-logging]] — One-hot encoding for categorical selections

## Related

- [[teame-218-brainbreak-postmortem]] — Successor ticket that replaced TEAME-177
- [[ab-testing-lifecycle]] — Full A/B testing lifecycle guide
- [[brainbreak-context-cleanup-implementation]] — Implementation plan for cooldown DB migration
