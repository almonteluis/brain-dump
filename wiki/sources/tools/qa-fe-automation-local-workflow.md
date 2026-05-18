---
tags: [work, qa, playwright, wezterm, workflow, automation]
sources: ["QA FE automation local workflow.md"]
created: 2026-05-04
updated: 2026-05-04
---

# QA FE Automation — Local Workflow

**Source:** QA FE automation local workflow.md
**Date ingested:** 2026-05-05
**Type:** Personal workflow / process documentation

## Summary

Personal terminal workflow for running frontend automated tests locally. Uses WezTerm with a three-pane layout, Playwright for testing, and PG Admin for database inspection.

## Key Claims

- **Terminal:** WezTerm, opened with `Cmd+Shift+Q` keybind (new tab with three panes).
- **Left pane:** `nvim .env` — environment file for switching environments.
- **Top right pane:** Playwright test command. Must switch `--project` flag when switching environments.
- **Bottom right pane:** Database connection via Leap → Core Auto → Connect Database → type environment (usually `dev-environment-dir`).
- Alternative to DB pane: PG Admin for direct database inspection.
- Test execution: `npx playwright test` with appropriate environment.

## Workflow

1. Open WezTerm, hit `Cmd+Shift+Q` → three-pane tab opens.
2. Edit `.env` in left pane if switching environments.
3. Connect to database in bottom right via Leap.
4. Run Playwright tests in top right pane with matching `--project`.

## Concepts Covered

- [[playwright]] — frontend test automation
- [[wezterm]] — terminal multiplexer workflow
- [[postgresql]] — database inspection
- [[leap]] — environment connection tool

## Related

- [[remaining-brain-break-tickets]] — this workflow used for brain break debugging
- [[qa-frontend-automated-test-workflow]] — official Confluence process (different from this personal workflow)
