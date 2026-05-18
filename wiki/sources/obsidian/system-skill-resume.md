---
description: Resume skill for context restoration
tags:
  - system
  - skill
  - session/resume
  - claude/code
sources:
  - 06_system/skills/SKILL-resume.md
created: 2026-04-09
updated: 2026-04-09
---

# /resume Skill

**Source:** raw/06_system/skills/SKILL-resume.md
**Date ingested:** 2026-04-09
**Type:** skill

## Summary

Documentation for the `/resume` skill that restores context from previous Claude Code sessions. Detects vault location, loads CLAUDE.md, loads recent session logs, and filters by search term if provided. Installation requires adding to `~/.claude/settings.json`.

## Key Claims

- Invocation: `/resume [count] [search_term]`
- Loads CLAUDE.md for project context and recent session logs for work history
- Checks multiple locations: `CLAUDE.md`, `02_reference/tools/clawdbot/CLAUDE.md`, `06_system/CLAUDE.md`
- Session logs checked in: `06_system/session-logs/`, `CC-Session-Logs/`, `~/Desktop/CC-Session-Logs/`

## Concepts Covered

- [[resume-skill]] — Context restoration command
- [[claude-settings]] — Skill configuration in settings.json
- [[context-restoration]] — Loading previous session state
- [[session-log-locations]] — Multiple fallback paths for logs
