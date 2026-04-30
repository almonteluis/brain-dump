---
description: "MCP servers and QMD tools"
tags: [clawdbot, tools, mcp, qmd, saved-resources, quick-reference]
sources: [clawdbot/TOOLS.md]
created: 2026-04-09
updated: 2026-04-09
---

# TOOLS.md - Local Notes

**Source:** raw/02_reference/tools/clawdbot/TOOLS.md
**Date ingested:** 2026-04-09
**Type:** reference

## Summary

Tool-specific notes and configurations for Clawdbot — MCP servers, QMD, saved resources, quick references. Skills define *how* tools work; this file is for *your* specifics.

## What Goes Here

Things like:
- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

## MCP Servers

### Z.ai Vision MCP Server (`zai-mcp-server`)

**Purpose:** Image/video analysis with GLM-4.6V model

**Config:** `~/clawd/config/mcporter.json`

**Key Tools:**
- `ui_to_artifact` — UI → code, prompts, specs, descriptions
- `extract_text_from_screenshot` — OCR (code, terminal, docs)
- `diagnose_error_screenshot` — Error analysis + fixes
- `understand_technical_diagram` — Architecture, flow, UML, ER
- `analyze_data_visualization` — Charts, graphs, dashboards
- `ui_diff_check` — Compare two UIs
- `analyze_image` — General image understanding
- `analyze_video` — Video (≤8MB, MP4/MOV/M4V)

**Usage:**
```bash
mcporter call zai-mcp-server.ui_to_artifact(image_source="path", output_type="code", prompt="...")
mcporter call zai-mcp-server.extract_text_from_screenshot(image_source="path", prompt="...")
```

**Pricing:** 1/7th cost of Sonnet, 3x usage quota

### QMD - Local Document Search

**Purpose:** Search markdown vaults with BM25 + vector embeddings + reranking

**Install Path:** `/home/ubuntu/.bun/bin/qmd`
**Index:** `~/.cache/qmd/index.sqlite`
**Models:** `~/.cache/qmd/models/` (embeddinggemma-300M, qwen3-reranker)

**Quick Reference:**
```bash
export PATH="$HOME/.bun/bin:$PATH"
qmd search "Relay fragments" -c obsidian     # BM25 keyword search
qmd vsearch "how to deploy"                   # Semantic search
qmd query "authentication patterns"            # Hybrid + reranking
qmd status                                   # Check embedding progress
```

**Collections:**
- `obsidian` — Full Software Engineering Notebook (628 files)

**Notes:** BM25 search works immediately. Embeddings take ~1-2 hours to generate for large vaults.

## Saved Resources

> **Location:** All markdown resources moved to `/home/ubuntu/clawd/obsidian-vault/Software Engineering Notebook/` for Obsidian sync

### React Patterns
- **Airbnb React Style Guide (full):** `obsidian-vault/Software Engineering Notebook/airbnb-react-style-guide.md`
- **Quick Reference Summary:** `obsidian-vault/Software Engineering Notebook/airbnb-react-patterns-summary.md`
- **React Bits Index:** `obsidian-vault/Software Engineering Notebook/react-bits-index.md`

**Use for:**
- Component structure and best practices
- Naming conventions and prop handling
- Accessibility guidelines
- Common anti-patterns to avoid

### GraphQL Workshop (ASP.NET Core + Relay)
- **Full Workshop Guide:** `obsidian-vault/Software Engineering Notebook/fullstack-graphql-workshop.md`
- **Detailed Summary:** `obsidian-vault/Software Engineering Notebook/graphql-workshop-summary.md`

**Use for:**
- Hot Chocolate GraphQL server patterns
- DataLoader for N+1 query optimization
- Connection pattern for pagination
- Relay.js client patterns

### Relay Query Refactoring
- **Query Refactoring Guide:** `obsidian-vault/Software Engineering Notebook/relay-query-refactoring-guide.md`

**Use for:**
- Converting multiple `useLazyLoadQuery` to single query + fragments
- Understanding fragment keys and data masking
- Hook comparison (useLazyLoadQuery vs usePreloadedQuery vs useQueryLoader)

### Relay ESLint Rules
- **ESLint Rules Guide:** `obsidian-vault/Software Engineering Notebook/relay-eslint-rules-guide.md`

**Use for:**
- Understanding `relay/unused-fields` rule
- Understanding `relay/must-colocate-fragment-spreads` rule
- Real-world examples showing what triggers errors

## Concepts Covered

- [[MCP Servers]] — Model Context Protocol integrations
- [[QMD]] — Local document search engine
- [[Saved Resources]] — Quick reference locations
- [[Tool Configuration]] — Environment-specific settings

## Related

- [[zai-mcp-vision-server]]
- [[clawdbot-memory]]
- [[relay-overview]]
