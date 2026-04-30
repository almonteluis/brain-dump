---
description: "Proactive AI agent patterns and cron jobs"
tags: [tools, moltbot, clawdbot, ai-agents, automation, cron-jobs, memory, proactive-ai]
sources: [moltbot-clawdbot-patterns.md]
created: 2026-04-09
updated: 2026-04-09
---

# Moltbot / Clawdbot Patterns

**Source:** raw/02_reference/tools/moltbot-clawdbot-patterns.md
**Date ingested:** 2026-04-09
**Type:** guide

## Summary

Comprehensive patterns for Moltbot and Clawdbot AI agents including proactive prompts, self-improvement loops, cron jobs, memory systems, deployment guides, and monitoring tools.

## Key Claims

- Proactive AI agents can operate autonomously while you sleep, creating PRs for review
- Self-improvement loops with HEARTBEAT.md create compounding intelligence over time
- Cron jobs can replace newsletters with personalized content curation
- AI employees need onboarding files (IDENTITY.md, USER.md, SOUL.md, AGENTS.md) just like humans
- Memory systems (QMD, Supermemory) enable persistent context across sessions

## The Proactive Prompt

**By**: @AlexFinn

```
I am a 1 man business. I work from the moment I wake up to the moment I go to sleep.
I need an employee taking as much off my plate and being as proactive as possible.

Please take everything you know about me and just do work you think would make my
life easier or improve my business and make me money.

I want to wake up every morning and be like "wow, you got a lot done while I
was sleeping."

Don't be afraid to monitor my business and build things that would help improve
our workflow. Just create PRs for me to review, don't push anything live.
```

## Self-Improvement Loop

**HEARTBEAT.md** (runs every hour):
```
Ask yourself:
> what sounded right but went nowhere?
> where did I default to consensus?
> what assumption did I not pressure test?

Log answers to memory/self-review.md
Tag each entry with: [confidence | uncertainty | speed | depth]
```

**The Loop:**
```
heartbeat → question itself → log MISS/FIX → restart → read log → adjust
```

## Cron Job Examples

**By**: @dabit3

1. **GitHub Trending Digest** — Top 10 repos with takes
2. **Daily Motivation** — 10 timeless motivational tweets
3. **Top Hacker News** — Summarized top posts
4. **Product Hunt Daily Picks** — Best 5-7 launches
5. **YC Startup Spotlight** — Mini investor memo style
6. **AI Twitter Digest** — Top 20 viral AI tweets
7. **AI Trend App Builder** — Builds working apps from trends

## Memory Systems

### QMD (by @tobi)
- Fast, private indexing of Obsidian vaults
- SQLite + BM25 keyword search + local embeddings
- Hybrid mode with query expansion + reranking
- **96% token consumption reduction**

### Supermemory (by @DhravyaShah)
- One command for perfect memory

## Deployment Options

| Platform | Cost | Best For |
|----------|------|----------|
| **Digital Ocean** | $7/month | Beginners, simple UX |
| **Mac Mini** | One-time | Fully functioning AI employee |

## AI Employee Onboarding

**By**: @GanimCorey

Every new AI hire starts with:

| File | Purpose |
|------|---------|
| `IDENTITY.md` | Who they are |
| `USER.md` | Who you are and your preferences |
| `SOUL.md` | Their tone and boundaries |
| `AGENTS.md` | Their operating rules |

## Concepts Covered

- [[Proactive AI]] — Autonomous agent operation
- [[self-improvement-loop]] — Continuous learning pattern
- [[Cron Jobs]] — Automated scheduled tasks
- [[Memory Systems]] — Persistent context
- [[AI Employee Onboarding]] — Agent configuration
- [[QMD]] — Local document search

## Related

- [[claude-code-power-user-patterns]]
- [[guilt-as-intuition-not-shame]]
- [[decision-velocity]]
- [[observability-competitive-advantage]]
- [[agi-timeline-2026]]
