---
description: Progressive disclosure — reveal information gradually, matching detail to user need. Don't dump everything on the screen at once.
tags:
  - ux
  - information-architecture
  - cognitive/load
  - design/patterns
  - concept
created: 2026-04-23
updated: 2026-05-17
---

# Progressive Disclosure

Progressive disclosure is the design pattern that says "don't show everything at once." Reveal information gradually — only what's needed at each step — and you keep people from drowning in detail they don't need yet.

## The Four Layers

1. **Surface** — Names, titles, file tree structure. Scanable at a glance.
2. **Summary** — Descriptions, YAML frontmatter, one-line takeaways.
3. **Structure** — Headings, outlines, table of contents.
4. **Detail** — Full content, code examples, deep-dives.

Each layer is a filter. If the surface tells you "this isn't what I need," you stop. If it might be relevant, you peel back one layer. You only read the full thing when you're sure it matters.

## Where You See It

- **Navigation** — file trees before file contents
- **Documentation** — TL;DR before full explanation
- **APIs** — required params before optional params
- **UI** — defaults before advanced settings
- **Knowledge bases** — index before entries, summaries before sources

## Why It Works

[[cognitive-load]] theory — the human working memory holds ~4-7 items at once (Miller's Law). By controlling what's visible at each step, you keep users within that capacity. Show 50 things and they remember none. Show 5 and they actually engage.

Related: [[cognitive-load-theory]] (John Sweller, 1988) — intrinsic, extraneous, and germane load.

## In This Vault

The LLM Wiki pattern uses progressive disclosure:
- `wiki/index.md` — entry point (Layer 1)
- YAML `description:` fields — quick summaries (Layer 2)
- Headings — outlines before content (Layer 3)
- Full page content — read when confirmed relevant (Layer 4)

See [[progressive-disclosure-in-practice]] for the vault-specific implementation.

The same principle runs in the opposite direction in [[overlay-patterns]] — modals demand your attention, tooltips whisper. Picking the right overlay is progressive disclosure applied to interruption.

## Related

- [[cognitive-load]] — Mental overhead in software development
- [[progressive-disclosure-in-practice]] — Vault-specific layered navigation
- [[thinking-frameworks-collection]] — OODA, Minto Pyramid, and other frameworks that use staged thinking
