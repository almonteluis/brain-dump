---
description: Brain Break scrollbar drag is not responsive on first question — fixed 2026-05-01
tags:
  - work
  - marvin/frontend/brain-break
  - usability
  - TEAME
  - ui
  - resolved
sources:
  - TEAME-272 UsabilityBrain Break - When dragging the horizontal scroll bar of the 1st question
  - it is not so agile.md
  - brain break status update.md
created: 2026-04-30
updated: 2026-05-01
---

# TEAME-272: Brain Break Scrollbar Usability Issue

**Source:** TEAME-272 UsabilityBrain Break - When dragging the horizontal scroll bar of the 1st question, it is not so agile.md
**Date ingested:** 2026-04-30
**Type:** Jira ticket / usability bug
**Status:** Fixed (2026-05-01)
**Priority:** Low
**Assignee:** Luis Almonte
**Reporter:** Maria Canteras
**Created:** April 16, 2026
**Last tested:** April 29, 2026 (17 hours ago)
**URL:** https://newclassrooms.atlassian.net/browse/TEAME-272

## Summary

When dragging the horizontal scroll bar of the first question in the Brain Break modal, the interaction is not responsive/agile. Issue persists after re-testing in qa-clam.

## Reproduction

1. Open Brain Break modal
2. Attempt to drag horizontal scrollbar on first question
3. Scrollbar does not respond smoothly to drag input

## Status

- **April 16, 2026:** Ticket created
- **April 29, 2026:** Maria re-tested in qa-clam — issue still persists

## Attachments

- `29.04.2026_16.40.30_REC.mp4` — latest reproduction (April 29)
- `16.04.2026_17.58.24_REC.mp4` — original reproduction (April 16)

## Notes

- Low priority usability issue
- May be related to PrimeReact Dialog component or custom scroll container styling
- Could be a touch/drag event handling issue

## Update — 2026-05-01

Per [[BB being open in 2 sessions via different browser|sprint status voice memo]]: fixed. Voice memo references "confidence slider" terminology rather than "scrollbar drag" — confirming this is the same Q1 drag-input usability issue.

> "Usability/Break Break: when dragging the confidence slider, that has been fixed." — Luis Almonte

## Related

- [[BB being open in 2 sessions via different browser]] — 2026-05-01 sprint status snapshot
- [[teame-218-brainbreak-postmortem]] — BrainBreak modal architecture
