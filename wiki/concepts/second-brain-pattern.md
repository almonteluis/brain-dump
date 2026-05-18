---
description: Second Brain Pattern — Karpathy's minimal AI-powered knowledge management. Three folders, one schema file, no special software. The system compounds with each use.
tags:
  - pkm
  - knowledge-management
  - ai/workflow
  - llm-wiki
created: 2026-04-09
updated: 2026-05-17
---

# Second Brain Pattern

Karpathy's minimal approach to AI-powered knowledge management: three folders, one schema file, no special software. You don't need Notion plugins or Obsidian themes. You need raw material, a place for organized knowledge, and a loop that keeps improving both.

## The Three Folders

```
my-knowledge-base/
├── raw/          # Unprocessed source material
├── wiki/         # AI-organized knowledge
└── outputs/      # Generated answers and reports
```

| Folder | Purpose | Rule |
|--------|---------|------|
| **raw/** | Source material dump | Never modify by hand |
| **wiki/** | Organized, interlinked topics | AI maintains entirely |
| **outputs/** | Answers to questions | Save best responses back |

## The Schema File (CLAUDE.md)

Tells the AI how to organize knowledge:

```markdown
# Knowledge Base Schema

## What This Is
Personal knowledge base about [TOPIC].

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
- Interest 1
- Interest 2
```

## The Workflow Loop

```
1. CAPTURE → Drop everything into raw/
2. COMPILE → AI reads raw/, creates wiki/
3. QUERY → Ask questions against wiki/
4. SYNTHESIZE → Save answers to outputs/
5. (back to 1)
```

Every cycle improves the system. New sources add raw material. Questions generate new insights. Outputs get filed back. Wiki cross-references grow. The compound interest of knowledge management.

**Health check monthly**: "Review wiki/. Flag contradictions, find gaps, suggest new articles."

The tool doesn't matter — terminal + Claude Code, VS Code, Obsidian, Notepad. What matters: folder structure + schema. This vault is that pattern running live, with [[progressive-disclosure]] layered on top.

## Related

- [[how-to-build-second-brain]] — Tutorial source
- [[llm-wiki-pattern]] — This vault's implementation
- [[progressive-disclosure]] — Layered information access
- [[knowledge-synthesis]] — AI-powered processing
