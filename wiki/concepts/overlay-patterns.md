---
description: Decision framework for choosing between Modal, Popover, and Tooltip based on attention level and interaction complexity
tags: [ui, ux, modal, popover, tooltip, accessibility, overlay]
sources: ["modal-vs-popover-vs-tooltip"]
created: 2026-04-29
updated: 2026-04-29
---

# Overlay Patterns

Decision framework for choosing between Modal, Popover, and Tooltip based on attention level, interaction complexity, and contextual relevance.

## Modal

**Use when**: Task must interrupt user. Critical confirmations, required input, complex forms, focused attention.

| Criteria | Value |
|----------|-------|
| Attention demand | High |
| Interaction complexity | High |
| Content length | Medium to high |
| Page context visible | Weak |
| Mobile suitability | Strong |
| Accessibility difficulty | High |

## Popover

**Use when**: Content is contextual to a trigger. Quick actions, compact settings, lightweight details.

| Criteria | Value |
|----------|-------|
| Attention demand | Medium |
| Interaction complexity | Medium |
| Content length | Low to medium |
| Page context visible | Strong |
| Mobile suitability | Medium |
| Accessibility difficulty | Medium |

**Default recommendation**: If unsure, Popover is the safer middle option.

## Tooltip

**Use when**: Brief explanation only. Non-critical, non-interactive content on hover/focus.

| Criteria | Value |
|----------|-------|
| Attention demand | Low |
| Interaction complexity | Low |
| Content length | Very low |
| Page context visible | Strong |
| Mobile suitability | Weak |
| Accessibility difficulty | Low to medium |

## Decision Flow

1. Does task need to interrupt user? → **Yes** → Modal
2. Does content include actions or multi-step interaction? → **Yes** → Popover
3. Is it only brief explanation with no interaction? → **Yes** → Tooltip

## Related

- [[modal-vs-popover-vs-tooltip]] — Source UX guide
- [[ui-patterns]] — General UI pattern collection
- [[accessibility]] — A11y considerations for overlays