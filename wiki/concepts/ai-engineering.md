---
description: AI Engineering — weekly-updated hub for AI-assisted software engineering workflows, patterns, and tools. Research → Plan → Implement.
tags:
  - ai/engineering
  - workflow
  - claude/code
  - context/engineering
  - weekly-review
created: 2026-04-09
updated: 2026-05-17
---

# AI Engineering

> **Weekly Review Page** — Last updated: 2026-05-17

AI-assisted software engineering: using LLMs as coding partners, designing workflows around [[context-engineering]], and maintaining code quality at scale.

## Core Workflow: Research → Plan → Implement

The three-phase workflow for complex tasks ([[advanced-context-engineering]]):

1. **Research** — Understand codebase, relevant files, information flow
2. **Plan** — Outline exact steps, files to edit, testing strategy
3. **Implement** — Execute plan phase by phase

The key insight: human review focuses on research and plans (10x leverage), not code (1x leverage). Review the thinking, not the typing.

### Frequent Intentional Compaction

Keep context utilization at 40-60% by designing workflow around context management:
- Compact status to markdown files at phase boundaries
- Use subagents for exploration (fresh context windows)
- Start new sessions rather than continuing bloated ones

## Context Engineering Principles

| Principle | Application |
|-----------|-------------|
| **Correctness** | Verify research before planning |
| **Completeness** | Include file:line references, not snippets |
| **Size** | Keep CLAUDE.md < 60 lines |
| **Trajectory** | Compact before context window fills |

## AI Coding Agents

| Approach | Best For | Key Tool |
|----------|----------|----------|
| Research/Plan/Implement | Complex features, brownfield | [[claude-code]] |
| Ralph Wiggum Pattern | Exploration, continuous runs | `@sourcegraph/amp` |
| Spec-driven | Team alignment, large PRs | Markdown specs |
| Vibe coding | Prototyping, greenfield | Chat interfaces |

## Quality Rules

- **No useEffect rule** ([[why-we-banned-useeffect]]) — force declarative patterns
- **Linter over LLM** — never use AI for formatting
- **Specs as source** — review plans, not lines of code
- **Health checks** — monthly wiki audits

## Current Tool Stack

- **[[claude-code]]** — Primary coding agent
- **agent-browser** — Web scraping for knowledge base
- **skills** — Reusable command patterns
- **hooks** — Automated workflows (lint, test)
- **worktrees** — Isolated feature branches

## Weekly Update Checklist

- [ ] New tools or MCP servers worth adding
- [ ] Workflow adjustments based on recent projects
- [ ] Pattern effectiveness (what's working/not working)
- [ ] Links to new source materials
- [ ] Cost/token usage tracking

## Resources

- [[advanced-context-engineering]] — Dex's comprehensive guide
- [[writing-good-claude-md]] — Kyle's CLAUDE.md best practices
- [[12-factor-agents]] — HumanLayer agent design

## Related

- [[context-engineering]] — Core principles
- [[frequent-intentional-compaction]] — Context management technique
- [[spec-driven-development]] — Sean Grove's approach
- [[second-brain-pattern]] — Knowledge management
