---
tags:
  - git
  - tools
  - llm
  - clippings
sources:
  - karpathyrendergit Render any git repo into a single static HTML page for humans or LLMs.md
created: 2026-04-29
updated: 2026-04-29
---

# karpathy/rendergit

**Source:** karpathyrendergit Render any git repo into a single static HTML page for humans or LLMs.md
**Date ingested:** 2026-04-29
**Type:** Tool documentation

## Summary

Andrej Karpathy's utility to flatten any GitHub repository into a single static HTML page with syntax highlighting and sidebar navigation. Dual view modes for humans and LLMs.

## Key Features

- **Human View:** Syntax highlighting, sidebar navigation, markdown rendering, directory tree
- **LLM View:** Raw CXML text format for copying to Claude/ChatGPT
- **Smart filtering:** Skips binaries and oversized files
- **Ctrl+F:** Search across all files on single page
- **Install:** `uv tool install git+https://github.com/karpathy/rendergit`

## Usage

```bash
rendergit https://github.com/karpathy/nanogpt
```

Clones repo to temp dir → renders to single HTML → opens in browser.

## Entities Mentioned

- [[andrej-karpathy|Andrej Karpathy]] — Creator

## Concepts Covered

- [[repo-visualization]] — Flattening codebases for exploration
- [[llm-context-prep]] — Formatting code for LLM consumption
