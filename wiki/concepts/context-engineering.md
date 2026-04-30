---
description: Designing context windows for AI agents — correctness, completeness, size, trajectory
tags: ["ai-engineering", "context-window", "llm", "prompt-engineering"]
created: 2026-04-09
updated: 2026-04-09
---

# Context Engineering

The practice of structuring and managing what goes into an LLM's context window to maximize output quality. The only lever you have to affect output quality (without training) is input quality.

## Core Insight

> LLMs are stateless functions. Context window in, next step out.

At any given point, a coding agent turn is a stateless function call. The contents of your context window are the ONLY lever to affect output quality.

## Four Dimensions

Optimize context for (in priority order):

| Dimension | Priority | Failure Mode |
|-----------|----------|--------------|
| **Correctness** | 1st | Wrong information leads to wrong outputs |
| **Completeness** | 2nd | Missing information causes guesses |
| **Size** | 3rd | Noise degrades performance uniformly |
| **Trajectory** | 4th | Wrong direction compounds errors |

## Context Window Equation

```
Quality = (Correctness × Completeness) / (Noise × Trajectory_Error)
```

Or more simply: **Correct and complete context, minimally sized, pointing the right direction.**

## What Eats Context

- Searching for files (`Glob`, `Grep`)
- Understanding code flow (many `Read` calls)
- Applying edits (diffs in context)
- Test/build logs (large output blocks)
- Huge JSON blobs from tools

## Compaction Strategy

### Intentional Compaction

Pause work and distill into structured artifacts:

```markdown
## Current Status
- **Goal**: [what we're trying to do]
- **Approach**: [how we're doing it]
- **Completed**: [what's done]
- **Current blocker**: [what's failing]
- **Key files**: [file:line references]
```

### Frequent Intentional Compaction

Design entire workflow around context management:
- Keep utilization at 40-60%
- Compact at phase boundaries
- Use subagents for exploration
- Start fresh sessions rather than continuing bloated ones

## Subagents for Context Control

Subagents are not about anthropomorphized roles. They are about **context control**.

**Pattern**: Use fresh context window for finding/searching/summarizing.

```
Parent: "Find how auth works in this codebase"
  ↓
Subagent: [Fresh context] Explores, searches, reads
  ↓
Subagent returns: Distilled findings
  ↓
Parent: Continues with clean context + findings
```

## Progressive Disclosure

Don't tell the AI everything you might want it to know. Tell it **how to find** important information.

```markdown
# CLAUDE.md (minimal)

For specific topics, read from `docs/`:
- `docs/auth.md` — Authentication flows
- `docs/database.md` — Schema and queries
- `docs/testing.md` — How to run tests
```

## File References vs Snippets

| Approach | When to Use |
|----------|-------------|
| `file:line` references | Always preferred — authoritative |
| Code snippets | Only for small, stable examples |
| Full file content | When file is small and central |

Snippets become stale. File references are always current.

## Related

- [[ai-engineering]] — Weekly-updated hub
- [[advanced-context-engineering]] — Comprehensive guide
- [[frequent-intentional-compaction]] — Workflow pattern
- [[subagent-pattern]] — Context isolation technique
- [[progressive-disclosure]] — Information architecture

## Resources

- [12-Factor Agents](https://hlyr.dev/12fa) — HumanLayer
- [Context is Everything](https://www.humanlayer.dev/blog/advanced-context-engineering) — Dex
