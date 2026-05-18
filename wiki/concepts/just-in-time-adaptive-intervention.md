---
description: JITAI — Just-in-Time Adaptive Intervention. From health-behavior research, borrowed for learning. Intervene at the moment of relevance, adapted to user state, not on a fixed schedule.
tags:
  - concept
  - framework
  - jitai
  - learning
  - health-behavior
  - ed-tech
  - adaptive/systems
sources:
  - irec-metacognitive-scaffolding-arxiv.md
created: 2026-05-09
updated: 2026-05-17
---

# Just-in-Time Adaptive Intervention (JITAI)

JITAI is a framework borrowed from health-behavior research: deliver interventions at the moment they're most relevant, adapted to the user's current state, not on a fixed schedule. Hou & Tan (2025) picked it up to formalize the [[insight-recall|Insight Recall]] paradigm — applying JITAI's three-axis adaptation (timing, content, intensity) to learning contexts.

## The Three Properties

| Property | What it means |
|----------|--------------|
| **Just-in-time** | Delivered at the moment of relevance, not on a pre-scheduled cadence |
| **Adaptive** | Responsive to user state, context, history — not one-size-fits-all |
| **Intervention** | A specific, targeted nudge designed to change behavior or cognition |

## Where It Came From

Health-behavior research:
- **Smoking cessation** — surface a coping strategy when the user enters a high-craving context
- **Physical activity** — nudge to walk when sedentary for 90 min during active hours
- **Medication adherence** — remind based on context (location, activity), not just clock time

The insight: **fixed-schedule interventions miss the relevance window.** Reminding someone to take medication at 8 AM is useless if they're already commuting.

## Why It Translates to Learning

Same failure mode. [[spaced-repetition]] delivers review at scheduled times, regardless of what the learner is currently working on. A review card on infinite series popping up while you're solving a calculus problem *interrupts* the flow rather than supporting it. The [[encoding-specificity-principle]] predicts retrieval works best when the cue matches the encoding context. JITAI satisfies this naturally.

## In Insight Recall

Applied to learning ([[insight-recall|Hou & Tan 2025]]):
- **Trigger** — new problem context, prerequisite skill bridge, struggle event
- **Adaptation** — system selects the most relevant past insight based on current problem + learner state
- **Delivery** — surfaced at the moment of cognitive relevance, not on a calendar

The result: review and scaffolding are **woven into** the learning flow, not bolted on.

## Design Decisions JITAI Forces

1. **Context model** — what signals define "the right moment"? Skill entry? Sub-step? Struggle?
2. **State estimation** — what does the system know about the learner right now? ([[knowledge-tracing]] often supplies this.)
3. **Intervention library** — what interventions are available? (For Insight Recall: the personal insight knowledge graph.)
4. **Decision policy** — when multiple candidates exist, which fires? (Hou & Tan use LLM similarity assessment.)
5. **Burden minimization** — don't over-intervene. Respect attention budget.

## For Marvin

- The **trigger surface** (Path C in [[three-ring-mastery-system]]) is the JITAI hook — prerequisite-graph-driven review = JITAI for skill rehearsal
- [[BrainBreak]] / [[cooldown-system]] is already a JITAI-shaped intervention: it fires when the system detects a cooldown-eligible moment, not on a clock
- [[insight-recall]] extends JITAI from skill-level (what to review) to insight-level (what thinking to surface back)

The open thread: JITAI assumes you can detect the right moment. In health, you have GPS and accelerometers. In learning, you have [[knowledge-tracing]] mastery probabilities and response time. The signal is noisier. How do you handle false positives — intervening when the student didn't need it? That's attention theft, and it's worse than not intervening at all.

## Related

- [[insight-recall]] — Primary paradigm using JITAI
- [[self-regulated-learning]] — Theoretical container
- [[three-ring-mastery-system]] — Path C as JITAI hook
- [[BrainBreak]] / [[cooldown-system]] — Existing JITAI-shaped intervention
- [[knowledge-tracing]] — Often supplies the state layer JITAI adapts to
- [[encoding-specificity-principle]] — Why context-triggered delivery works
