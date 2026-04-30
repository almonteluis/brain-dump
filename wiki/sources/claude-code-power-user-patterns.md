---
description: "Claude Code power user patterns and workflows"
tags: ["source", "claude-code", "ai-coding", "workflows", "productivity"]
sources: ["claude-code-power-user-patterns.md", "frontend-architecture-prompt.md"]
created: 2026-04-08
updated: 2026-04-16
---

# Claude Code Power User Patterns

**Source:** raw/02_reference/tools/claude-code-power-user-patterns.md
**Date ingested:** 2026-04-08
**Type:** Workflow guide

## Summary

Power user patterns from Twitter bookmarks covering Superpowers plugin, PreToolUse memory hooks, plan mode infinite context, security self-review systems, Obsidian workflows, and Flowy planning.

## Key Claims

- Superpowers plugin adds structured phases (design → plan → code → review)
- Plan mode with task creation maintains context between compaction
- PreToolUse hooks enable self-correcting workflows by retrieving relevant memories before each tool use
- Security self-review requires layered approach: CLAUDE.md prompts + automated scanners + pre-commit hooks
- Claude coding effectiveness comes from structured workflows, not just better prompting

## Entities Mentioned

- [[Superpowers Plugin]] — Structured development phases
- [[Claude Code]] — AI coding assistant
- [[Obsidian]] — Knowledge management tool
- [[QMD]] — Fast private vault indexing
- [[Flowy Plugin]] — Visual planning for AI

## Concepts Covered

- [[plan-mode]] — Design phase before coding
- [[pretooluse-hooks]] — Memory retrieval before tool execution
- [[security-self-review]] — Automated security checking
- [[infinite-context]] — Task-based context preservation
- [[obsidian-workflows]] — Research and synthesis patterns

## Security Stack

| Layer | Tool |
|-------|------|
| SAST | semgrep |
| Python | bandit |
| Linting | ruff |
| Types | mypy |
| Dependencies | snyk |
| Secrets | gitleaks |

## The Formula (0xDesigner)

```
"I want [goal/outcome]"
+ "interview me thoroughly to extract ideas and intent"
+ ultrathink
+ (plan mode on)
```

## Workflow Loop

```
Claude writes code
→ CLAUDE.md forces self-review
→ Automated scanners
→ Pre-commit blocks garbage
→ GitHub action reviews PR
```

## 3-Layer CLAUDE.md Architecture

Source: [[frontend-architecture-prompt]]

The community has converged on a layered architecture that pairs advisory instructions with deterministic enforcement:

### Layer 1: Routing Hub (CLAUDE.md)

Keep CLAUDE.md to 10-15 lines that point to other files. Avoid the common failure mode of growing from 30 lines to 400 as every mistake triggers a new rule. Structure:

```
your-project/
├── CLAUDE.md              # 10-15 lines, hub only
├── rules.md               # Hard rules: naming, what to avoid
├── context/
│   ├── architecture.md    # System overview, key decisions
│   └── data-models.md     # Core types and relationships
└── sops/
    └── add-feature.md     # How to add a feature here
```

Key insight: document **rationale** (why decisions were made), not just structure. Rationale is the highest-value content because it prevents well-intentioned suggestions that break design logic.

### Layer 2: Path-Scoped Rules

`.claude/rules/` directory with YAML frontmatter that scopes rules to file patterns. Rules only activate when Claude works on matching files, solving the "priority saturation problem":

```yaml
---
paths:
  - `src/components/**/*.tsx`
---
# React Development Rules
- Use functional components exclusively
- Extract logic into custom hooks
```

Recommended community skills: Vercel React Best Practices (40+ performance rules), Vercel Composition Patterns (compound components over boolean props).

### Layer 3: Deterministic Hooks

CLAUDE.md instructions are advisory. Hooks are deterministic and always run. Most impactful: auto-format on every edit via PostToolUse hooks.

### SOPs Pattern

When Claude does something right, write the steps down in `sops/`. Next session, Claude follows that SOP instead of re-explaining from scratch. The SOPs compound over time.

### Learnings.md Pattern

Start with one CLAUDE.md and one empty learnings.md. Log every correction. After a week, the file catches the ten most common mistakes for your setup.

See [[frontend-architecture-prompt]] for full synthesis and [[writing-good-claude-md]] for foundational principles.

### Related
- [[claude-code-patterns-reddit-synthesis]] — Reddit-sourced patterns for CLAUDE.md layering
- [[10-high-impact-claude-prompts]] — 10 practical prompts for writing, content strategy, SEO
- [[cursor-rules-ai-development]] — Matt Pocock's TypeScript-specific cursor rules
