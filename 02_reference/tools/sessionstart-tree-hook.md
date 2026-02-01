---
description: SessionStart hook pattern that injects the vault's file tree at the beginning of each Claude Code session, providing Layer 1 context for progressive disclosure.
tags: ["hooks", "session-start", "layer-1", "file-tree", "progressive-disclosure", "claude-code"]
created: 2026-01-29
---

# SessionStart Tree Injection Hook

## The Pattern

Inject the full file tree at session start so Claude has immediate Layer 1 context before any exploration begins.

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

## Related

[[layer-3-heading-standards]]
[[yaml-descriptions-layer-2]]
[[obsidian-claude-101]]
