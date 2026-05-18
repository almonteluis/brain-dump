---
description: Context Engineering — designing what goes into an LLM's context window. The only lever you have to affect output quality (without training) is input quality.
tags:
  - ai/engineering
  - context/window
  - llm
  - prompt-engineering
created: 2026-04-09
updated: 2026-05-17
---

# Context Engineering

LLMs are stateless functions. Context goes in, next step comes out. The only lever you have to affect output quality — without retraining — is what you put in the context window. That's context engineering: structuring and managing the input so the output doesn't suck.

## The Four Dimensions (In Priority Order)

| Dimension | Priority | What happens when you get it wrong |
|-----------|----------|-------------------------------------|
| **Correctness** | 1st | Wrong information → wrong outputs |
| **Completeness** | 2nd | Missing information → guesses |
| **Size** | 3rd | Noise degrades performance uniformly |
| **Trajectory** | 4th | Wrong direction compounds errors |

The equation: `Quality = (Correctness × Completeness) / (Noise × Trajectory_Error)`. Or more simply: **correct and complete context, minimally sized, pointing the right direction.**

## What Eats Context

- Searching for files (`Glob`, `Grep`)
- Understanding code flow (many `Read` calls)
- Applying edits (diffs pile up)
- Test/build logs (large output blocks)
- Huge JSON blobs from tools

Every search result that stays in context is a tax on every future turn.

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
Design your whole workflow around context management:
- Keep utilization at 40-60%
- Compact at phase boundaries
- Use subagents for exploration (fresh context windows)
- Start fresh sessions rather than continuing bloated ones

## Subagents for Context Control

Subagents aren't about anthropomorphized roles. They're about **context control** — spin up a fresh window for finding/searching/summarizing, get back distilled findings, keep the parent clean.

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

Don't tell the AI everything you might want it to know. Tell it **how to find** important information. This is [[progressive-disclosure]] applied to context windows:

```markdown
# CLAUDE.md (minimal)
For specific topics, read from `docs/`:
- `docs/auth.md` — Authentication flows
- `docs/database.md` — Schema and queries
```

## File References vs Snippets

| Approach | When to Use |
|----------|-------------|
| `file:line` references | Always preferred — authoritative |
| Code snippets | Only for small, stable examples |
| Full file content | When file is small and central |

Snippets go stale. File references are always current. Trust the source, not the copy.

## Code Review as Context Bottleneck (2026-05-17)

From [[My thoughts shipping faster code]]: The biggest blocker isn't development — it's code review. PRs sit for 2-3 days waiting for approval. The feedback loop is vicious: bigger PR → longer review wait → more procrastination on cleanup → even bigger PR when it finally lands. Shorter PRs get reviewed faster, which means smaller diffs ship faster, which reinforces writing smaller diffs.

This is a context-engineering problem in disguise. The reviewer's context window is the bottleneck. A 50-line PR can be reviewed in one pass — the reviewer loads it, reads it, approves. A 500-line PR requires multiple passes, mental state reconstruction between sessions, and usually a round of "let me re-read what this file was doing." The review delay compounds because the reviewer is fighting their own context limits.

The principle: **design your PRs for the reviewer's context window, not your own.** Ship the smallest coherent diff that makes sense on its own. This is the same "minimize context tax" principle from the LLM section, applied to human reviewers.

Source: [[My thoughts shipping faster code]]

## Related

- [[ai-engineering]] — Weekly-updated hub
- [[advanced-context-engineering]] — Comprehensive guide
- [[frequent-intentional-compaction]] — Workflow pattern
- [[subagent-pattern]] — Context isolation technique
- [[progressive-disclosure]] — Information architecture
- [[single-priority-anchoring]] — Related filtering principle: reduce decision overhead
