---
description: Brain Brake cooldown not enforced when student retries skill assessment after 10+ days
tags: [work, brainbreak, cooldown, TEAME, bug]
sources: [TEAME-268 Brain Brake is not show when a Student retries a Skill assessment even if the last time the Brain Brake was taken was more than 10 days ago.md]
created: 2026-04-30
updated: 2026-04-30
---

# TEAME-268: Brain Brake Not Shown on Skill Assessment Retry

**Source:** TEAME-268 Brain Brake is not show when a Student retries a Skill assessment even if the last time the Brain Brake was taken was more than 10 days ago.md
**Date ingested:** 2026-04-30
**Type:** Jira ticket / bug report
**Status:** In Progress
**Priority:** Medium
**Assignee:** Luis Almonte
**Reporter:** Maria Canteras
**Created:** April 16, 2026
**URL:** https://newclassrooms.atlassian.net/browse/TEAME-268

## Summary

Brain Brake modal does not appear when a student retries a skill assessment, even when the last Brain Brake was taken more than 10 days ago (well past the cooldown period).

## Expected Behavior

After 10+ days since last Brain Brake, retrying a skill assessment should trigger the Brain Brake modal.

## Actual Behavior

Modal does not appear on retry even though cooldown period has elapsed.

## Investigation Notes

- Luis asked Maria to query `experiments_speculative_data` in the database to confirm cooldown is set correctly for her user
- Possible causes: cooldown not persisted, cooldown check logic missing retry path, or stale data in speculative data table

## Attachments

- `16.04.2026_13.14.43_REC.mp4` — reproduction video
- `16.04.2026_13.08.28_REC.mp4` — reproduction video

## Related

- [[teame-218-brainbreak-postmortem]] — BrainBreak architecture overview
- [[cooldown-system]] — Cooldown implementation pattern
- [[teame-265-brain-brake-login]] — Related Brain Brake login fix
- [[teame-267-brain-brake-practice-problems]] — Related Brain Brake practice problem fix
