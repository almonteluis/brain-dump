---
description: Moltbot and Clawdbot patterns from Twitter bookmarks — proactive prompts, cron job examples, self-improvement loops, memory systems, deployment guides, and monitoring tools.
tags: ["moltbot", "clawdbot", "ai-agents", "automation", "cron-jobs", "memory"]
created: 2026-01-29
---

# Moltbot / Clawdbot Patterns

## What Makes It Different

1. Context and skills live on YOUR computer (not walled garden)
2. Open source (not paying for insane value)
3. Growing community building skills (compounding)
4. World-class developers (@steipete, @theguti)
5. Only 19 days old and constantly improving
6. Accessible via WhatsApp, Telegram, Signal, Discord, Slack
7. Proactive: cron jobs, reminders, background tasks
8. Memory persists 24/7

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
I'll test and commit.

Every night when I go to bed, build something cool out I can test.
```

**Setup requirements**:
- Brain dump EVERYTHING about you and your business first
- Make it aware to NOT commit code
- Make it aware to NOT delete files
- Use Codex CLI instead of Claude Code to save tokens

## Self-Improvement Loop

**By**: @jumperz

**HEARTBEAT.md** (runs every hour):
```
Self-Check (runs every hour)

Ask yourself:
> what sounded right but went nowhere?
> where did I default to consensus?
> what assumption did I not pressure test?

Log answers to memory/self-review.md

Tag each entry with: [confidence | uncertainty | speed | depth]
```

**Startup prompt**:
```
On boot, read memory/self-review.md
Prioritize recent MISS entries
When task context overlaps a MISS tag, force a counter-check before responding
```

**The Loop**:
```
heartbeat → question itself → log MISS/FIX → restart → read log → adjust
```

**self-review.md format**:
```
[date]

TAG: confidence
MISS: defaulted to consensus
FIX: challenge the obvious assumption first

TAG: speed
MISS: added noise not signal
FIX: remove anything that doesn't move the task forward
```

**Result**: Week one will be mid. Week four you'll notice sharp improvement.

## Cron Job Examples

**By**: @dabit3

1. **GitHub Trending Digest**
   - Top 10 trending repos with stars, language, quick takes
   - Grouped by category

2. **Daily Motivation**
   - 10 timeless motivational tweets about building, shipping, momentum
   - Morning fuel

3. **Top Hacker News Stories**
   - Top 10 upvoted posts from past 24 hours
   - Summarized with links

4. **Product Hunt Daily Picks**
   - Best 5-7 launches (dev tools and AI products)
   - Upvote counts and whether worth attention

5. **YC Startup Spotlight**
   - Deep dive on one YC company
   - Problem, solution, founders, funding, competitors, analysis
   - Mini investor memo style

6. **AI Twitter Digest**
   - Top 20 viral AI tweets from past 24 hours

7. **AI Trend App Builder**
   - Searches X for viral AI trends
   - Picks one and builds working app
   - Pushes to GitHub
   - Sends you the link

**Result**: Replaces almost all newsletters with content curated to exactly what you want.

## Memory Systems

### QMD (by @tobi)
- Fast, private indexing of Obsidian vaults or markdown files
- SQLite with BM25 for keyword search
- Local embeddings for semantic search
- Hybrid mode: query expansion + parallel retrieval + reciprocal rank fusion + re-ranking
- All on-device with auto-downloaded models
- **96% token consumption reduction**

### Supermemory (by @DhravyaShah)
- Give your clawd/molt bot perfect memory
- One single command

### Telegram Indexing (by @chatgpt21)
- Use Google API or OpenAI API to index all chats
- When packing 200k tokens of context, remembers whole conversation
- Update continuously so it doesn't forget

## Deployment

### Digital Ocean (Recommended for beginners)
**By**: @dabit3
- $7/month
- Much simpler UX than AWS or Hetzner
- Negligible cost
- [Instructions link](https://dabit3.dev/digital-ocean-moltbot)

### Mac Mini
**By**: @MattPRD
- Fully functioning AI employee with own computer
- Maybe buy 10 of them
- AGI is already here maybe?

## Monitoring

### Crabwalk
**By**: @luccasveg

Open-source companion monitor for Clawdbot:
- Live node graph of sessions & action chains
- Works with WhatsApp, Telegram, Discord, Slack
- See thinking states, tool calls, responses as they happen
- Filter by platform, search by recipient
- Little crab bastard that chases your nodes around

## Skills Ecosystem

**700+ community skills** (by @Param_eth):
- CLI Utilities
- Git & GitHub
- Clawdbot Tools
- DevOps & Cloud
- Marketing & Sales
- Search & Research
- Coding Agents & IDEs
- Browser & Automation
- Image & Video Generation
- Web & Frontend Development

**AntiGravity**: Got 200+ new agent skills with simple install flow.

## AI Employee Onboarding

**By**: @GanimCorey

Every new AI hire starts with these files:

| File | Purpose |
|------|---------|
| `IDENTITY.md` | Who they are |
| `USER.md` | Who you are and your preferences |
| `SOUL.md` | Their tone and boundaries |
| `AGENTS.md` | Their operating rules |

**Key**: Just like a real employee, they need context about themselves AND about you. The clearer you define this up front, the less you micromanage later.

---

## Related

[[Claude Code Power User Patterns]]
[[Guilt as Intuition Not Shame]]
[[Decision Velocity]]
[[Observability as Competitive Advantage]]
[[vault-wide-connections-synthesis]]
[[AGI Timeline 2026]]
