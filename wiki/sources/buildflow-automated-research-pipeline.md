---
description: Automated research-to-implementation pipeline using Chrome extension, Telegram bot, and OpenCode agent
tags: [ai-engineering, automation, research, opencode]
sources: ["2026-01-30 - BuildFlow - Automate Research to Implementation.md"]
created: 2026-04-21
updated: 2026-04-21
---

# BuildFlow: Automated Research Pipeline

**Source:** 2026-01-30 - BuildFlow - Automate Research to Implementation.md
**Date ingested:** 2026-04-21
**Type:** Open source project analysis

## Summary

BuildFlow is an open-source system (BowTiedSwan) that automates the full discovery-to-implementation pipeline. It uses a Chrome extension + Telegram bot for multi-channel capture, and OpenCode as the AI engine for research, implementation, testing, and report generation.

## Key Claims

- One-click research pipeline: URL in → working code + tests + report out
- Multi-channel capture: Chrome extension (any website + X/Twitter), Telegram bot
- Custom OpenCode agent optimized for research workflows
- Structured outputs: REPORT.md + src/ + repo/ per research task
- Session-based research builds context over time

## Architecture

```
Capture (Chrome/Twitter/Telegram)
  → Backend (Express + SQLite)
    → OpenCode (custom research agent)
      → Output (REPORT.md + src/ + repo/)
```

## Key Patterns

### Multi-Channel Capture
Frictionless capture anywhere: Chrome popup, X/Twitter hammer button, Telegram URL. Automation only works when capture is frictionless.

### Custom Agent Pattern
Generic agents are good for general tasks. Custom agents with specific tools, modes, and permissions are better for repeatable workflows.

### Structured Research Output
```
research/article-title/
├── REPORT.md  # Summary, Key Concepts, Implementation, Tests, Assessment
├── src/       # Working implementation
└── repo/      # Cloned repositories
```

## Concepts Covered

- [[context-engineering]] — Automated context assembly for research
- [[second-brain-pattern]] — This IS automated second brain ingestion
- [[ai-engineering]] — Agent orchestration for knowledge work

## Entities Mentioned

- [[BowTiedSwan]] — BuildFlow creator
- [[OpenCode]] — AI coding assistant with session management
- [[Sisyphus Agent]] — Enhanced orchestration for OpenCode

## Connection to This Wiki

BuildFlow literally automates what `/second-brain-ingest` does manually: URL → structured wiki page. The parallel is exact — capture anywhere, process centrally, output structured knowledge.
