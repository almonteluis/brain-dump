---
description: "Research References — Orchestrator + Three-Ring Concept"
tags: ['research']
raw_file: "references-seed.md"
created: 2026-05-17
---

# Research References — Orchestrator + Three-Ring Concept

Seed sources for the orchestrator/three-ring idea. Organized by theme. Each entry has a one-line "why this matters" so Second Brain has signal for synthesis and graphify has anchor text for relationship extraction.

For graphify ingestion, you can also batch these via `graphify add <url> --author "..." --contributor "Luis"` — keeps provenance in the graph.

---

## Theme 1: Hierarchical / prerequisite-aware spaced repetition

The closest existing implementation of the "maintenance ring" concept. Math Academy has built almost exactly this for adult learners — encompassing graph, prerequisite-aware resurfacing, fractional credit propagation. Read these first.

### Justin Skycak — Optimized, Individualized Spaced Repetition in Hierarchical Knowledge Structures
https://www.justinmath.com/individualized-spaced-repetition-in-hierarchical-knowledge-structures/
*The original FIRe (Fractional Implicit Repetition) writeup. Encompassing graph vs prerequisite graph distinction. Trickle-down credit, trickle-up penalties. Most relevant single source for the maintenance-ring mechanic.*

### Math Academy — How Our AI Works
https://mathacademy.com/how-our-ai-works
*Product-side framing of FIRe. Knowledge profile visualization, mastery/review/remediation flow. Useful for thinking about teacher and student-facing surfaces.*

### Math Academy — Pedagogy
https://www.mathacademy.com/pedagogy
*Layering, mastery learning, deliberate practice, automaticity. The pedagogical foundations behind FIRe — useful for the "why this works for middle schoolers too" framing.*

### Frank Hecker — Math Academy Part 7: Technology Brief
https://frankhecker.com/2025/02/14/math-academy-part-7/
*Independent technical breakdown of FIRe. "Credit travels downwards like lightning, penalties travel upwards like growing trees." Good plain-English explanation if Skycak's post is too dense.*

### Andy Matuschak — Notes on Math Academy
https://notes.andymatuschak.org/Math_Academy
*Critical eval from a serious learning-tools researcher. Notes the "black-box queue" problem and that grouping review by topic in advance probably hurts transfer. Important counterpoint for the maintenance-ring UX.*

### Justin Skycak — Cognitive Science of Learning: Spaced Repetition (Distributed Practice)
https://www.justinmath.com/cognitive-science-of-learning-spaced-repetition/
*The full chapter from The Math Academy Way. Spacing effect, repetition compression, calibration. Foundational background.*

---

## Theme 2: Memory models and adaptive scheduling (Duolingo)

Duolingo's HLR is the prediction-model layer that the maintenance ring would need (or a simpler approximation of). Their path redesign is also the closest UX precedent for "review built into forward progress."

### Duolingo — How We Learn How You Learn (HLR)
https://blog.duolingo.com/how-we-learn-how-you-learn/
*Half-Life Regression. Per-item memory decay model trained on billions of practice events. Shows what a real production-scale "what to resurface when" model looks like.*

### Duolingo — Introducing the new Duolingo learning path
https://blog.duolingo.com/new-duolingo-home-screen-design/
*The 2022 path redesign. Key principle: review is forward progress, not "going back." Direct precedent for the maintenance-ring framing.*

### Duolingo — Keeping you at the frontier of learning with adaptive lessons
https://blog.duolingo.com/keeping-you-at-the-frontier-of-learning-with-adaptive-lessons/
*Real-time difficulty adaptation within a lesson plus mistakes-focused practice sessions. ZPD framing.*

---

## Theme 3: Ring/streak psychology and multi-goal habit loops

The visual and motivational template for the three-ring system. Each ring targeting a different motivation, unified into one daily/weekly close.

### Trophy — The Psychology of Apple Watch's "Close Your Rings"
https://trophy.so/blog/the-psychology-of-apple-watchs-close-your-rings
*Gestalt closure, sunk-cost streak bias, multi-archetype targeting. Best single article on why the ring metaphor works.*

### Beyond Nudge — The Psychology Behind Apple Watch
https://www.beyondnudge.org/post/casestudy-apple-watch
*Behavioral science framing. Goal-tracking, gamification, haptic feedback as habit cues, automaticity as the ultimate goal.*

---

## Theme 4: Spaced repetition foundations (general)

Background reading. Read if you want depth on the underlying science, but Math Academy material covers most of what's needed for the pitch.

### Gwern — Spaced Repetition for Efficient Learning
https://gwern.net/spaced-repetition
*Long, deep treatment. Useful for context but probably out of scope for the immediate pitch.*

### Wikipedia — Spaced Repetition
https://en.wikipedia.org/wiki/Spaced_repetition
*Standard reference. Worth keeping for the basics.*

---

## Theme 5: Critique of standard SRS (worth reading)

### Irec: A Metacognitive Scaffolding for Self-Regulated Learning through Just-in-Time Insight Recall
https://arxiv.org/pdf/2506.20156
*This is the surprise gem. Critiques standard SRS for being **de-contextualized** — review cards pop up disconnected from the problem-solving context where the knowledge was encoded. Argues for context-aware, just-in-time recall instead.*

*Direct intellectual support for the "forward-looking, prerequisite-aware, just-in-time" framing of the maintenance ring vs. backward-looking flashcard-style review. Cite this when explaining why this isn't just "Anki for math class."*

---

## Theme 6: Internal context (placeholder)

To be filled in from your own notes:
- Existing weekly-goal ring component — implementation, header redesign context
- BrainBreak architecture — how the orchestrator framing relates to existing emotion/confidence flow
- Practice problems — current data model, how points are awarded
- Math curriculum structure — does prerequisite graph data already exist anywhere?
- Smart Grouping / teacher surfaces — does ring state need to feed into these?

*Keep this internal context in your private notes. Don't dump tickets, Slack, or internal docs into the graphify input.*

