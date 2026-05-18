---
description: "Daily notes automation documentation"
tags: [system, daily-notes, automation, cron]
sources: [06_system/daily-notes-automation/README.md]
created: 2026-04-09
updated: 2026-04-09
---

# Daily Notes Automation

**Source:** raw/06_system/daily-notes-automation/README.md
**Date ingested:** 2026-04-09
**Type:** documentation

## Summary

Documentation for automatic daily note creation in Obsidian. Runs at 7pm EST (midnight UTC) via cron job. Creates structured daily notes with morning review, learning tracker, code practice, daily tasks, notes, progress metrics, review sections, and skills progress tracking.

## Key Claims

- Automatic creation: Every day at midnight UTC (7pm EST)
- Location: `00_inbox/daily/` folder using `Templates/daily-note-template.md`
- Script location: `/home/ubuntu/clawd/scripts/create-daily-note.py`
- Manual creation available: `python3 /home/ubuntu/clawd/scripts/create-daily-note.py`

## Concepts Covered

- [[daily-note-automation]] — Scheduled note creation system
- [[cron-jobs]] — Scheduled task execution
- [[template-system]] — Daily note template structure
- [[learning-tracker]] — Progress monitoring across skills
- [[clawdbot]] — AI assistant integration
