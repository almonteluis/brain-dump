---
description: Progressive disclosure — reveal information gradually, matching detail to user need
tags: ["ux", "information-architecture", "cognitive-load", "design-patterns", "concept"]
created: 2026-04-23
---

# Progressive Disclosure

Progressive disclosure is a design pattern that reveals information gradually — showing only what's needed at each level of interaction. It reduces cognitive load by hiding complexity until it's relevant.

## How It Works

1. **Layer 1: Surface** — Names, titles, file tree structure (scanable at a glance)
2. **Layer 2: Summary** — Descriptions, YAML frontmatter, one-line takeaways
3. **Layer 3: Structure** — Headings, outlines, table of contents
4. **Layer 4: Detail** — Full content, code examples, deep-dives

## When to Use

- **Navigation** — File trees before file contents
- **Documentation** — TL;DR before full explanation
- **APIs** — Required params before optional params
- **UI** — Defaults before advanced settings
- **Knowledge bases** — Index before entries, summaries before sources

## Why It Works

Rooted in [[cognitive-load]] theory — the human working memory holds ~4-7 items at once (Miller's Law). By controlling what's visible at each step, you keep users within that capacity.

Related: [[cognitive-load-theory]] (John Sweller, 1988) — intrinsic, extraneous, and germane load.

## In This Vault

The LLM Wiki pattern uses progressive disclosure:
- `wiki/index.md` — entry point (Layer 1)
- YAML `description:` fields — quick summaries (Layer 2)
- Headings — outlines before content (Layer 3)
- Full page content — read when confirmed relevant (Layer 4)

See [[progressive-disclosure-in-practice]] for the vault-specific implementation.

## Related

- [[cognitive-load]] — Mental overhead in software development
- [[progressive-disclosure-in-practice]] — Vault-specific layered navigation
- [[thinking-frameworks-collection]] — OODA, Minto Pyramid, and other frameworks that use staged thinking
