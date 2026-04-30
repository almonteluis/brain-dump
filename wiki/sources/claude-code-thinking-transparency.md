---
description: Boris from Claude Code team explains adaptive thinking, effort levels, and thinking transparency — showThinkingSummaries, CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING, /effort command
tags: ["claude-code", "thinking", "adaptive-thinking", "effort-levels", "transparency"]
sources: ["Issue Claude Code is unusable for complex engineering tasks with Feb updates (github.comanthropics).md"]
created: 2026-04-11
updated: 2026-04-11
---

# Claude Code Thinking Transparency

**Source:** HN discussion on github.com/anthropics/claude-code issue #42796
**Type:** Community discussion + official response
**Date ingested:** 2026-04-11

## Summary

Boris (bcherny) from the Claude Code team responded to community concerns about reduced thinking transparency in Claude Code. Two changes in Feb-Mar 2026 affected how thinking appears to users: the `redact-thinking-2026-02-12` beta header and the default effort level of 85 (medium).

## Key Settings and Commands

| Setting | Purpose | Default |
|---------|---------|---------|
| `showThinkingSummaries: true` | Show thinking summaries in UI | `false` (hidden since Feb) |
| `CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING` | Disable adaptive thinking, use fixed budgets | Not set |
| `/effort` | Set effort level for current session | `85` (medium) since Mar 3 |
| `/effort high` | High effort mode | Sticky across sessions |
| `/effort max` | Maximum effort mode | Sticky across sessions |
| `ULTRATHINK` keyword | Force high effort for single turn | Per-turn |

## Two Changes That Affected Thinking

### 1. `redact-thinking-2026-02-12` Beta Header (Feb 9)

- Hides thinking from the UI — **UI-only change**, does not impact thinking itself or budgets
- Under the hood, avoids needing thinking summaries, which reduces latency
- Transcripts stored locally won't show raw thinking when this header is set
- **Opt out:** Set `showThinkingSummaries: true` in `settings.json`

### 2. Medium Effort (85) Default on Opus 4.6 (Mar 3)

- Opus 4.6 supports **adaptive thinking** — model decides how long to think, better than fixed budgets
- Effort=85 found to be sweet spot on intelligence-latency/cost curve
- Rolled out with dialog notification and visible effort level for first few uses
- Teams and Enterprise users will default to **high effort** going forward
- **Opt out:** Use `/effort high` or `/effort max`, or set in `settings.json`

## Community Concerns

### Thinking Tokens Are Not Faithful
Anthropic's research ([reasoning models don't say think](https://www.anthropic.com/research/reasoning-models-dont-say-think)) shows thinking tokens are not fully faithful representations of internal logic. This is one reason for hiding them.

### Competing Theories for Hidden Thinking
- **Anti-distillation** — Prevent competitors from using thinking output to train models
- **Latency reduction** — Avoid computing and transmitting thinking summaries
- **Accuracy** — Thinking tokens don't faithfully represent model reasoning

### Practical Uses of Visible Thinking
- **Course correction** — Users stop Claude when thinking goes wrong direction
- **Agent sidecars** — Automated systems inject corrections when thinking matches heuristics (e.g., "pragmatic" triggers re-prompt for correct fix)
- **Prompt debugging** — Users notice missing instructions while reading chain of reasoning

### Key Insight from gck1
> "I have yet to find one where thinking tokens didn't hint at the root cause of the failure."

All unsupervised worker agents have sidecars that inject messages when thinking tokens match heuristics. When "pragmatic" appears, it triggers an automatic re-prompt for the correct fix.

## Recommendations for Claude Code Users

1. **Enable thinking summaries** — `showThinkingSummaries: true` in settings.json
2. **Use higher effort for complex tasks** — `/effort high` or ULTRATHINK for individual turns
3. **Use adaptive thinking** — Keep enabled; it generally works better than fixed budgets
4. **Monitor thinking for agent workflows** — If building automated agents, parse thinking tokens for course-correction signals

## Related

- [[workflows]] — Claude Code power user workflows
- [[context-engineering]] — Designing context windows for AI agents
- [[advanced-context-engineering]] — Frequent intentional compaction workflow
- [[ai-engineering]] — AI-assisted software engineering hub
