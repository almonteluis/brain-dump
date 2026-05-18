---
description: @kloss_xyz prompt for autonomous coding agent execution — batch approvals, error self-fix, scope boundaries, minimal commentary
tags: ["source", "claude-code", "prompt-engineering", "agent-patterns", "workflow"]
sources: ["Thread by @kloss_xyz.md"]
created: 2026-04-17
updated: 2026-04-17
---

# Coding Agent Batch Execution Prompt

**Source:** `raw/Thread by @kloss_xyz.md`
**Date ingested:** 2026-04-17
**Type:** Twitter thread / prompt template

## Summary

@kloss_xyz's prompt template for turning any coding agent (Claude Code, Codex) into an autonomous execution machine that processes plans in batched slices without stopping.

## The Prompt Template

```
cook through the entire plan we've made and all task files
(source of truth: [filenames] in [repository name])
in batched slices, minimal commentary,
do not stop unless you are missing approvals
(group and request all approvals needed upfront for
upcoming independent decisions so I can review and approve now),
only pause for new high/medium risk decisions
(new dependencies, changed interfaces, scope outside designated files)
or blockers,
fix errors in place and only escalate if blocked after two attempts,
surgically appending and only making minimal inline corrective updates
where required for accuracy (no rewrites or restructuring),
verify build/types pass per batch where applicable,
do not modify files outside of [scope boundary] unless required
to fix build/type errors,
default to forward progress without asking unless blocked,
commit/push per completed task or tightly related batch,
if context window is getting long briefly summarize progress
and open items then continue,
when all tasks are complete provide a final summary
of what was shipped, what's pending, and what needs input
```

## Key Patterns

1. **Batch approvals upfront** — Group all independent decisions for single review
2. **Two-attempt error fix** — Fix in place, escalate only if blocked twice
3. **Scope boundary enforcement** — No modifications outside designated area
4. **Build verification per batch** — Verify types/build after each slice
5. **Context window management** — Summarize and continue when getting long
6. **Final summary** — Shipped, pending, needs input

## Concepts Covered

- [[workflows]] — Power user workflows
- [[claude-code-power-user-patterns]] — Advanced patterns

## Related

- [[workflows]] — Claude Code power user workflows
- [[claude-code-power-user-patterns]] — Advanced patterns and hooks
