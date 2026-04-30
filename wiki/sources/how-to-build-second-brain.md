---
description: Karpathy's simple folder-based system for AI-powered personal knowledge management
tags: ["pkm", "second-brain", "ai-workflow", "knowledge-management"]
sources: ["How to Build Your Second Brain.md"]
created: 2026-04-09
updated: 2026-04-09
---

# How to Build Your Second Brain

**Source:** How to Build Your Second Brain.md (raw, deleted)
**Author:** [[@NickSpisak_]] (based on [[@karpathy]] approach)
**Date ingested:** 2026-04-09
**Type:** Tutorial

## Summary

A minimal, AI-powered personal knowledge base using three folders and a schema file. No special software, no database — just folders and text files. The system gets smarter every time you use it through compounding insights.

## Core Structure

```
my-knowledge-base/
├── raw/          # Unprocessed source material
├── wiki/         # AI-organized knowledge
└── outputs/      # Generated answers and reports
```

## The 4-Step Workflow

### 1. Fill Raw Folder (10 minutes)

Dump everything without organizing:
- Copy-paste articles into .md/.txt
- Screenshots and diagrams as images
- Meeting notes, research papers, bookmarks
- Export from existing apps

**Don't**: organize, rename, or clean up. That's the AI's job.

### 2. (Optional) Automate Collection

**agent-browser** from Vercel Labs:
```bash
npm install -g agent-browser
agent-browser install  # Downloads dedicated Chrome

agent-browser open https://article-url.com
agent-browser get text "article" > raw/article.md
```

- Handles JavaScript-heavy sites
- Works with login-required pages
- 82% fewer tokens than Playwright MCP

### 3. Write Schema File (CLAUDE.md)

```markdown
# Knowledge Base Schema

## What This Is
Personal knowledge base about [YOUR TOPIC].

## How It's Organized
- raw/ contains unprocessed source material. Never modify.
- wiki/ contains organized wiki. AI maintains entirely.
- outputs/ contains generated reports and analyses.

## Wiki Rules
- One .md file per topic in wiki/
- Start each file with one-paragraph summary
- Link related topics with [[topic-name]] format
- Maintain INDEX.md listing all topics
- Update relevant wiki articles when new sources added

## My Interests
[List 3-5 focus areas]
```

### 4. AI Compilation (15 minutes)

Prompt to Claude Code:
> "Read everything in raw/. Compile a wiki in wiki/ following CLAUDE.md rules. Create INDEX.md first, then one .md file per major topic. Link related topics. Summarize every source."

**Key principle**: You don't edit the wiki by hand. You read it, ask questions, and the AI updates it.

## Question → Answer Loop

Once wiki has 10+ articles:

> "Based on wiki/, what are the three biggest gaps in my understanding of [topic]?"

> "Compare what source A says about [concept] vs source B. Where do they disagree?"

> "Write a 500-word briefing on [topic] using only this knowledge base."

Save answers back to outputs/ or have AI update wiki articles. Every question improves the next answer.

## Monthly Health Check

> "Review entire wiki/. Flag contradictions, find topics mentioned but never explained, list claims without raw/ sources, suggest 3 new articles to fill gaps."

Prevents error compounding (when wrong outputs get filed back).

## Tool Choices

**Karpathy's setup**: "Super simple and flat. Nested directory of .md files."

| Tool | Works? | Notes |
|------|--------|-------|
| Terminal + Claude Code | ✓ | Author's choice |
| VS Code | ✓ | Same files |
| Obsidian | ✓ | Good for viewing, resist plugin bloat |
| Notepad | ✓ | AI doesn't care |

**Warning**: Obsidian with 47 plugins = Notion trap. Configure tools more than use them.

## Compounding Effect

41K people bookmarked Karpathy's post. The difference between bookmarking and benefiting:
- Pick your topic
- Create three folders
- Drop in what you have
- Let AI do the rest

One weekend of setup → perpetual knowledge system.

## Related

- [[llm-wiki-pattern]] — The general pattern
- [[progressive-disclosure]] — Layered information access
- [[agent-browser]] — Automated scraping tool
- [[knowledge-synthesis]] — AI-powered knowledge processing

## Entities

- [[@karpathy]] — Andrej Karpathy, AI researcher
- [[@NickSpisak_]] — Author, AI implementation content
- [[Vercel Labs]] — agent-browser creator

## Resources

- Original thread: https://x.com/NickSpisak_/status/2040448463540830705
- Free skill: https://return-my-time.kit.com/286e11f7e6
