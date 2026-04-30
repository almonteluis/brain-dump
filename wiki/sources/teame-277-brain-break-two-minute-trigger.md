---
description: Brain Break triggered for same student within 2 minutes — cooldown not working
tags: [work, brainbreak, cooldown, TEAME, bug]
sources: [TEAME-277 Brain Break triggered for the same Student within 2 minutes.md]
created: 2026-04-30
updated: 2026-04-30
---

# TEAME-277: Brain Break Triggered Within 2 Minutes

**Source:** TEAME-277 Brain Break triggered for the same Student within 2 minutes.md
**Date ingested:** 2026-04-30
**Type:** Jira ticket / bug report
**Status:** Open (reported 17 hours ago)
**Priority:** Medium
**Assignee:** Luis Almonte
**Reporter:** Maria Canteras
**Created:** April 29, 2026
**URL:** https://newclassrooms.atlassian.net/browse/TEAME-277

## Summary

Brain Break modal was triggered for the same student twice within a 2-minute window. The cooldown system should prevent re-triggering this quickly.

## Expected Behavior

Brain Break should not re-trigger within the cooldown period (10 calendar days, or at minimum a session-level debounce).

## Actual Behavior

Modal appeared twice for same student within 2 minutes.

## Attachments

- `29.04.2026_16.35.34_REC.mp4` — reproduction video (April 29, 2026)

## Notes

- Very recently reported — may indicate a regression in cooldown logic
- Could be related to session lock issues or cooldown check bypass
- Check if session lock and cooldown are using same data source

## Related

- [[teame-218-brainbreak-postmortem]] — BrainBreak architecture and cooldown design
- [[bb-cross-browser-session-lock]] — Session lock implementation
- [[cooldown-system]] — Cooldown eligibility gating
- [[teame-268-brain-brake-retry-cooldown]] — Related cooldown issue
