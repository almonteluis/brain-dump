---
description: Overlay Patterns — Modal, Popover, and Tooltip. Pick based on how much attention you need. Modal = stop everything. Popover = sidebar chat. Tooltip = whisper.
tags:
  - ui
  - ux
  - modal
  - popover
  - tooltip
  - accessibility
  - overlay
sources:
  - "modal-vs-popover-vs-tooltip"
created: 2026-04-29
updated: 2026-05-17
---

# Overlay Patterns

Three overlay types. Three attention levels. Pick wrong and you either interrupt someone for no reason or hide critical information behind a whisper. The decision framework is simple: how much of the user's attention do you need?

## Modal: "Stop Everything"

Modals are the friend who pauses the movie because they *have* to tell you something critical. The rest of the page goes dim. The user can't do anything else until they deal with this. Use for confirming purchases, signing in, filling required forms. Abuse for anything less important and users will hate you.

| Criteria | Value |
|----------|-------|
| Attention demand | High |
| Interaction complexity | High |
| Content length | Medium to high |
| Page context visible | Weak (dimmed) |
| Mobile suitability | Strong |
| Accessibility difficulty | High |

## Popover: "Quick Sidebar Chat"

Popovers are the helpful assistant leaning in with options right next to what you're doing. Doesn't block the whole page. Connected to a specific element. Perfect for mini-menus, quick settings, showing detail without navigating away. **When in doubt, pick popover.** It's the chill middle ground.

| Criteria | Value |
|----------|-------|
| Attention demand | Medium |
| Interaction complexity | Medium |
| Content length | Low to medium |
| Page context visible | Strong |
| Mobile suitability | Medium |
| Accessibility difficulty | Medium |

## Tooltip: "FYI Whisper"

Tooltips are the quietest — a tiny text blurb on hover/focus. Strictly for short, non-interactive explanations. Clarifying an icon, labeling a data point. If you need more than a few words or any interaction, you've outgrown the tooltip.

| Criteria | Value |
|----------|-------|
| Attention demand | Low |
| Interaction complexity | Low |
| Content length | Very low |
| Page context visible | Strong |
| Mobile suitability | Weak |
| Accessibility difficulty | Low to medium |

## Decision Flow

1. **Does this need to stop the user completely?** → Modal
2. **Does it need interaction but not a full takeover?** → Popover
3. **Is it a brief label with zero interaction?** → Tooltip

These overlays are [[progressive-disclosure]] applied to interruption. The amount of attention you demand = the amount of information you can deliver. Demand too much and you're annoying. Demand too little and the message gets lost.

## Related

- [[modal-vs-popover-vs-tooltip]] — Source UX guide
- [[ui-patterns]] — General UI pattern collection
- [[accessibility]] — A11y considerations for overlays
