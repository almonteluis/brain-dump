---
type: concept
status: stub
created: 2026-05-17
source_capture: "[[My thoughts shipping faster code]]"
---

# Shift-left FE automation — run Playwright when the feature hits dev, not when QA asks

The standard flow: build the feature, push to dev, wait for QA, *then* run the frontend automation suite, find bugs, fix them under pressure. The whole time you're context-switching between the new thing you're building and the old thing you thought was done.

The shift: once the feature is on dev and you think it's working, run the Playwright suite right then. Not because you're doing QA's job — because catching your own bugs while you still have the code loaded in your head is 10x faster than catching them three days later when you've moved on. The automation suite isn't a QA gate. It's a developer tool you've been treating as someone else's responsibility.

This is shift-left testing applied specifically to frontend E2E. Unit tests run during dev. Integration tests run during dev. But Playwright? That somehow got classified as "a QA thing." It's not. It's a regression safety net that works best when you're the one reading the failures, because you wrote the code five minutes ago.

This pairs with [[spatial-terminal-layouts]] — the QA terminal layout exists precisely because the workflow of "run automation, read failures, fix, repeat" needs its own spatial context. If you're running automation earlier, you probably need that layout earlier too, not just during QA crunch.
