---
description: Jack Culpan's Claude Code workflow orchestration prompt — plan mode defaults, subagent strategy, self-improvement loop, verification
tags:
  - source
  - claude/code
  - prompt-engineering
  - workflow
  - agent/patterns
sources:
  - Thread by @JackCulpan.md
created: 2026-04-17
updated: 2026-04-17
---

# Workflow Orchestration Prompt

**Source:** `raw/Thread by @JackCulpan.md`
**Date ingested:** 2026-04-17
**Type:** Twitter thread / prompt template

## Summary

Jack Culpan's comprehensive Claude Code orchestration prompt covering plan mode, subagent strategy, self-improvement loops, and verification before completion.

## The Four Pillars

### 1. Plan Mode Default
- Enter plan mode for ANY non-trivial task (3+ steps or architectural decisions)
- If something goes sideways, STOP and re-plan immediately
- Use plan mode for verification steps, not just building
- Write detailed specs upfront to reduce ambiguity

### 2. Subagent Strategy
- Use subagents liberally to keep main context window clean
- Offload research, exploration, and parallel analysis to subagents
- For complex problems, throw more compute at it via subagents
- One task per subagent for focused execution

### 3. Self-Improvement Loop
- After ANY correction: update `tasks/lessons.md` with the pattern
- Write rules that prevent the same mistake
- Ruthlessly iterate on lessons until mistake rate drops
- Review lessons at session start for relevant project

### 4. Verification Before Done
- Never mark a task complete without proving it works
- Run tests, check builds, verify functionality

## Concepts Covered

- [[workflows]] — Power user workflows
- [[claude-code-power-user-patterns]] — Subagent patterns

## Related

- [[coding-agent-batch-prompt]] — @kloss_xyz batch execution prompt
- [[claude-code-power-user-patterns]] — Advanced patterns
