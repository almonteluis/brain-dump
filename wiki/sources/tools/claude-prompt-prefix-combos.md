---
description: 7 Claude prompt prefix combinations that produce better results than any single prefix alone — /punch+/trim+/raw, PERSONA+L99+WORSTCASE, /skeptic+ULTRATHINK
tags:
  - claude
  - prompt-engineering
  - ai/workflow
  - clippings
sources:
  - The prompt combos nobody talks about — why stacking Claude prefixes produces better results than any single one.md
created: 2026-04-10
updated: 2026-04-10
---

# Claude Prompt Prefix Combos

**Source:** Reddit (r/PromptEngineering) by AIMadesy
**Type:** Prompt engineering guide
**Date ingested:** 2026-04-10

## Summary

Single prompt prefixes (L99, /ghost, PERSONA) are useful — but stacking 2-3 produces dramatically better results. The combination produces something neither prefix does alone by **triangulating on a specific output shape** through multiple constraints.

## The 7 Most Useful Combos

### 1. The Slack Message Fixer: `/punch + /trim + /raw`

For condensing frustrated 4-paragraph messages into sendable form:
- `/punch` — Shortens every sentence, leads with verbs
- `/trim` — Cuts filler words without losing facts
- `/raw` — Strips markdown for clean Slack paste

**Before:** "I think we should probably consider whether it might be worth looking into rolling back the deployment given the issues we've been seeing..."

**After:** "Roll back the deployment. Staging has been broken for 3 days. Nothing else ships until it's fixed."

### 2. The Expert With Teeth: `PERSONA + L99 + WORSTCASE`

For technical decisions — gets committed recommendations with failure modes:
- `PERSONA` — Loads specific expert perspective
- `L99` — Forces commitment instead of hedging
- `WORSTCASE` — Tells you what could go wrong

**Example:** `PERSONA: Senior backend engineer who just survived a failed microservices migration. L99 WORSTCASE Should we move our monolith to microservices?`

### 3. The Wrong-Question Killer: `/skeptic + ULTRATHINK`

Improves the question first, then goes maximum depth:
- `/skeptic` — Challenges your premise ("You want to test 200 variants but your traffic requires 6 months each. Test 5 instead?")
- `ULTRATHINK` — 800-1200 word thesis-style response with 3-4 analytical layers

### 4. The Voice Cloner: `/mirror + /voice + /ghost`

For mimicking someone's writing style:
- `/mirror` — Reads 3 writing samples and clones voice
- `/voice` — Locks tone so it doesn't drift
- `/ghost` — Strips AI tells from output

Tested by sending cloned email to the person being mimicked — they didn't notice.

### 5. The Cold Email That Doesn't Sound Like AI: `/ghost + /punch + /voice`

Every cold email tool produces the same AI-sounding output. Recipients spot it instantly.

Set `/voice` to "direct, warm, slightly casual, like a founder writing to another founder." `/ghost` strips AI fingerprints. `/punch` makes every sentence count.

### 6. The Decision Closer: `HARDMODE + /decision-matrix + L99`

For going in circles comparing 3+ options:
- `/decision-matrix` — Weighted scoring table
- `HARDMODE` — Prevents "depends on your needs" escape hatches
- `L99` — Forces final "pick this one" recommendation

30 minutes of going in circles → 5 minutes with a defended decision.

### 7. The Incident Commander: `OODA + WORSTCASE + /postmortem`

Production is down and you're panicking:
- `OODA` — 4-step runbook (Observe/Orient/Decide/Act) in 10 seconds
- `WORSTCASE` — Blast radius before you act
- `/postmortem` — Blameless writeup while details are fresh

## Why Combos Work Better

**Single prefix** = one behavioral nudge. Claude adjusts in one dimension.

**Combo** = multiple constraints that triangulate on a specific output shape. Claude can't hedge in ANY of the specified dimensions, forcing it into a much narrower (and more useful) response space.

**Analogy:** Single prefix = "shoot in portrait mode." Combo = "portrait mode, natural light, candid, no posing, shoot from slightly below."

## Related

- [[context-engineering]] — Designing context windows for AI agents
- [[prompt-engineering-system-command]] — Structured prompt engineering
- [[ai-engineering]] — AI-assisted software engineering
