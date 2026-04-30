---
description: Three-folder system for AI-powered personal knowledge management
tags: ["pkm", "knowledge-management", "ai-workflow", "llm-wiki"]
created: 2026-04-09
updated: 2026-04-09
---

# Second Brain Pattern

Karpathy's minimal approach to AI-powered knowledge management: three folders, one schema file, no special software. The system compounds in value with each use.

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
- Interest 3
```

## The Workflow Loop

```
1. CAPTURE → Drop everything into raw/
        ↓
2. COMPILE → AI reads raw/, creates wiki/
        ↓
3. QUERY → Ask questions against wiki/
        ↓
4. SYNTHESIZE → Save answers to outputs/
        ↓
5. (back to 1)
```

## Compounding Effect

Every cycle improves the system:
- New sources add raw material
- Questions generate new insights
- Outputs get filed back
- Wiki cross-references grow

**Health check monthly**: "Review wiki/. Flag contradictions, find gaps, suggest new articles."

## Tool Agnostic

The AI doesn't care what editor you use:
- Terminal + Claude Code
- VS Code
- Obsidian (resist plugin bloat)
- Notepad

What matters: folder structure + schema.

## Related

- [[how-to-build-second-brain]] — Tutorial source
- [[llm-wiki-pattern]] — This vault's implementation
- [[progressive-disclosure]] — Layered information access
- [[knowledge-synthesis]] — AI-powered processing

## Resources

- Karpathy's approach: https://x.com/karpathy (see PKM thread)
- Tutorial: https://x.com/NickSpisak_/status/2040448463540830705
