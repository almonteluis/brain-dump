---
description: Graphify v0.5.0 — AI coding assistant skill that turns any folder into a queryable knowledge graph
tags:
  - source
  - tool
  - knowledge-graph
  - ai/ml
  - claude/code
source: https://github.com/safishamsi/graphify
author: "[[safi-shamsi]]"
published: 2026-04
created: 2026-04-30
updated: 2026-04-30
---

# Graphify — AI Coding Assistant Skill

An AI coding assistant skill that reads your files, builds a knowledge graph, and gives you back structure you didn't know was there. Supports 15+ AI platforms including Claude Code, Codex, Cursor, Gemini CLI, and more.

## Source

- **URL:** https://github.com/safishamsi/graphify
- **Author:** [[safi-shamsi]]
- **Type:** Open-source tool / GitHub repository
- **Version:** v0.5.0

## What It Does

Type `/graphify` in your AI coding assistant. It reads files, builds a knowledge graph, and surfaces structure:

```
graphify-out/
├── graph.html       # Interactive graph — open in any browser
├── GRAPH_REPORT.md  # God nodes, surprising connections, suggested questions
├── graph.json       # Persistent graph — query weeks later without re-reading
└── cache/           # SHA256 cache — re-runs only process changed files
```

## How It Works

Three-pass pipeline:

1. **AST pass** — Deterministic extraction from code files (classes, functions, imports, call graphs, docstrings, rationale comments). No LLM needed. 25 languages via tree-sitter.
2. **Transcription** — Video/audio transcribed locally with faster-whisper using domain-aware prompts derived from corpus god nodes.
3. **Semantic extraction** — Claude subagents run in parallel over docs, papers, images, and transcripts to extract concepts, relationships, and design rationale.

Results are merged into a NetworkX graph, clustered with **Leiden community detection** (graph-topology-based, no embeddings), and exported as interactive HTML, queryable JSON, and a plain-language audit report.

## Key Features

### Relationship Tagging
Every relationship is tagged:
- **EXTRACTED** — Found directly in source (confidence 1.0)
- **INFERRED** — Reasonable inference with confidence score (0.0-1.0)
- **AMBIGUOUS** — Flagged for review

### Token Efficiency
**71.5x fewer tokens per query** vs reading raw files (on a 52-file mixed corpus of Karpathy repos + papers + images). First run extracts and builds the graph. Every subsequent query reads the compact graph instead.

### Platform Support

| Platform | Install Command |
|----------|----------------|
| Claude Code | `graphify install` |
| Codex | `graphify install --platform codex` |
| Cursor | `graphify cursor install` |
| Gemini CLI | `graphify install --platform gemini` |
| GitHub Copilot CLI | `graphify install --platform copilot` |
| VS Code Copilot Chat | `graphify vscode install` |
| Aider | `graphify install --platform aider` |
| OpenClaw | `graphify install --platform claw` |
| Factory Droid | `graphify install --platform droid` |
| Trae | `graphify install --platform trae` |
| Kiro | `graphify kiro install` |
| Google Antigravity | `graphify antigravity install` |

### Always-On vs Explicit Trigger

- **Always-on hook** — Surfaces `GRAPH_REPORT.md` (one-page summary of god nodes, communities, connections). Assistant reads this before searching files, navigating by structure instead of keyword matching.
- **Explicit commands** — `/graphify query`, `/graphify path`, `/graphify explain` traverse `graph.json` hop by hop for precise navigation.

### v0.5.0 New Features

- **`graphify clone <github-url>`** — Clone any public GitHub repo and run the full pipeline
- **`graphify merge-graphs`** — Combine multiple `graph.json` outputs into one cross-repo graph
- **Shrink guard** — Prevents silent data loss on partial updates
- **Duplicate node deduplication** — Collapses nodes sharing normalized labels
- **`--wiki`** — Build agent-crawlable wiki (index.md + article per community)
- **`--obsidian`** — Generate Obsidian vault output

## What You Get

- **God nodes** — Highest-degree concepts (what everything connects through)
- **Surprising connections** — Ranked by composite score; code-paper edges rank higher than code-code
- **Suggested questions** — 4-5 questions the graph is uniquely positioned to answer
- **The "why"** — Docstrings, inline comments (`# NOTE:`, `# WHY:`), design rationale as `rationale_for` nodes
- **Semantic similarity edges** — Cross-file conceptual links with no structural connection
- **Hyperedges** — Group relationships connecting 3+ nodes
- **Auto-sync** (`--watch`) — Background auto-rebuild on code changes
- **Git hooks** — Post-commit and post-checkout hooks for automatic rebuilds

## Privacy

- Code files processed locally via tree-sitter AST — no file contents leave your machine
- Video/audio transcribed locally with faster-whisper — audio never leaves your machine
- No telemetry, usage tracking, or analytics
- Only network calls are to your platform's model API during extraction, using your own API key

## Tech Stack

NetworkX + Leiden (graspologic) + tree-sitter + vis.js. Semantic extraction via Claude (Claude Code), GPT-4 (Codex), or whichever model your platform runs. No Neo4j required, no server, runs entirely locally.

## Related

- [[graphify-knowledge-graph-tool]] — Previous coverage of graphify
- [[second-brain-graphify-workflow]] — Graphify workflow for this vault
- [[knowledge-graph]] — Knowledge graph concept
- [[llm-wiki-pattern]] — LLM Wiki pattern for knowledge management
- [[how-to-build-second-brain]] — AI-powered knowledge management
- [[claude-code]] — Claude Code ecosystem
