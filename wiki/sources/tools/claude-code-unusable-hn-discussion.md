---
description: HN discussion on Claude Code quality regression after Feb 2026 updates — adaptive thinking under-allocation, effort defaults, thinking token faithfulness
tags:
  - claude/code
  - hn-discussion
  - ai/engineering
  - claude
sources:
  - Issue Claude Code is unusable for complex engineering tasks with Feb updates (github.comanthropics).md
created: 2026-04-21
updated: 2026-04-21
---

# Claude Code "Unusable" HN Discussion

**Source:** Issue Claude Code is unusable for complex engineering tasks with Feb updates (github.com/anthropics)
**Date ingested:** 2026-04-21
**Type:** HN discussion (303KB, ~200+ comments)

## Summary

A GitHub issue sparked a large HN discussion about Claude Code quality regression after February 2026 updates. [[bcherny|Boris Cherny]] from the Claude Code team responded with detailed explanations of two changes: thinking redaction and effort default adjustments. The discussion revealed a genuine bug with adaptive thinking under-allocating reasoning on certain turns, plus broader philosophical debates about thinking token faithfulness and distillation concerns.

## Key Claims

1. **Two Feb changes caused perceived regression:**
   - `redact-thinking-2026-02-12` — hides thinking from UI (latency optimization, not quality impact)
   - Effort=85 default on Opus 4.6 (Mar 3) — intelligence-latency sweet spot, but reduces quality for complex tasks

2. **Adaptive thinking can under-allocate reasoning** — Boris Cherny confirmed that on specific turns, zero reasoning was emitted while turns with deep reasoning were correct. This caused fabrications (Stripe API versions, git SHA suffixes, apt package lists)

3. **Thinking tokens aren't faithful** — Anthropic research shows Claude 3.7 Sonnet mentions hints in CoT only ~25% of the time. The thinking is post-hoc rationalization, not true introspection.

4. **Distillation is the real reason thinking is hidden** — Community consensus that preventing model distillation by competitors is the primary motivation for hiding thinking, not the stated UI simplification.

5. **Settings fragmentation** — Four+ ways to set the same config (settings.json, env vars, slash commands, magic keywords), plus managed settings via registry keys and merged JSON directories.

## Workarounds Discovered

| Setting | Purpose | How to Set |
|---------|---------|------------|
| `showThinkingSummaries: true` | Restore thinking visibility | settings.json |
| `CLAUDE_CODE_EFFORT_LEVEL=max` | Max effort across all sessions + subagents | Environment variable |
| `CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1` | Force fixed reasoning budget instead of per-turn model decision | Environment variable |
| `/effort high` or `/effort max` | Per-session effort override | Slash command |
| `ULTRATHINK` keyword | Max effort for a single turn | Chat keyword |

## Notable Community Patterns

- **gck1's sidecar pattern** — Unsupervised worker agents inject messages when thinking tokens match heuristics. Example: whenever Opus says "pragmatic", auto-send `Esc Esc > "Pragmatic fix is always wrong, do the Correct fix"`. Also flags "pre-existing issue" as never actually pre-existing.

- **Thinking as debugging signal** — Multiple users report using thinking tokens to detect when Claude is going off track, even if the tokens aren't faithful representations of internal logic.

- **Over-effort loop** — Max effort can cause "desperate" behavior: circular reasoning, undoing changes, making things worse. Medium effort can sometimes produce cleaner results.

## Entities Mentioned

- [[bcherny|Boris Cherny]] — Claude Code team member, responded with detailed technical explanation
- [[Anthropic]] — Company behind Claude Code

## Concepts Covered

- [[claude-code-thinking-transparency|Thinking Transparency]] — The debate around visible thinking tokens
- [[claude-code-power-user-patterns|Claude Code Patterns]] — Effort levels, settings configuration
- [[context-engineering|Context Engineering]] — How reasoning budgets affect code quality
- Adaptive thinking — Model-decided reasoning duration vs fixed budgets
- Distillation prevention — Hiding outputs to prevent competitor model training
