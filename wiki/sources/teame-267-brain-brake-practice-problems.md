---
description: Brain Brake not shown after 30 seconds in Practice Problems section — fixed to trigger from both Take Challenge buttons
tags: [work, brainbreak, resolved, TEAME]
sources: [TEAME-267 Brain Brake is not show after spending 30 seconds in the Practice Problem's section.md]
created: 2026-04-30
updated: 2026-04-30
---

# TEAME-267: Brain Brake in Practice Problems

**Source:** TEAME-267 Brain Brake is not show after spending 30 seconds in the Practice Problem's section.md
**Date ingested:** 2026-04-30
**Type:** Jira ticket / bug fix
**Status:** Resolved (April 17, 2026)
**Priority:** Medium
**Assignee:** Luis Almonte
**Reporter:** Maria Canteras
**Created:** April 16, 2026
**URL:** https://newclassrooms.atlassian.net/browse/TEAME-267

## Summary

Brain Brake modal was not appearing after spending 30 seconds in the Practice Problems section. Fixed to trigger from both "Take Challenge" buttons.

## Implementation

- Initially only triggered from the "Take the Challenge" button in the timeline
- Added trigger from the second "Take Challenge" button in the practice problem section
- Both buttons now correctly initiate the Brain Brake flow

## Conflict Noted

Maria flagged a potential conflict between Brain Brake triggered from the "Take Challenge" button and upcoming **TEAMC-2951** implementation. Figma designs may change this flow. CC: Jackie Straus, Sam Saarinen, Marilia Quina.

## Verification

- **April 17, 2026:** Maria Canteras re-tested in qa-clam — working as expected

## Attachments

- `17.04.2026_16.24.13_REC.mp4` — verification
- `17.04.2026_16.27.16_REC.mp4` — verification
- `16.04.2026_18.43.02_REC.mp4` — original reproduction
- `16.04.2026_15.36.34_REC.mp4` — original reproduction

## Related

- [[teame-218-brainbreak-postmortem]] — BrainBreak architecture
- [[teame-265-brain-brake-login]] — Related Brain Brake login fix
- [[teame-268-brain-brake-retry-cooldown]] — Related cooldown issue
