---
description: Session resume skill for Claude Code context restoration
tags:
  - tools
  - skill
  - session/resume
  - context
  - claude/code
  - hooks
  - vault-automation
sources:
  - resume-session-skill.md
created: 2026-04-09
updated: 2026-04-09
---

# /resume — Session Resume Skill

**Source:** raw/02_reference/tools/resume-session-skill.md
**Date ingested:** 2026-04-09
**Type:** guide

## Summary

/resume skill for quickly restoring context from previous Claude Code sessions by loading CLAUDE.md and recent session logs with optional filtering.

## Key Claims

- Starting every session with immediate context eliminates re-explaining work
- Session transcripts capture exact state, decisions, and files being edited
- CLAUDE.md provides project structure and conventions understanding
- Automatic detection works across multiple vault environments

## Installation

Add to `~/.claude/settings.json`:

```json
{
  "skills": [
    {
      "name": "resume",
      "path": "/Users/lalmonte/Library/Mobile Documents/iCloud~md~obsidian/Documents/Software Engineering Notebook/06_system/resume-session.sh"
    }
  ]
}
```

## Usage

```bash
# Default: Load last 3 sessions + CLAUDE.md
/resume

# Load last 10 sessions
/resume 10

# Find sessions about "auth"
/resume auth

# Last 5 sessions about "jira"
/resume 5 jira

# List available sessions only
/resume --list
```

## What It Loads

### 1. Project Context (CLAUDE.md)
Automatically finds and loads from:
- Vault root: `CLAUDE.md`
- Clawdbot folder: `02_reference/tools/clawdbot/CLAUDE.md`
- System folder: `06_system/CLAUDE.md`

### 2. Recent Session Logs
Loads from:
- `06_system/session-logs/` (vault-local)
- `CC-Session-Logs/` (vault root)
- `~/Desktop/CC-Session-Logs/` (main vault fallback)

## Session Log Detection

Automatically detects environment:
1. **Project vaults** — Uses `06_system/session-logs/`
2. **Main vault** — Falls back to `~/Desktop/CC-Session-Logs/`
3. **Custom locations** — Checks multiple paths

## Why This Works

| Problem | Solution |
|---------|----------|
| "Where were we?" | Session transcripts show exact state |
| "How does this project work?" | CLAUDE.md explains vault patterns |
| "What did we decide?" | Transcript captures decisions |
| "What files were we editing?" | History is in the session log |

## Concepts Covered

- [[Session Resume]] — Context restoration pattern
- [[Session Logs]] — Transcript-based continuity
- [[CLAUDE.md]] — Project context file
- [[Vault Context]] — Multi-environment detection

## Related

- [[sessionstart-tree-hook]]
- [[spatial-editing]]
- [[system-session-logs-guide]]
- [[HEARTBEAT.md]]
