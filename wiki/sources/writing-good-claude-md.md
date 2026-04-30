---
description: Best practices for writing effective CLAUDE.md configuration files
tags: ["claude-code", "context-engineering", "configuration", "best-practices"]
sources: ["Writing a good CLAUDE.md"]
created: 2026-04-09
updated: 2026-04-16
---

# Writing a Good CLAUDE.md

**Source:** Writing a good CLAUDE.md (raw, deleted)
**Author:** [[Kyle]] (HumanLayer)
**Date ingested:** 2026-04-09
**Type:** Best practices guide

## Summary

`CLAUDE.md` is the highest-leverage configuration point for Claude Code. It goes into *every single conversation*, so its contents must be universally applicable, concise, and carefully crafted. Poor instructions here affect every artifact produced by the agent.

## Key Principles

### 1. LLMs Are Stateless

- Coding agents know nothing about your codebase at session start
- `CLAUDE.md` is the default onboarding mechanism
- Claude may ignore contents if not relevant to current task (system reminder wrapper)

### 2. Less Is More

- **~150-200 instructions** is what frontier thinking models can follow reliably
- Claude Code's system prompt already contains ~50 instructions
- Instruction-following quality degrades uniformly as count increases
- **Recommendation**: < 300 lines, ideally < 60 lines

### 3. Universal Applicability

Only include instructions that apply to *all* tasks:
- ✓ Tech stack, project structure, testing commands
- ✗ Database schema details, specific component patterns

## Recommended Structure

```markdown
# [Project Name]

## What
Tech stack, project structure, what each major component does

## Why
Purpose of the project, architectural decisions

## How
- How to run tests
- How to verify changes
- Key commands (be selective)
```

## Progressive Disclosure

Keep task-specific instructions in separate files:

```
agent_docs/
├── building_the_project.md
├── running_tests.md
├── code_conventions.md
├── service_architecture.md
└── database_schema.md
```

Reference them in CLAUDE.md:
> "For specific tasks, read relevant files from `agent_docs/`. Ask which files you want to read before proceeding."

## Anti-Patterns

| ❌ Don't | ✅ Do Instead |
|----------|---------------|
| Code style guidelines | Use linters/formatters (Biome) |
| Auto-generate CLAUDE.md | Craft carefully by hand |
| Include 50+ commands | Include 5-10 essential commands |
| Task-specific instructions | Use progressive disclosure |
| Code snippets | Use `file:line` references |

## HumanLayer Example

```markdown
# HumanLayer

TypeScript monorepo for AI agent controls.

## Structure
- `humanlayer/` — Python SDK
- `sdks/ts/` — TypeScript SDK
- `hld/` — Daemon for local dev

## Commands
- `make test` — Run all tests
- `make lint` — Run Biome
- `make build` — Build all packages

## Conventions
- Use `tsx` for scripts
- Prefer `bun` over `node` where possible
```

**Result**: Less than 60 lines.

## Claude Is Not a Linter

- Use deterministic tools for deterministic tasks
- Set up `Stop` hooks to run formatter/linter
- Use Slash Commands for code review with style guidelines
- LLMs are slow and expensive compared to linters

## Community Validation: Karpathy CLAUDE.md (15K Stars)

A CLAUDE.md file derived from Andrej Karpathy's coding rules reached 15K GitHub stars in April 2026, validating the core principles above. The file addresses the same predictable LLM mistakes this guide warns against: over-engineering, ignoring existing patterns, and adding unnecessary dependencies. Since the mistakes are predictable, they can be prevented with structured instructions — exactly the approach recommended here. See [[karpathy-claude-md-stars]] for full details.

Key takeaway: a well-crafted CLAUDE.md reduces "wrong architecture" suggestions by roughly 70% (reported by a Cars24 principal engineer).

## TypeScript-Specific Rules: Matt Pocock's Cursor Rules

Matt Pocock (TotalTypeScript) published framework-agnostic TypeScript cursor rules that complement CLAUDE.md best practices. His rules cover:

- **Language features**: `as const` over enums, `import type` over `import { type }`, `readonly` properties
- **Code structure**: `Result` over `try/catch`, discriminated unions, explicit return types on top-level functions
- **Documentation**: Prompting the AI to use JSDoc comments effectively
- **Library usage**: Install packages via CLI instead of manually editing `package.json`

He distinguishes workspace rules (versioned, project-specific) from global rules (personal IDE preferences). See [[cursor-rules-ai-development]] for full details.

## Related

- [[claude-md]] — Concept page with templates
- [[progressive-disclosure]] — Pattern for context management
- [[context-engineering]] — Core principles
- [[12-factor-agents]] — Agent design patterns
- [[karpathy-claude-md-stars]] — Community validation of CLAUDE.md approach
- [[cursor-rules-ai-development]] — TypeScript-specific cursor rules by Matt Pocock
- [[frontend-architecture-prompt]] — 3-layer CLAUDE.md architecture

## Entities

- [[Kyle]] — Author, HumanLayer
- [[Anthropic]] — Claude Code team
- [[humanlayer-ai-agent-patterns]] — AI agent framework
- [[Matt Pocock]] — TotalTypeScript, cursor rules author
- [[andrej-karpathy|Andrej Karpathy]] — Coding rules that inspired viral CLAUDE.md

## Resources

- Original: https://www.humanlayer.dev/blog/writing-a-good-claude-md
- 12-Factor Agents: https://hlyr.dev/12fa
- Claude Code docs: https://code.claude.com/docs
- Cursor Rules: https://www.totaltypescript.com/cursor-rules-for-better-ai-development
