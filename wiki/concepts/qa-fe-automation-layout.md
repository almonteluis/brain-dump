---
description: A WezTerm three-pane layout bound to Cmd+Shift+Q for running frontend automation against a chosen environment
tags: [workflow, terminal, testing, playwright, concept]
created: 2026-05-17
source: "[[QA FE automation local workflow]]"
---

# QA FE automation terminal layout

A single keybind — `Cmd+Shift+Q` in WezTerm — opens a three-pane tab configured for running frontend automation against a specific environment. No remembering which database to connect to, no hunting for the env file — the layout *is* the context.

The three panes:
- **Left pane**: auto-fills `nvim .env` for environment switching
- **Top right**: Playwright command line (swap the project flag per environment)
- **Bottom right**: database connection via Leap → Core Auto → PG Admin

This is the QA-workflow incarnation of [[spatial-terminal-layouts]]: the keybind lands you in the exact configuration needed to run automation, so the cost of starting a run drops to near zero. That low cost is what makes [[shift-left-fe-automation]] practical — if running the suite is one keybind away, you run it earlier and more often.

## Related Concepts
- [[spatial-terminal-layouts]]
- [[shift-left-fe-automation]]
