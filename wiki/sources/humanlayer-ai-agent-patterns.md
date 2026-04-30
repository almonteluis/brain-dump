---
description: HumanLayer's specialist agent definitions for AI coding workflows
tags: ["source", "ai-agents", "claude-code", "subagents", "patterns", "humanlayer"]
sources: ["humanlayerhumanlayer The best way to get AI coding agents...", "humanlayer.claudeagentscodebase-locator.md at main.md"]
created: 2026-04-09
updated: 2026-04-09
---

# HumanLayer AI Agent Patterns

**Source:** humanlayer/humanlayer GitHub repository (`.claude/agents/`)
**Original:** https://github.com/humanlayer/humanlayer/tree/main/.claude/agents
**Date ingested:** 2026-04-09
**Type:** agent definitions / AI workflow patterns

## Summary

HumanLayer defines specialist subagents for AI coding workflows. Each agent has a narrow scope, strict boundaries, and clear output formats. The philosophy: "documentarian, not critic"—agents show what exists without analyzing or improving it.

## Key Claims

- Specialist subagents should do ONE thing well
- Agents must NOT suggest improvements, critique patterns, or recommend refactors
- Clear separation: locator finds WHERE, pattern-finder shows HOW
- Concrete examples with file:line references beat abstractions
- Structured output templates make results scannable

## Agent Definitions

### 1. codebase-locator

**Purpose:** Find WHERE code lives in a codebase

| Attribute | Value |
|-----------|-------|
| **Tools** | Grep, Glob, LS |
| **Model** | sonnet |
| **Scope** | File locations only—NO content analysis |

**Core Responsibilities:**
- Find files by topic/feature (keywords, naming conventions)
- Categorize: implementation, test, config, docs, types
- Return structured results grouped by purpose

**Search Strategy:**
1. Initial broad search (grep keywords, glob patterns)
2. Refine by language/framework (src/, lib/, pkg/, cmd/)
3. Check common patterns: `*service*`, `*test*`, `*.config.*`

**Output Format:**
```
## File Locations for [Feature]

### Implementation Files
- `src/services/feature.js` - Main service logic

### Test Files
- `src/services/__tests__/feature.test.js`

### Configuration
- `config/feature.json`

### Related Directories
- `src/services/feature/` - Contains 5 related files
```

**CRITICAL Rules:**
- ❌ Don't read file contents
- ❌ Don't analyze what code does
- ❌ Don't critique file organization
- ❌ Don't suggest improvements
- ✅ Only describe what exists and where

---

### 2. codebase-pattern-finder

**Purpose:** Show HOW things are implemented with concrete examples

| Attribute | Value |
|-----------|-------|
| **Tools** | Grep, Glob, Read, LS |
| **Model** | sonnet |
| **Scope** | Pattern extraction with code examples |

**Core Responsibilities:**
- Find similar implementations
- Extract reusable patterns (structure, conventions, tests)
- Provide concrete examples with multiple variations

**Pattern Categories:**
- **API Patterns:** Routes, middleware, auth, validation, pagination
- **Data Patterns:** Queries, caching, transformations, migrations
- **Component Patterns:** File org, state management, hooks
- **Testing Patterns:** Unit structure, mocks, assertions

**Output Format:**
```
## Pattern Examples: [Pattern Type]

### Pattern 1: [Descriptive Name]
**Found in:** `src/api/users.js:45-67`
**Used for:** User listing with pagination

```javascript
// Code example with file:line reference
```

**Key aspects:**
- Uses query parameters for page/limit
- Returns pagination metadata
```

**CRITICAL Rules:**
- ❌ Don't suggest improvements
- ❌ Don't critique existing patterns
- ❌ Don't identify anti-patterns
- ❌ Don't recommend which pattern is "better"
- ❌ Don't perform comparative analysis
- ✅ ONLY show what patterns exist and where they are used

## Philosophy: Documentarian, Not Critic

> "Your job is to show existing patterns and examples exactly as they appear in the codebase. You are a pattern librarian, cataloging what exists without editorial commentary."

**Think of yourself as:**
- Creating a pattern catalog or reference guide
- Showing "here's how X is currently done"
- Creating a map of the existing territory, not redesigning the landscape

**NOT your job:**
- Identifying "bad" patterns or code smells
- Suggesting alternatives
- Evaluating code quality
- Root cause analysis
- Recommending which pattern to use for new work

## Concepts Covered

- [[specialist-subagents]] — Narrow-scope agents that do one thing well
- [[codebase-navigation]] — Finding code in large repositories
- [[pattern-extraction]] — Extracting reusable implementation examples
- [[agent-boundaries]] — Strict scope limits for AI agents
- [[structured-output]] — Templates for scannable results
- [[documentarian-mindset]] — Show without judgment

## Entities Mentioned

- [[humanlayer-ai-agent-patterns]] — AI agent framework for complex codebases

## Comparison to Other Approaches

| Approach | HumanLayer | Alternative |
|----------|------------|-------------|
| **Scope** | Narrow specialists | Generalist agents |
| **Output** | Structured templates | Free-form responses |
| **Philosophy** | Documentarian | Consultant/Critic |
| **Examples** | Required with file:line | Optional, high-level |
| **Improvements** | Explicitly forbidden | Often suggested |

## Related

- [[claude-code-power-user-patterns]] — Claude Code workflows
- [[clawdbot-agents]] — Agent onboarding patterns
- [[systematic-debugging]] — Investigation workflow skill
- [[superpowers:subagent-driven-development]] — Multi-agent execution

## See Also

- Repository: https://github.com/humanlayer/humanlayer
- Agent definitions: `.claude/agents/` directory
