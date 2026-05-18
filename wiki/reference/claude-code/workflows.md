---
description: Claude Code power user workflows including plan mode, PreToolUse hooks, security self-review, and Obsidian integration patterns
tags:
  - claude/code
  - workflow
  - productivity
  - ai/code
  - reference
created: 2026-04-08
updated: 2026-04-11
sources:
  - claude-code-power-user-patterns.md
  - claude-prompt-prefix-combos.md
  - claude-code-thinking-transparency.md
---

# Claude Code Workflows

Structured workflows for getting the most out of Claude Code.

## Plan Mode Infinite Context

**Method:**
```
> enter plan mode and write tasks
> yes, clear context, bypass permissions
```

New tasks maintain context between compaction, enabling long workflows.

## PreToolUse Memory Hook

**Problem:** Relying only on UserPromptSubmit causes workflow drift.

**Solution:** Hook fires before every tool use, retrieves relevant memories from last 1,500 chars of thinking block.

**Result:** Self-correcting workflow that catches itself mid-stream.

**Files:**
- `HEARTBEAT.md` — Hourly self-check questions
- `memory/self-review.md` — Logged misses and fixes

## Security Self-Review System

### Layer 1: CLAUDE.md Prompts

```markdown
before completing any task, run these checks:
- scan for hardcoded secrets, API keys, passwords
- check for SQL injection, shell injection, path traversal
- verify all user inputs are validated
- run the test suite
- check for type errors
```

### Layer 2: Bug-Catching Prompts

- "Write 20 unit tests designed to break this function"
- "Find every security vulnerability in this file. Think like a pentester."
- "Generate 50 edge cases: null, empty strings, negative numbers, unicode"

### Layer 3: Automated Scanners

| Scanner | Purpose |
|---------|---------|
| semgrep | SAST - OWASP top 10 |
| bandit | Python security |
| ruff | Linting + auto-fix |
| mypy | Type checking |
| snyk | Dependency CVEs |
| gitleaks | Secret detection |

### Layer 4: Pre-commit Hooks

```bash
pip install pre-commit
# Scanners run automatically before commit
```

## The Formula

From 0xDesigner:

```
"I want [goal/outcome]"
+ "interview me thoroughly to extract ideas and intent"
+ ultrathink
+ (plan mode on)
```

## Prompt Prefix Combos

**Source:** [[claude-prompt-prefix-combos]]

Single prompt prefixes adjust Claude in one dimension. Stacking 2-3 prefixes **triangulates** on a specific output shape — Claude can't hedge in any specified dimension.

### Most Useful Combos

| Combo | Use Case | Prefixes |
|-------|----------|----------|
| Slack Message Fixer | Condense frustrated messages | `/punch + /trim + /raw` |
| Expert With Teeth | Technical decisions with failure modes | `PERSONA + L99 + WORSTCASE` |
| Wrong-Question Killer | Challenge premise then deep analysis | `/skeptic + ULTRATHINK` |
| Voice Cloner | Mimic writing style across multiple pieces | `/mirror + /voice + /ghost` |
| Cold Email | Non-AI-sounding outreach | `/ghost + /punch + /voice` |
| Decision Closer | End analysis paralysis | `HARDMODE + /decision-matrix + L99` |
| Incident Commander | Production incident lifecycle | `OODA + WORSTCASE + /postmortem` |

### Why Combos Beat Single Prefixes

**Analogy:** Single prefix = "shoot in portrait mode." Combo = "portrait mode, natural light, candid, no posing, shoot from slightly below." The constraints multiply each other.

## Thinking Transparency and Effort Levels

**Source:** [[claude-code-thinking-transparency]]

Since Feb 2026, Claude Code uses adaptive thinking with a default effort level of 85 (medium). Thinking is hidden from the UI by default.

### Key Settings

| Setting | Purpose |
|---------|---------|
| `showThinkingSummaries: true` | Show thinking in UI (hidden by default since Feb) |
| `CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING` | Disable adaptive thinking, use fixed budgets |
| `/effort high` | High effort (sticky across sessions) |
| `/effort max` | Maximum effort |
| `ULTRATHINK` | Force high effort for single turn |

### When to Increase Effort

- Complex refactoring with many files → `/effort high`
- Production incident analysis → `ULTRATHINK`
- Architecture decisions → `PERSONA + L99 + WORSTCASE` with `/effort high`
- Routine tasks → Default effort=85 is fine

## Obsidian Integration

**For Research:**
1. Populate markdown folder with source material
2. Enter stream-of-consciousness with @usemonologue
3. Ask "what's the idea I'm saying here?"
4. Let Claude help pull threads together
5. Use active recall sections

**QMD Integration:**
- Fast private indexing of vaults
- SQLite + BM25 + local embeddings
- 96% token consumption reduction

## Related

[[claude-code]]
[[obsidian]]
[[security-best-practices]]
[[plan-mode]]
