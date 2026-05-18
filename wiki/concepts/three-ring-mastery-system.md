---
description: Three-ring progress system combining spaced repetition, mastery stages, streaks, and weekly goals for TTO platform
tags:
  - product
  - ed-tech
  - mastery-based-learning
  - spaced/repetition
  - feature-concept
sources:
  - Mastery Velocity — Three-Ring Feature Concept.md
created: 2026-05-01
updated: 2026-05-01
---

# Three-Ring Mastery System

Feature concept for [[teach-to-one]], built on the intelligence layer from [[project-atlas|ATLAS]]. Three interlocking rings visualized Apple-Fitness-style, each mapping to a stage of learning. Weekly goal of 2 skills mastered. Spaced repetition keeps the system alive over time.

## The Three Rings

| Ring | Stage | What fills it |
|------|-------|---------------|
| **Outer** | New | First-time skills — the 2/week pace target |
| **Middle** | Practice | In-flight skills not yet mastered. Rewards effort, not just outcomes |
| **Inner** | Maintain | Mastered skills reviewed via [[spaced-repetition]] |

**Why this set:** mirrors skill lifecycle (learn → practice → keep sharp). Closes a current gap — stuck students get no visible credit for trying. Practice ring rewards effort, not just outcomes.

### Alternative inner rings (backup)

- Check-in / BrainBreak ring — ties to TEAME-218 metacognition work
- Stretch ring — attempts above current level (gameable)
- Engagement ring — pure time-on-task (rewards seat time, not learning)

## Streaks (above the rings)

Streaks live above the rings, not as one of them. Closing all three on a given day/week = a streak unit. #ideas 

- **Streak freezes** earned via ahead-of-pace tier. Protect against missed days.
- **Reset at term boundaries.** Unit streaks contribute to total roadmap streak.
- **School breaks** = automatic freeze.
- Failed maintenance counts *not for* the streak, not *against* it. 

### Streak decisions

- Daily fill with weekly streak overlay (Apple Rings + monthly challenges model)
- 5+ streak days in a week = strong week
- Self-chosen pace tier (Duolingo model): students opt into "ahead of pace" vs baseline
- Roll-in offer: after 2 weeks of hitting weekly goal, present "want to opt in for above pace?" #ideas 

## Spaced Repetition + Mastery Interlock

SR is the mechanic that makes the skill graph a living artifact. Without decay, the tree monotonically fills in. With decay, students revisit and tend it.

### Mastery stages

```
New → Practice → Mastered → Maintained
                      ↑          |
                      |__________|  (decay triggers review)
```

- Failed review (2 fails within a week) → drops back to Practice
- Within 3 failed attempts of maintenance skill → fall back
- Reviews are fast: 1-2 problems, not full sets
	- I am rethinking this. I may wanna go with a longer question set (maybe 10, 20, 30) but quick and fast. This is only meant to build the repetition and kind of have that pattern recognition that you only get from exposure to a large number of problems and questions set. 
- Decaying skills get subtle visual warning — dimmed node on [[skill-graph]] or [[wiki/concepts/knowledge-graphs|knowledge-graphs]] 

### SR framing (avoid "more old work" feeling)

- Frame as "skill maintenance" / "keeping skills sharp"
- Dimmed nodes on skill graph → visual nudge, not punishment
- Reward = keeping skills *lit* on personal roadmap
- Reviews are fast (1-2 problems)

## Practice Ring: Productive Struggle

Practice ring measures learning effort, not correctness. Based on [[productive-failure]] (Manu Kapur): kids who struggle then succeed learn more than kids who got it right immediately. Research on [[productive-struggle]] (NCTM-backed, Almalkyd 2024; Bellwether 2025) confirms:

- **Emotional scaffolding matters as much as cognitive** — students value patience, normalization of difficulty, and feeling safe to fail
- **Effective teacher behaviors**: hints not solutions, encouragement without rescuing, sustained presence during struggle
- **AI must preserve struggle** — over-scaffolding (immediate answers, excessive hints) reduces cognitive engagement and weakens long-term learning
- **Design principle**: provide "just-in-time" support that preserves the learner's cognitive effort

### Adaptive credit weighting

| Attempt type | Credit | Rationale |
|-------------|--------|-----------|
| Correct on first attempt, at-level | 1.0x | Clean mastery |
| Correct after struggle (wrong → wrong → right) | 1.2x | Productive struggle bonus |
| Correct on retake after seeing answer | 0.2x | Gaming mitigation |
| Wrong with <3 sec spent | 0.1x | Guess |
| Wrong with sustained time | 0.5x | Real attempt |

### Anti-gaming patterns

- **Diminishing returns per skill** — first 5 problems count fully, next 5 half, next 5 quarter. Forces breadth.
- **Diversity bonus** — practicing across 3+ skills counts more than 30 on one.
- **SR-aligned credit** — problems on skills SR says are due count more.
- **Asymmetric time thresholds** — 3-sec correct = likely real mastery (don't punish fast kids). 3-sec wrong = almost certainly guess.
- **One-shot or first-attempt-only credit** — Learnosity config question: can students retake same problem after seeing correct answer?

### Data source

Learnosity practice problems. One problem = one unit of practice. First-attempt correctness + time spent are primary signals.

### Reset cadence

Daily fill with weekly streak overlay. Closes daily = streak day. 5+ streak days in week = strong week.

## Weekly Goal: 2 Skills/Week

System-set target. Students don't set it, but can opt into "ahead of pace" tier.

### Measurement

- **Primary:** Skills mastered per week (not time-on-task)
- **Rigorous trio:** Mean + median + distribution shape
- **Headline:** % meeting 2/week (for teachers/PMs/leadership)
- **Key equity signal:** Distribution shape — does feature lift whole curve or just kids already doing well?
- **Unit:** Student-day → student-week; class-week as secondary
- **Weekends/absences:** Decide upfront — skip = more flattering, count = more honest

### Feature flag rollout

- Via [[unleash]], by school/district
- Roll-in: start 10-20%, gradually expand
- Pilot class vs everyone else (watch for selection bias + novelty effect)
- If possible: randomize at student level within pilot class for cleanest comparison

## Visualization: Skill Graph

Student roadmap as a graph. Student view and teacher view are fundamentally different visualizations of same underlying graph.

### Student view candidates

- **DAG / tech-tree** (Civilization / Hollow Knight) — strong progression sense
- **Subway/metro map** — skills as stations, topic strands as colored lines. Underused in ed-tech.
- **Hex tile map** — Civ-style tech web
- **Force-directed** (Obsidian-style) — beautiful for "zoom out," weak for navigation

### Teacher view candidates

- **Small multiples** — 30 mini-graphs in a grid
- **Heatmap overlay** — one graph, nodes shaded by % class mastered
- **Pace ribbon** — one row per student vs 2/week target (leading candidate)
- **Diff view** — one graph, each student as colored marker

Teacher view is probably *not* a graph at top level — it's an aggregation. Drill into graph from leaner overview.

## Supporting Features

### Top-5 leaderboard (Peloton model)

- Class-bounded, weekly reset
- Only top performers shown (no shaming bottom)
- Separate "most improved this week" board for middle-of-class recognition

### Celebration without confetti fatigue

- Character reactions (mascot moods)
- Persistent visual growth (plant, world, building)
- Avatar/theme unlocks (cheap, kids love customization)
- Variable surprise (most events small, ~10% bigger)
- "New best" framing (personal records over generic praise)

### Equity

- Students who can't hit 2/week → quietly adapt, use roadmap top skills to fill gaps
- Ahead-of-pace tier = student choice, not forced divide
- Opt-down should be frictionless

## Cross-cutting Patterns from Consumer Apps

1. Self-chosen pace target — chosen = commitment, imposed = homework
2. Short cycles over long ones — daily/weekly beat semester-long
3. One-glance progress visualization — under 1 second to read
4. Loss aversion > pure reward — but add safety valves (freezes)
5. Bounded social comparison — class-sized cohorts, weekly resets
6. Bite-sized units — "5 problems," not "master this skill"
7. Variable celebration — surprise > predictable

## Competency-Based Assessment

The three-ring mastery stages function as **assessment milestones** within a [[competency based learning]] framework:

- **New → Practice → Mastered → Maintained** maps directly to CBL's mastery-gated progression model. Each transition is itself an assessment event — a student moves from Practice to Mastered only when they demonstrate competency, not when time elapses.
- **Skills mastered per week** (the primary metric) aligns with Hattie's evidence that mastery learning (d = 0.57) is a high-impact intervention. This makes the ring system's measurement framework inherently evidence-based.
- **Decay back to Practice** ensures that assessment is ongoing rather than one-time. A maintained skill that decays must be re-demonstrated, making the entire system a continuous [[formative-assessment]] loop rather than a series of summative gates.
- **Multiple evidence types** — the Practice ring's adaptive credit weighting (rewarding productive struggle, penalizing gaming) means the system assesses *how* students demonstrate, not just whether they get the right answer. This aligns with [[performance-based-assessment]] principles.

## Open Questions

- Does TTO have a structured prerequisite map of skills? Determines Path C feasibility.
- Can Learnosity config prevent retakes after seeing answers? (Blocker for Practice ring design)
- Who owns data science / modeling? Path B and C need someone for decay curves.
- Practice ring reset: daily or weekly? (Current rec: daily fill + weekly streak overlay)
- How does this interact with existing pace ring?
- BrainBreak integration — could daily check-in close a ring?

## Related

- [[mastery-velocity-three-ring-feature-concept]] — Full brainstorm source
- [[skill-resource-phase2-architecture]] — SkillResource component being refactored
- [[skill-resource-phase2-architecture-overview]] — Architecture overview for phase 2
- [[learnosity]] — Practice problem data source
- [[unleash]] — Feature flag rollout tool
- [[cooldown-system]] — Existing cooldown pattern from BrainBreak
- [[brainbreak-context-cleanup-implementation]] — BrainBreak context cleanup

## Research Foundations

Learning science backing the three-ring design:

### Spaced repetition theory + algorithms

- [[spaced-repetition]] — Core concept (decay → review → retention)
- [[forgetting-curve]] — Ebbinghaus exponential decay model `p = 2^(-Δ/h)`
- [[half-life-regression]] — Duolingo's HLR algorithm (9.5% retention bump vs Leitner)
- [[knowledge-tracing]] — KT/DKT models for predicting future performance
- [[hermann-ebbinghaus]] — Forgetting curve discoverer (1880s)
- [[sebastian-leitner]] — Leitner box system (1973) — Path A inspiration
- [[paul-pimsleur]] — Graduated-interval recall (1967)
- [[burr-settles]] — Half-Life Regression (Duolingo, 2016)

### Source pages — SR theory + classroom application

- [[teachers-guide-spaced-repetition]] — Classroom playbook (1/3/6/10/14/18 wk schedule, 7 techniques)
- [[spaced-repetition-wikipedia]] — Algorithm family + history reference
- [[duolingo-half-life-regression]] — Trainable per-word half-life (Settles ACL 2016)
- [[geometry-of-learning-kst-mastery-maps]] — KST 0-5 rubric, Dunning-Kruger insight, depth-vs-breadth
- [[deep-knowledge-tracing-practical-evaluation]] — EDM 2025 KT production-realities paper
- [[irec-metacognitive-scaffolding-arxiv]] — Critique of de-contextualized SRS, JITAI alternative

### Source pages — Gamification + UX patterns

- [[gamification]] — XP/streaks/leagues/goal-gradient mechanics + anti-patterns
- [[duolingo-new-learning-path]] — Path-as-SRS UI pattern (2022 redesign)
- [[duolingo-learning-strategy]] — Gamification + AI synthesis (15-20min sessions, Crown hovering)
- [[apple-watch-psychology-gamification]] — Goal-gradient rings, social reinforcement, automaticity

### Key takeaways for ring design

1. **Path B (empirical decay curves)** is empirically grounded — TTO has 6 years of data, can compute per-skill `h` without full ML infrastructure (HLR-style) but with more accuracy than fixed Leitner intervals
2. **Practice ring rewards productive struggle** matches Manu Kapur's productive failure research and Apple Watch's "outcomes vary" finding (intrinsic motivation matters)
3. **15-20min daily session** is empirically optimal per Duolingo — directly informs daily-fill cadence
4. **Anti-pattern: time-on-task** — Duolingo + Apple Watch both warn against engagement metrics that don't correlate with learning outcomes
5. **Visual ring goal-gradient** is the central UX mechanism (Apple Watch, Duolingo path-progression)
6. **"Practice as forward progress"** reframing (Duolingo path) avoids "going back" psychology
7. **Dunning-Kruger drop** (KST C-7 pilot) = expect Week 1 self-assessment to be inflated; coach assessment Week 2 corrects
8. **Depth vs breadth** (KST Laura Rivas case) — plateau in new skills can hide significant deepening; ring viz should surface both
