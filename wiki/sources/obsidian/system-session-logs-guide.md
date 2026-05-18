---
description: Session logging documentation guide
tags:
  - system
  - session/log
  - guide
  - memory
sources:
  - 06_system/session-logs/README.md
created: 2026-04-09
updated: 2026-04-09
---

# Session Logs Guide

**Source:** raw/06_system/session-logs/README.md
**Date ingested:** 2026-04-09
**Type:** documentation

## Summary

Guide to session logs — structured records of Claude Code sessions for continuity, learning, and resume capability. Covers naming conventions, log format, connection to `/resume` command, searching methods, and best practices for creating session logs.

## Key Claims

- Session logs enable `/resume` command to restore context from previous sessions
- Naming convention: `session-YYYY-MM-DD-{{topic-slug}}.md`
- Resume Path frontmatter field enables automatic context restoration
- Desktop symlink at `~/Desktop/CC-Session-Logs/` provides quick access outside Obsidian

## Concepts Covered

- [[session-log-format]] — Standardized session documentation structure
- [[resume-command]] — Context restoration from previous sessions
- [[session-search]] — Finding logs by date, tag, or content
- [[continuity-patterns]] — Maintaining context across sessions
- [[wiki-links]] — Bidirectional note linking for traceability
