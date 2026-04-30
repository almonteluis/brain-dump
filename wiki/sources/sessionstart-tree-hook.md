---
description: "SessionStart tree injection hook pattern"
tags: [tools, hooks, session-start, layer-1, file-tree, progressive-disclosure, claude-code]
sources: [sessionstart-tree-hook.md]
created: 2026-04-09
updated: 2026-04-09
---

# SessionStart Tree Injection Hook

**Source:** raw/02_reference/tools/sessionstart-tree-hook.md
**Date ingested:** 2026-04-09
**Type:** guide

## Summary

SessionStart hook pattern that injects the vault's file tree at the beginning of each Claude Code session, providing Layer 1 context for progressive disclosure.

## Key Claims

- Injecting file tree at session start eliminates exploration cycles
- Descriptive filenames serve as first impression of content
- Pattern recognition from tree alone shows content clusters
- Most decisions can be made at filename level without opening files

## Configuration

Add to `~/.claude/settings.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "cd /path/to/vault && tree -L 3 -a -I '.git|.obsidian' --noreport"
          }
        ]
      }
    ]
  }
}
```

## Why This Works

1. **No exploration cycles** — No need to run Glob/Grep to understand vault structure
2. **Descriptive filenames** — File names serve as first impression of content
3. **Pattern recognition** — Clusters become visible (e.g., `Quick Reference/What is...` = interview questions)
4. **Queries evolve** — Filenames like `checkpoint-md.md` reveal search behavior patterns

## Example Output

```
00_inbox/
├── daily/           → Daily notes by date
├── Links/           → Link capture zone
└── README.md        → Inbox guide

02_reference/
├── software-engineer/
│   ├── Quick Reference/   → Interview questions
│   ├── Frontend/          → React, CSS, Patterns
│   ├── Backend/           → APIs, Authentication
│   └── Languages/         → JavaScript, Python, TypeScript
├── tools/                 → Vault standards and automation
└── sources/               → External knowledge (Readwise)
```

## Benefits

| Before | After |
|--------|-------|
| Run Glob to find folders | See folder structure immediately |
| Run Grep to find patterns | Identify patterns from filenames alone |
| Open files to understand | Filter by filename relevance first |

## Layer 1 of Progressive Disclosure

```
Layer 1: File Tree (THIS)
   → See folder structure, understand organization

Layer 2: YAML Descriptions
   → Search descriptions, decide what's relevant

Layer 3: Outline
   → Check headings for structure

Layer 4: Full Content
   → Load only if all layers confirm value
```

## Concepts Covered

- [[SessionStart Hook]] — Pre-session context injection
- [[progressive-disclosure-in-practice]] — Layered information navigation
- [[Layer 1]] — File tree context
- [[Vault Navigation]] — Structure-first exploration

## Related

- [[layer-3-heading-standards]]
- [[yaml-descriptions-layer-2]]
- [[obsidian-claude-101]]
