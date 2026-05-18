---
description: HN discussion on Claude Code thinking changes (Feb 2026) — official response from Boris Cherny explaining adaptive thinking, effort levels, and showThinkingSummaries
tags:
  - source
  - claude/code
  - ai/engineering
  - discussion
  - hn
sources:
  - Issue Claude Code is unusable for complex engineering tasks with Feb updates (github.comanthropics).md
created: 2026-04-17
updated: 2026-04-17
---

# Claude Code Thinking HN Discussion

**Source:** `raw/Issue Claude Code is unusable for complex engineering tasks with Feb updates (github.comanthropics).md`
**Date ingested:** 2026-04-17
**Type:** Hacker News discussion (303KB)

## Summary

Extensive HN discussion on a GitHub issue claiming Claude Code degraded after February 2026 updates. Boris Cherny (Claude Code team) responded with detailed technical explanation of the changes.

## Key Claims

1. **`redact-thinking-2026-02-12` header** — Hides thinking from UI to reduce latency. Does NOT impact thinking itself or budgets. Opt out with `showThinkingSummaries: true` in settings.json
2. **Opus 4.6 adaptive thinking (Feb 9)** — Model decides how long to think, replacing fixed thinking budgets. Better across the board. Opt out with `CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING`
3. **Medium effort (85) default on Opus 4.6 (Mar 3)** — Sweet spot on intelligence-latency/cost curve. Rollout included dialog notification and effort display
4. **Thinking tokens aren't faithful** — Anthropic research shows reasoning models' stated thinking doesn't match internal logic. Also prevents model distillation by competitors
5. **Teams/Enterprise** — Will default to high effort going forward

## Community Perspectives

| Viewpoint | Position |
|-----------|----------|
| Power users | Want raw thinking visible for course correction |
| Anthropic | Thinking summaries balance utility with latency; raw thinking available via API |
| Skeptics | Concern about hidden model behavior and codebase safety |
| Pragmatists | Code output is better indicator than thinking text anyway |

## Concepts Covered

- [[claude-code-thinking-transparency]] — Thinking visibility settings
- [[workflows]] — Power user workflows
- [[claude-code-power-user-patterns]] — Effort levels, ULTRATHINK

## Key Takeaways for Claude Code Users

- Use `showThinkingSummaries: true` to restore thinking visibility
- Use `/effort high` or ULTRATHINK for complex tasks
- Adaptive thinking > fixed budgets for most use cases
- Teams will get high effort by default

## Related

- [[claude-code-thinking-transparency]] — Detailed thinking settings reference
- [[workflows]] — Power user Claude Code workflows
- [[writing-good-claude-md]] — CLAUDE.md configuration
