---
description: Reddit-sourced Claude Code patterns: CLAUDE.md layering, path-scoped rules, skills, hooks, and workflow best practices
tags: ["claude-code", "ai-workflow", "claudemd", "context-engineering"]
sources: ["Frontend architecture prompt.md"]
created: 2026-04-10
updated: 2026-04-10
---

# Claude Code Patterns — Reddit Community Synthesis

**Source:** Frontend architecture prompt.md (Reddit synthesis)
**Type:** Community research synthesis
**Date ingested:** 2026-04-10

## Summary

Comprehensive Claude Code patterns gathered from Reddit (r/ClaudeCode, r/ClaudeAI, r/ExperiencedDevs), practitioner blog posts, and Anthropic docs. The community has converged on a **3-layer system**: CLAUDE.md (routing hub) → path-scoped rules/skills (on-demand) → hooks (deterministic enforcement).

## Key Insight: Priority Saturation Problem

> "Starting at 30 lines and ending at 400 — every time Claude does something wrong, someone adds another rule. The file becomes load-bearing and unreadable."

**The fix:** Keep CLAUDE.md under 200 lines (ideally 10-15 lines) as a **routing hub** that points to separate context/sop/rules files.

## The 3-Layer System

### Layer 1: CLAUDE.md — Routing Hub (Not Kitchen Sink)

Target **under 200 lines**, ideally 10-15 lines that only point elsewhere:

```
your-project/
├── CLAUDE.md              # 10-15 lines, hub only
├── rules.md               # Hard rules: naming, what to avoid
├── context/
│   ├── architecture.md    # System overview, key decisions
│   ├── api.md             # External services, auth patterns
│   └── data-models.md     # Core types and relationships
└── sops/
    ├── add-feature.md     # How to add a feature here
    └── graduate-experiment.md  # Your experiment→production flow
```

**What to put in CLAUDE.md:**
- **Rationale** — Why architectural decisions were made (highest-value content)
- **Pointers over copies** — Use `file:line` references, not code snippets
- **Structure map** — Where things live (monorepo apps/packages)

**What NOT to put in CLAUDE.md:**
- Deployment runbooks
- Every command Claude might need
- Code snippets (become stale quickly)
- Task-specific instructions

### Layer 2: Path-Scoped Rules + Skills — Architecture on Demand

`.claude/rules/react-patterns.md`:
```yaml
---
paths:
  - src/components/**/*.tsx
  - src/hooks/**/*.ts
---
# React Development Rules
- Use functional components exclusively
- Extract logic into custom hooks
- Prefer composition over boolean props
- useReducer for complex state orchestration; useState for simple toggles
```

**Recommended skills from community:**
- **Vercel's React Best Practices** — 40+ performance rules
- **Vercel's Composition Patterns** — anti-boolean-proliferation, compound components
- **Custom feature scaffolding skill** — `/rn-feature checkout-flow` scaffolds entire module

### Layer 3: Hooks — Deterministic Enforcement

Auto-formatting on every edit (PostToolUse hook):
```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "jq -r '.tool_input.file_path' | xargs npx prettier --write 2>/dev/null; exit 0"
      }]
    }]
  }
}
```

## Workflow Patterns

### Plan Mode Before Coding
> "Universal advice from r/ClaudeCode: start in Plan Mode (Shift+Tab), describe the feature, let Claude analyze the codebase and propose architecture. Don't let it write code yet."

### Context Management
- Manual `/compact` at max 50% context usage
- `/clear` to reset context mid-session when switching tasks
- Vanilla Claude Code > complex workflows for smaller tasks

### Reference-Style Prompting
Instead of: "build a login page"
```text
Analyze my @src/theme and @src/api. Create a LoginForm component using React Hook Form and Zod for validation.
```

### The "learnings.md" Pattern
Start with one CLAUDE.md and one empty learnings.md. Every time Claude does something wrong and you correct it, log the correction. After a week you'll have a file that catches the ten most common mistakes.

## Key Takeaways

- **Well-crafted CLAUDE.md reduces "wrong architecture" by ~70%** (Cars24 principal engineer)
- **High priority everywhere = priority nowhere** — Path-scoped rules solve this
- **Hooks are deterministic; CLAUDE.md is advisory**
- **Separate procedure from context** — Put process in SKILL.md, context in reference files
- **linting + auto-fix = essential** — Use Biome or similar for safe auto-fixing

## Related

- [[writing-good-claude-md]] — HumanLayer's guide on CLAUDE.md best practices
- [[claude-code-power-user-patterns]] — Superpowers plugin, PreToolUse hooks
- [[context-engineering]] — Designing context windows for AI agents
- [[progressive-disclosure-in-practice]] — Layered information navigation
