---
description: Session log template
tags:
  - system
  - template
  - session/log
sources:
  - 06_system/templates/session-log-template.md
created: 2026-04-09
updated: 2026-04-09
---

# Session Log Template

**Source:** raw/06_system/templates/session-log-template.md
**Date ingested:** 2026-04-09
**Type:** template

## Summary

Standardized template for Claude Code session logs. Includes YAML frontmatter with description, tags, created date, duration, and model. Sections cover summary, context/intent, actions taken, files created/modified, key insights, decisions, open questions, next steps, commands used, and related notes.

## Key Claims

- Resume Path field enables `/resume` command to find and restore session context
- Structured format ensures continuity between sessions
- Files created/modified tracked in tables with wiki-links
- Next steps include actionable checkboxes for follow-up

## Concepts Covered

- [[session-log-structure]] — Standardized log sections
- [[resume-path]] — Critical field for context restoration
- [[action-tracking]] — Recording what was accomplished
- [[file-tracking]] — Change documentation with wiki-links
- [[session-metadata]] — Duration, model, date tracking
