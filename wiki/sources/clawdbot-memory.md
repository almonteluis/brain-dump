---
description: "Long-term memory system"
tags: [clawdbot, memory, long-term-memory, qmd, sub-agents, relay, vault]
sources: [clawdbot/MEMORY.md]
created: 2026-04-09
updated: 2026-04-09
---

# MEMORY.md - Your Long-Term Memory

**Source:** raw/02_reference/tools/clawdbot/MEMORY.md
**Date ingested:** 2026-04-09
**Type:** memory log

## Summary

Curated long-term memory for Clawdbot (Levi). Contains system configuration, learned patterns, and significant events. Distilled essence, not raw logs.

## System Configuration

### QMD - Local Document Search Engine

**Installed:** 2026-01-31
**Location:** `/home/ubuntu/.bun/bin/qmd`
**Index:** `~/.cache/qmd/index.sqlite`
**Models:** Auto-downloaded to `~/.cache/qmd/models/`

**Collections:**
- `obsidian` — `/home/ubuntu/clawd/obsidian-vault/**/*.md` (628 files)

**Search Modes:**
```bash
qmd search "query"              # BM25 full-text search
qmd vsearch "query"             # Vector semantic search
qmd query "query"               # Hybrid + reranking (best quality)
```

**Current Status (2026-02-01):**
- 628 docs indexed
- Embeddings in progress: ~32-52%
- BM25 search works immediately
- Hybrid/semantic search available after embeddings complete

### Sub-Agent Workflow Patterns

**Established:** 2026-02-01
**Purpose:** Parallel task execution for documentation updates

**Workflow:**
1. **Main session** identifies batch of related tasks
2. **Spawn sub-agents** in parallel using `sessions_spawn`
3. **Each agent** gets clear instructions and template
4. **Agents complete independently** and report back
5. **Main session** synthesizes results

**Proven Effective For:**
- YAML frontmatter fixes across large file sets
- Documentation imports and restructuring
- Vault-wide audits and tagging
- Testing and validation workflows

### Relay Documentation - Knowledge Base Expansion

**Strategy:** Fragments-focused → Full Relay coverage

**Accomplished (2026-02-01):**
- ✅ Imported official Relay docs from relay.dev
- ✅ Created comprehensive guides:
  - relay-mutations-guide.md
  - relay-subscriptions-guide.md
  - relay-environment-setup.md
  - connection-pattern-pagination.md
  - relay-compiler-build-setup.md
- ✅ Fixed YAML frontmatter across all Relay notes
- ✅ Created 5-phase stress testing plan

**Relay Knowledge Base Now Covers:**
- Core concepts (data masking, fragment composition)
- Query patterns (refactoring, colocation, keys)
- Mutations (useMutation, optimistic updates)
- Subscriptions (useSubscription, WebSockets)
- Environment setup and configuration
- Connection pattern and pagination
- Compiler configuration

### Obsidian Vault Location

**Root Path:** `/home/ubuntu/clawd/obsidian-vault/`
**Active Notebook:** `Software Engineering Notebook/`

**Vault Operating System (PARA-style):**
- **00_inbox** — Capture first, zero friction
- **01_thinking** — Your synthesis and new ideas
- **02_reference** — External knowledge, tools, patterns
- **03_creating** — Work in progress
- **04_published** — Finished, shareable content
- **05_archive** — Inactive but kept content
- **06_system** — Templates, scripts, automation

## Claude Code Hooks & Vault Automation

**Project Hooks:** `~/.claude/projects/obsidian-vault/hooks.json`

**What hooks do:**
- **SessionStart:** Run vault tree generator
- **PreToolUse:** Check YAML descriptions, ensure frontmatter
- **PostToolUse:** Notify on CLAUDE.md updates
- **Stop:** Optional vault health check

**Vault Operations Script:** `06_system/vault-ops.sh`

Commands:
```bash
./06_system/vault-ops.sh tree              # Layer 1: Show vault structure
./06_system/vault-ops.sh find "claim"      # Layer 2: Search by description
./06_system/vault-ops.sh outline [note]    # Layer 3: Show note headings
./06_system/vault-ops.sh process           # List #to-process items
./06_system/vault-ops.sh orphans           # Find notes with no links
./06_system/vault-ops.sh broken            # Find broken wiki-links
./06_system/vault-ops.sh validate          # Check YAML frontmatter
```

## Session: 2026-01-27 (Performance Optimization)

### Work Completed

**Tiny Homes Project - Performance Optimization**

**Task 1: React.memo Optimization** ✅ COMPLETE
- Branch: `feat/performance-optimization`
- Model: GLM-4.7 (via z.ai)
- Added `React.memo` to BudgetCard components
- Build passes (TypeScript compilation)
- Commit: `0dce93c perf: add React.memo to BudgetCard components`

### Z.AI Integration

- API Key configured for Claude Code
- Base URL: `https://api.z.ai/api/anthropic`
- Model: GLM-4.7
- Cost-effective: 1/7th price of Anthropic with 3x usage quota

### Lessons Learned

**What Worked Well:**
- ✅ Direct terminal access to Claude Code gave full control
- ✅ z.ai GLM-4.7 model is fast and cost-effective
- ✅ Everything-claude-code plugin installed successfully

**What Didn't Work:**
- ❌ everything-claude-code `/plan` command — Too slow (~8-10 minutes)
- ❌ Bash command transmission issues
- ❌ Session restarts — TMUX unreliable

**Recommendations:**
1. Skip `/plan` for complex tasks — implement directly
2. Use simple, direct commands
3. Z.ai model is solid — GLM-4.7 performs well
4. Commit frequently — one task per commit

## Concepts Covered

- [[Long-Term Memory]] — Curated knowledge persistence
- [[QMD]] — Local document search
- [[Sub-Agent Workflows]] — Parallel task execution
- [[Relay Documentation]] — Knowledge base expansion
- [[Vault Automation]] — Hooks and scripts

## Related

- [[clawdbot-heartbeat]]
- [[clawdbot-agents]]
- [[qmd]]
- [[relay-overview]]
