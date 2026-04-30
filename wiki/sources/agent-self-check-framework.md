---
description: Agent self-improvement through MISS/FIX logging with context-triggered counter-checks — from Moltbot/ClawdBot
tags: [ai, agents, self-improvement, feedback-loops]
sources: ["2026-01-30 - Moltbot Self-Check Framework.md"]
created: 2026-04-21
updated: 2026-04-21
---

# Agent Self-Check Framework

**Source:** 2026-01-30 - Moltbot Self-Check Framework.md
**Date ingested:** 2026-04-21
**Type:** Twitter thread / framework

## Summary

A framework for continuous agent improvement via structured self-reflection. Agents don't improve on their own — they need explicit MISS/FIX logging with context-triggered counter-checks. Add self-check questions to HEARTBEAT.md, log to memory/self-review.md, and force counter-checks when task context overlaps previous failures.

## Key Claims

- Agents don't self-improve automatically without structured reflection
- MISS/FIX logging creates persistent memory from ephemeral failures
- Context-aware prioritization prevents repeating mistakes in similar situations
- Tags enable pattern recognition (confidence, uncertainty, speed, depth)
- HIT logging prevents over-correction from only tracking failures

## The Loop

```
Heartbeat → Question Self → Log MISS/FIX → Restart → Read Log → Adjust
```

## MISS/FIX Format

```
[ date ]
TAG: confidence
MISS: defaulted to consensus
FIX: challenge the obvious assumption first
```

## Interval Tuning

- More tasks = shorter interval (30 min)
- Fewer tasks = longer interval (4 hours)
- Sweet spot: 1-2 hours for most use cases

## Key Insight

"Agents lie to themselves" — overconfident, rushed, or avoiding uncertainty. The system works because it forces confrontation with patterns. Week one is mid. Week four shows sharp improvement.

## Concepts Covered

- [[ai-engineering]] — Agent behavior engineering
- [[cognitive-load]] — Structured reflection reduces pattern blindness

## Related

- Complements [[self-improvement-loop]] with active prevention (not just passive logging)
- Builds on HEARTBEAT.md pattern from [[clawdbot-heartbeat]]
