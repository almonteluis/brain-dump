---
description: 3-layer CLAUDE.md architecture for frontend enforcement — routing hub, path-scoped rules, and deterministic hooks
tags:
  - claude/code
  - frontend
  - architecture
  - best-practices
sources:
  - Frontend architecture prompt.md
created: 2026-04-16
updated: 2026-04-16
---

# Frontend Architecture: 3-Layer CLAUDE.md System

**Source:** [[Frontend architecture prompt]]
**Date ingested:** 2026-04-16
**Type:** Community synthesis

## Summary

A comprehensive community synthesis from Reddit (r/ClaudeCode, r/ClaudeAI, r/ExperiencedDevs), blog posts, and Anthropic's official docs that converges on a 3-layer architecture for enforcing frontend patterns in Claude Code. The system pairs advisory instructions (CLAUDE.md) with deterministic enforcement (hooks), solving the common failure mode of CLAUDE.md files that grow from 30 lines to 400 as every mistake triggers a new rule.

The three layers are: (1) a minimal routing hub CLAUDE.md (10-15 lines), (2) path-scoped rules in `.claude/rules/` that activate only for relevant file patterns, and (3) PostToolUse hooks for deterministic enforcement like auto-formatting. The key insight is that rationale documentation is the highest-value content — explaining *why* a decision was made prevents well-intentioned suggestions that break established patterns.

## Key Claims

- CLAUDE.md files commonly bloat from 30 to 400 lines as developers add rules for every mistake
- The routing pattern keeps CLAUDE.md to 10-15 lines, pointing to separate files for rules, context, and SOPs
- Path-scoped rules solve the "priority saturation problem" — too much high-priority content competing for attention
- SOPs compound over time: when Claude does something right, document the steps for reuse
- Rationale (why decisions were made) is more valuable than structure documentation
- A well-crafted CLAUDE.md reduces "wrong architecture" suggestions by roughly 70% (Cars24 principal engineer)
- CLAUDE.md instructions are advisory; hooks are deterministic and always run
- Reference-style prompting ("Analyze my @src/theme and @src/api") forces Claude to read existing patterns before generating

## Concepts Covered

- [[3-layer-claude-md]] — Routing hub + path-scoped rules + deterministic hooks
- [[routing-pattern]] — Minimal CLAUDE.md that points to other files
- [[path-scoped-rules]] — Rules in `.claude/rules/` activated by file pattern matching
- [[sops-pattern]] — Standard Operating Procedures that compound over time
- [[priority-saturation]] — Too much high-priority content equals no priority
- [[rationale-documentation]] — Documenting *why* decisions were made, not just what
- [[reference-style-prompting]] — Pointing Claude at existing code before generating new code
- [[posttooluse-hooks]] — Deterministic enforcement on every file write
- [[learnings-md]] — Logging corrections to catch common mistakes

## Recommended Frontend Skills

- **Vercel React Best Practices** — 40+ performance optimization rules, organized by impact level
- **Vercel Composition Patterns** — Teaches compound components over boolean prop proliferation
- **Custom feature scaffolding** — Per-project skill that scaffolds modules following exact architecture

## Resources

- Synthesized from: Reddit r/ClaudeCode, r/ClaudeAI, r/ExperiencedDevs, blog posts, Anthropic docs
