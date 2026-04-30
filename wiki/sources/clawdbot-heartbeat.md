---
description: "Memory checkpoint loop pattern"
tags: [clawdbot, heartbeat, memory-management, checkpoint, system]
sources: [clawdbot/HEARTBEAT.md]
created: 2026-04-09
updated: 2026-04-09
---

# HEARTBEAT.md

**Source:** raw/02_reference/tools/clawdbot/HEARTBEAT.md
**Date ingested:** 2026-04-09
**Type:** system

## Summary

Checkpoint loop rules for memory management — triggers for flushing context and writing to memory files.

## Key Claims

- Context dies on restart — memory files don't
- Flush summary to memory files when context gets full
- Write permanent learnings to MEMORY.md immediately
- Don't wait for timer — use triggers

## CHECKPOINT LOOP (every 30 min or on trigger)

1. **context getting full?** → flush summary to memory/YYYY-MM-DD.md
2. **learned something permanent?** → write to MEMORY.md
3. **new capability or workflow?** → save to skills/
4. **before restart?** → dump anything important

## TRIGGERS (don't just wait for timer)

→ **after major learning** = write immediately
→ **after completing task** = checkpoint
→ **Context getting full** = forced flush

## Why This Matters

Clawdbot sessions restart fresh. Without checkpointing:
- Important context is lost
- Decisions aren't recorded
- Learnings evaporate

With checkpointing:
- Continuity across sessions
- Cumulative knowledge building
- Self-improvement over time

## Concepts Covered

- [[Checkpoint Pattern]] — Periodic state saving
- [[Memory Flush]] — Context preservation
- [[Trigger-Based Saving]] — Event-driven checkpoints
- [[Session Continuity]] — Cross-session persistence

## Related

- [[clawdbot-memory]]
- [[clawdbot-agents]]
- [[moltbot-clawdbot-patterns]]
