---
description: TEAME-284 — Brain Break Q2 emotion-picker green options cut off on 1366×768 desktop screens; spacing/responsive fix
tags:
  - work
  - marvin/frontend/brain-break
  - ui
  - responsiveness
  - TEAME
  - in-progress
sources:
  - TEAME-284.md
  - brain break status update.md
created: 2026-05-01
updated: 2026-05-01
---

# TEAME-284: Q2 Emotion-Picker Responsiveness

**Source:** TEAME-284.md, [[BB being open in 2 sessions via different browser|brain break status update.md]]
**Date ingested:** 2026-05-01
**Type:** Jira ticket / UI bug
**Status:** In Progress
**Priority:** Release-blocking (per Maria QA)
**Assignee:** Luis Almonte
**Reporter:** Maria Canteras

## Summary

On the Brain Break second survey question (emotion picker), the row of "green" emotion options on the fourth row is cut off (or rendered as hidden) on a 16-inch screen at **1366×768** resolution. Visual indication says hidden but the elements are partially visible — the issue is excessive border/spacing pushing content past the viewport.

## Reproduction

1. Open Brain Break modal at 1366×768 viewport (16-inch laptop common size)
2. Advance to Q2 (emotion picker)
3. Observe: 4th row of green emotion options cut off / pushed past the visible Dialog area

## Root Cause Hypothesis

> "Border spacing is too much. I got to double-check. I got to tweak that further."

— Luis Almonte (voice memo, 2026-05-01)

Likely a CSS spacing issue (margin/padding/gap) on the emotion-picker grid that doesn't compress enough at the 1366×768 breakpoint. Container or row-gap probably needs reduction at desktop-medium breakpoints.

## Release Gate

Per Maria Canteras's QA review (2026-04-30/05-01):

> "I think that as long as we have TEAME-284 before the release from the UI perspective, we might be ready to go."

This is the **final UI blocker** for the Brain Break April 2026 sprint release.

## Plan

1. Locate emotion-picker Q2 component
2. Audit CSS spacing values (gap, margin, padding, border) on the row container at desktop breakpoints
3. Tweak spacing for 1366×768 viewport without regressing other resolutions
4. Re-verify at: 1366×768, 1440×900, 1920×1080, common tablet/mobile widths
5. Hand back to Maria for QA pass

## Related

- [[BB being open in 2 sessions via different browser]] — Sprint snapshot identifying this as the gating bug
- [[teame-218-brainbreak-postmortem]] — Brain Break architecture and prior UI fixes
- [[teame-218-code-cleanup-lts-conversion]] — In-progress LTS conversion (sibling work)
- [[teame-235-dropdowns-overlapping-footer]] — Other open Brain-Break-adjacent UI bug
- [[Backlog]]
