---
description: "Frequent intentional compaction" workflow for AI coding agents in complex codebases
tags: ["ai-engineering", "context-management", "workflow", "humanlayer"]
sources: ["Advanced Context Engineering for Coding Agents.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Advanced Context Engineering for Coding Agents

**Source:** Advanced Context Engineering for Coding Agents.md (raw, deleted)
**Author:** [[Dex]] (HumanLayer)
**Date ingested:** 2026-04-09
**Type:** Technical guide

## Summary

A workflow for getting AI coding agents to solve hard problems in complex, brownfield codebases. Built on "frequent intentional compaction" — designing your entire development process around context management. Used to ship 35k LOC to BAML (300k LOC Rust) in 7 hours.

## Key Claims

- AI coding tools struggle with production codebases due to context window limitations, not model intelligence
- **Frequent intentional compaction**: Keep context utilization at 40-60% by designing workflow around context management
- **Research → Plan → Implement** workflow outperforms vibe coding for complex tasks
- Subagents are for context control, not anthropomorphized roles
- Human review should focus on research and plans (high leverage), not lines of code

## Core Techniques

### 1. Intentional Compaction

Distill context into structured artifacts when utilization gets high:

```markdown
## Current Status
- Goal: [what we're trying to do]
- Approach: [how we're doing it]
- Completed: [what's done]
- Current failure: [what's blocking]
```

### 2. Research → Plan → Implement

| Phase | Purpose | Output |
|-------|---------|--------|
| Research | Understand codebase, relevant files, information flow | Research document |
| Plan | Outline exact steps, files to edit, testing strategy | Implementation plan |
| Implement | Execute plan phase by phase | Working code |

### 3. Subagent Pattern

Use fresh context windows for finding/searching/summarizing:
- Parent agent gets distilled findings
- Child agent does the exploration
- Avoids polluting main context with `Glob`/`Grep`/`Read` calls

### 4. Context Window Optimization

Optimize for (in order):
1. **Correctness** — Incorrect information is worst
2. **Completeness** — Missing information second worst
3. **Size** — Noise degrades performance

## Real Results

- **BAML bug fix**: 1 hour to PR in 300k LOC Rust codebase (amateur Rust dev)
- **BAML features**: 35k LOC for cancellation + WASM support in 7 hours
- **Team productivity**: 6 PRs in a day, $12k/month on Opus for 3-person team

## When It Fails

- Research doesn't go deep enough through dependency trees
- No domain expert on the codebase
- Assumes classes can be moved without introducing nested dependencies

## Hierarchy of Leverage

```
Bad research → Bad plan → Bad code
     ↑              ↑          ↑
  10x impact    100x impact  1x impact
```

Focus human review on research and plans, not code.

## Related

- [[context-engineering]] — Core concepts and patterns
- [[frequent-intentional-compaction]] — Context management technique
- [[spec-driven-development]] — Sean Grove's approach
- [[ralph-wiggum-pattern]] — Geoff Huntley's while-loop agent

## Entities

- [[humanlayer-ai-agent-patterns]] — AI agent framework
- [[Dex]] — Author, HumanLayer founder
- [[BAML]] — 300k LOC Rust LLM programming language
- [[BoundaryML]] — BAML maintainers

## Resources

- Original article: https://www.humanlayer.dev/blog/advanced-context-engineering
- Research prompt: https://github.com/humanlayer/humanlayer/blob/main/.claude/commands/research_codebase.md
- Plan prompt: https://github.com/humanlayer/humanlayer/blob/main/.claude/commands/create_plan.md
- Implement prompt: https://github.com/humanlayer/humanlayer/blob/main/.claude/commands/implement_plan.md
