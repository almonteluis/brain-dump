---
description: Weekly-updated hub for AI-assisted software engineering workflows, patterns, and tools
tags: ["ai-engineering", "workflow", "claude-code", "context-engineering", "weekly-review"]
created: 2026-04-09
updated: 2026-04-09
---

# AI Engineering

> **Weekly Review Page** — Last updated: 2026-04-09
> Update this page as new patterns, tools, and workflows emerge.

AI-assisted software engineering: using LLMs as coding partners, designing workflows around context management, and maintaining code quality at scale.

## Core Workflows

### Research → Plan → Implement

The three-phase workflow for complex tasks ([[advanced-context-engineering]]):

1. **Research** — Understand codebase, relevant files, information flow
2. **Plan** — Outline exact steps, files to edit, testing strategy
3. **Implement** — Execute plan phase by phase

**Key insight**: Human review focuses on research and plans (10x leverage), not code (1x leverage).

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

## Tools & Patterns

### Claude Code Patterns

- [[writing-good-claude-md]] — Keep instructions minimal and universal
- [[progressive-disclosure]] — Task-specific docs in separate files
- [[subagent-pattern]] — Fresh contexts for exploration
- [[skill-pattern]] — Reusable command definitions

### AI Coding Agents

| Approach | Best For | Key Tool |
|----------|----------|----------|
| Research/Plan/Implement | Complex features, brownfield | Claude Code |
| Ralph Wiggum Pattern | Exploration, continuous runs | `@sourcegraph/amp` |
| Spec-driven | Team alignment, large PRs | Markdown specs |
| Vibe coding | Prototyping, greenfield | Chat interfaces |

### Quality Maintenance

- **No useEffect rule** ([[why-we-banned-useeffect]]) — Force declarative patterns
- **Linter over LLM** — Never use AI for formatting
- **Specs as source** — Review plans, not lines of code
- **Health checks** — Monthly wiki audits

## Weekly Update Checklist

Each week, review and update:

- [ ] New tools or MCP servers worth adding
- [ ] Workflow adjustments based on recent projects
- [ ] Pattern effectiveness (what's working/not working)
- [ ] Links to new source materials in wiki/sources/
- [ ] Cost/token usage tracking

## Current Tool Stack

- **Claude Code** — Primary coding agent
- **agent-browser** — Web scraping for knowledge base
- **skills** — Reusable command patterns
- **hooks** — Automated workflows (lint, test)
- **worktrees** — Isolated feature branches

## Metrics to Track

- PRs per day/week
- Lines of code vs lines of spec
- Time from issue to merged PR
- Rework rate (reverts, follow-up fixes)
- Context window utilization
- Token spend per feature

## Resources

### Must-Read

- [[advanced-context-engineering]] — Dex's comprehensive guide
- [[writing-good-claude-md]] — Kyle's CLAUDE.md best practices
- [[12-factor-agents]] — HumanLayer agent design

### References

- [HumanLayer Blog](https://www.humanlayer.dev/blog)
- [Claude Code Docs](https://code.claude.com/docs)
- [AI That Works Podcast](https://github.com/ai-that-works/ai-that-works)

## Related Concepts

- [[context-engineering]] — Core principles
- [[frequent-intentional-compaction]] — Context management technique
- [[spec-driven-development]] — Sean Grove's approach
- [[second-brain-pattern]] — Knowledge management

## Update History

| Date | Updates |
|------|---------|
| 2026-04-09 | Initial page created with current workflow patterns |

---

*Next review: 2026-04-16*
