---
description: "Invisible Orchestrator + Three-Ring Progress System"
tags: ['research']
raw_file: "orchestrator-three-ring.md"
created: 2026-05-17
---

# Invisible Orchestrator + Three-Ring Progress System

*Working concept doc — Luis, May 2026*

## TL;DR

A persistent invisible coordination layer that threads BrainBreak-style touchpoints, practice prompts, and just-in-time skill review into the student flow — surfaced only when metric conditions are met. The user-facing anchor is the existing weekly goal ring, expanded into **three concentric rings**: Goals, Practice, and Maintenance. Together they represent a student's weekly engagement health, each targeting a different motivation, all rolling up to a single "did I close my week?" question.

---

## The two ideas, and why they belong together

**The orchestrator** is an invisible coordination layer. It sits above existing student-facing features (BrainBreak, practice, micro-celebrations, prerequisite review) and decides *when* to surface them based on state — recent activity, mastery signals, upcoming content, time since last touch. Most of the time it does nothing visible. When it does fire, the moment feels well-timed rather than noisy.

**The three rings** are the user-facing surface that makes the orchestrator's effects legible. Without a visible anchor, the orchestrator is invisible work. Without the orchestrator, the rings are just dashboards.

They reinforce each other: the rings tell the student *what* matters this week; the orchestrator decides *when and how* to nudge them toward closing each one without it feeling spammy.

---

## The three rings

### 1. Goals ring *(existing)*
The current weekly goal ring in the header redesign — fills as the student completes their weekly goal targets. No change.

### 2. Practice ring *(new)*
Fills as the student completes practice problems **beyond** their core lesson load. Decoupled from the assigned schedule — this is *self-directed* practice, the signal that a student is leaning in. Awards points so it has weight separate from regular lesson progress.

### 3. Maintenance ring *(new — the novel one)*
Fills as the student successfully reviews previously-mastered skills. Crucially, **the system chooses what to resurface based on what's coming up** — prerequisite skills for upcoming lessons, surfaced just in time.

Most spaced repetition in ed-tech is backward-looking ("review what you learned a while ago"). This is forward-looking ("warm up the foundation for what's about to land"). It reframes review from chore to preparation — and turns ambient skill upkeep into a felt-rewarding loop.

> Naming TBD — "Maintenance" captures both upkeep and just-in-time prep. Alternatives: Foundation, Mastery, Roots.

---

## How the orchestrator decides

Rough firing conditions:

- **Practice ring**: surface optional practice prompts after a successful lesson when bandwidth signals are positive (e.g., student finished core work early, no recent BrainBreak fatigue flag).
- **Maintenance ring**: 24–72 hours before scheduled new content, identify the encompassing/prerequisite skills the new content exercises and schedule a 2–3 minute review session.
- **BrainBreak-style touchpoints**: surface on existing emotion/confidence triggers, but coordinated with ring state to avoid stacking.

The orchestrator's most important job is **not stacking**. If a student just finished a BrainBreak, don't push a maintenance review in the same session. If the practice ring is already 80% closed, don't aggressively prompt for more. Restraint is the product.

---

## Prior art

This idea has clear analogs in production systems. Each one solves a piece of it:

### Math Academy — FIRe (Fractional Implicit Repetition)

The closest existing system to the maintenance ring. Math Academy maintains an **encompassing graph** of prerequisite relationships across their math curriculum. When a student practices an advanced topic, credit "trickles down" through the graph — practicing 39 × 6 implicitly counts as a review of single-digit multiplication and addition. Conversely, before introducing a new topic, the system identifies and surfaces the specific prerequisite skills the new topic will exercise.

Skycak's framing: *credit travels downwards through the knowledge graph like lightning bolts; penalties travel upwards like growing trees.* The empirical payoff: most courses require only ~1 explicit review per topic because of graph compression.

- [Optimized, Individualized Spaced Repetition in Hierarchical Knowledge Structures](https://www.justinmath.com/individualized-spaced-repetition-in-hierarchical-knowledge-structures/)
- [Math Academy: How our AI works](https://mathacademy.com/how-our-ai-works)

**What we'd need to borrow:**
- A graph of prerequisite/encompassing relationships in our math content
- A per-student, per-skill mastery decay model
- A scheduler that picks resurface candidates based on upcoming content

### Apple Watch Activity Rings

The visual and motivational template. Three rings, three distinct user motivations (Move = casual, Exercise = serious, Stand = sedentary breaker), unified into a single "did I close my day?" question.

The underlying psychology — Gestalt closure (open rings create a "mental itch"), streak loss-aversion, each ring capturing a different user archetype without diluting the core loop — is well-documented and directly applicable.

- [The Psychology of Apple Watch's "Close Your Rings"](https://trophy.so/blog/the-psychology-of-apple-watchs-close-your-rings)

**Lessons applicable here:**
- Each ring should target a *different* student motivation (Goals = compliance, Practice = drive, Maintenance = depth)
- Avoid making any single ring feel mandatory; the union is the win
- Weekly cadence probably fits school rhythm better than Apple's daily reset

### Duolingo

Two relevant pieces:

1. **HLR (Half-Life Regression)** — Duolingo predicts the half-life of every word in a student's memory and surfaces practice based on decay curves. Granular, per-item, real-time. This is the kind of prediction model the maintenance ring would need (or a simpler approximation of).
   - [How we learn how you learn](https://blog.duolingo.com/how-we-learn-how-you-learn/)

2. **Daily Quests + Path** — Duolingo's quest system lives alongside the main path, providing alternative engagement targets (XP, lesson count, perfect lessons) that compete with raw progression. Functionally, each ring is doing the same thing — offering an alternative shape of "you showed up this week."

---

## Open questions

- **Ring weights / closure logic**: linear fill vs. exponential? Do partial fills decay overnight, or persist all week?
- **Mastery decay model**: do we need a full HLR-style per-skill model, or can we approximate with simpler heuristics (last-practiced date, recent accuracy)?
- **Content graph completeness**: how much prerequisite structure exists in our math content already? What's the cost of building/maintaining one from scratch?
- **Student agency**: does the maintenance ring show students *what's coming* so they can choose to prep, or does it just surface review fait accompli?
- **Teacher visibility**: do teachers see ring state? Does it feed into Smart Grouping or other instructional surfaces?
- **Failure modes**: what happens when a student keeps failing maintenance reviews? Does the orchestrator escalate, retreat, or notify teacher?

---

## Why this is worth doing

1. **It connects existing investments.** BrainBreak, weekly goals, practice problems, mastery — these currently live as separate features. The orchestrator framing turns them into a coherent system rather than a feature list, without requiring a rebuild of any of them.

2. **The maintenance ring is genuinely novel for our audience.** Forward-looking, prerequisite-aware resurfacing exists at Math Academy but their target audience is motivated adult learners. For middle school students inside a structured curriculum, this framing — "we're warming up the skills your next lesson needs" — is a meaningfully different value prop than "review old stuff."

3. **It's incrementally shippable.**
   - **Phase 1**: Practice ring (closest to existing weekly goal infra).
   - **Phase 2**: Orchestrator as a coordination primitive (a single service BrainBreak and other interventions can register with). Mostly deduping work.
   - **Phase 3**: Maintenance ring, gated on whether we can build or borrow a usable prerequisite graph.

---

## Next steps (if pursued)

1. **Curriculum audit** — does enough prerequisite structure exist in our math content to make the maintenance ring feasible? Talk to curriculum.
2. **Header infra audit** — what's the actual cost of going from one ring to three in the existing weekly-goal component?
3. **Orchestrator interface sketch** — what does a feature like BrainBreak need to register / listen for? One-pager on the API.
4. **Mock the three-ring header** for Steve and design — get a directional reaction before going further.


