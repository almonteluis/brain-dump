---
description: Checkpoint loop rules for memory management — triggers for flushing context and writing to memory files
tags: #clawdbot #system #memory-management
date: 2026-02-01
---

# HEARTBEAT.md

CHECKPOINT LOOP (every 30 min or on trigger)

1. context getting full? → flush summary to memory/YYYY-MM-DD.md
2. learned something permanent? → write to MEMORY.md
3. new capability or workflow? → save to skills/
4. before restart? → dump anything important

TRIGGERS (don't just wait for timer)
→ after major learning = write immediately
→ after completing task = checkpoint
→ Context getting full = forced flush

context dies on restart. memory files don't.
