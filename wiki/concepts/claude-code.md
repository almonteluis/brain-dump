---
description: Hub for Claude Code ecosystem — workflows, patterns, configuration, and plugins
tags: [claude-code, ai-coding, workflows, configuration, concept]
created: 2026-04-30
updated: 2026-04-30
sources: ["claude-code-power-user-patterns", "writing-good-claude-md", "workflows"]
---

# Claude Code

AI coding assistant by Anthropic. Built on Bun. Core pattern: structured workflows transform AI from toy to tool.

## Core Workflows

| Workflow | Page |
|----------|------|
| Power user patterns (Superpowers, PreToolUse hooks, 3-layer CLAUDE.md) | [[claude-code-power-user-patterns]] |
| Plan mode, prompt combos, thinking transparency | [[workflows]] |
| TDD, systematic debugging, security self-review | [[claude-code-patterns-reddit-synthesis]] |
| Adaptive thinking and effort levels | [[claude-code-thinking-transparency]] |

## Configuration

| Topic | Page |
|-------|------|
| Writing effective CLAUDE.md files | [[writing-good-claude-md]] |
| 3-layer architecture (routing hub + path-scoped rules + hooks) | [[frontend-architecture-prompt]] |
| Cursor rules comparison (Matt Pocock's TypeScript rules) | [[cursor-rules-ai-development]] |
| Karpathy-derived CLAUDE.md (15K stars) | [[karpathy-claude-md-stars]] |

## Prompts

| Prompt | Page |
|--------|------|
| 10 high-impact prompts for writing, content, SEO | [[10-high-impact-claude-prompts]] |
| Prompt prefix combos (stacking for triangulated output) | [[claude-prompt-prefix-combos]] |
| 10 AI prompts for workflow optimization | [[10-ai-prompts-workflow]] |
| Batch execution prompt (autonomous multi-hour runs) | [[coding-agent-batch-prompt]] |
| Workflow orchestration prompt (4-pillar) | [[workflow-orchestration-prompt]] |

## Plugins and Extensions

| Plugin | Page |
|--------|------|
| Plugin installation and configuration | [[claude-code-plugins-guide]] |
| Skills catalog and reference | [[claude-code-skills-reference]] |
| Matt Pocock's custom skills (/domain-model, /to-prd, /to-issues) | [[matt-pocock-skill-lineup]] |

## Discussions

| Discussion | Page |
|------------|------|
| Thinking transparency HN thread (Boris Cherny) | [[claude-code-thinking-hn-discussion]] |
| Adaptive thinking under-allocation HN thread | [[claude-code-unusable-hn-discussion]] |
| Source leak analysis (anti-distillation, KAIROS) | [[claude-code-source-leak]] |

## Agent Patterns

| Pattern | Page |
|---------|------|
| HumanLayer specialist subagents | [[humanlayer-ai-agent-patterns]] |
| Agent self-check framework (MISS/FIX logging) | [[agent-self-check-framework]] |
| Resume session skill | [[resume-session-skill]] |
| SessionStart tree injection hook | [[sessionstart-tree-hook]] |

## Related

- [[ai-engineering]] — Weekly hub for AI-assisted software engineering
- [[context-engineering]] — Designing context windows for AI agents
- [[clawdbot-claude]] — Vault operating instructions
- [[obsidian-claude-101]] — Obsidian + Claude Code 101
