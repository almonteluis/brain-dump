---
description: Decision framework for choosing between Modal, Popover, and Tooltip overlay patterns with criteria matrix
tags: [ui, ux, overlay, modal, popover, tooltip, accessibility]
sources: ["Modal vs Popover vs Tooltip Which Overlay Pattern Should You Use?.md"]
created: 2026-04-29
updated: 2026-04-29
---

# Modal vs Popover vs Tooltip

**Source:** [[Modal vs Popover vs Tooltip Which Overlay Pattern Should You Use?]]
**Date ingested:** 2026-04-29
**Type:** UX guide

## Summary

Decision framework for choosing between Modal, Popover, and Tooltip overlay patterns. From uxpatterns.dev by David Dias. Includes interactive decision flow and criteria comparison matrix.

## Key Claims

1. **Modal** — Use when task must interrupt user. Best for: blocking tasks, required actions, complex forms, focused input. High attention demand, high accessibility difficulty.
2. **Popover** — Use when content is contextual to a trigger. Best for: quick actions, compact settings, lightweight details. Safer middle option when unsure.
3. **Tooltip** — Use when users need brief explanation only. Best for: non-critical, non-interactive text on hover/focus. Lowest UI cost.
4. **Default recommendation**: If unsure, don't stuff interaction into tooltip. Popover is the safer middle option.
5. Mobile: Modal is strongest; Tooltip weakest. Accessibility: Modal is hardest; Tooltip easiest.

## Entities Mentioned

- [[David Dias]] — Author, uxpatterns.dev
- [[React Flow]] — Library used for decision flow diagram

## Concepts Covered

- [[modal-pattern]] — Blocking overlay for focused tasks
- [[popover-pattern]] — Contextual lightweight overlay
- [[tooltip-pattern]] — Brief explanatory hover overlay
- [[overlay-decision-framework]] — Criteria for choosing overlay types