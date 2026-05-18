---
description: Spaced repetition is Anki-pilled — it works, but it works on facts. Review stuff at increasing intervals, watch retention spike. The entire SRS industry sits on one 1885 finding about forgetting.
tags:
  - concept
  - spaced/repetition
  - memory
  - learning
  - srs
  - forgetting-curve
sources:
  - Ebbinghaus, H. (1885). Über das Gedächtnis.
  - Pimsleur, P. (1967). A memory schedule. The Modern Language Journal, 51(2), 73–75.
  - Wozniak, P. A. (1990). Optimization of repetition spacing in the practice of learning.
created: 2026-05-16
updated: 2026-05-16
---

# Spaced Repetition

Spaced repetition is the idea that you remember things better when you review them at increasing intervals instead of cramming. That's the whole pitch. It's been replicated more times than any other finding in memory research, and it powers everything from [[duolingo]] to Anki to medical board prep.

The lineage is almost comically clean:

| Year | Person | Contribution |
|------|--------|-------------|
| 1885 | [[hermann-ebbinghaus]] | Discovered the forgetting curve. Self-experimented with nonsense syllables. |
| 1967 | [[paul-pimsleur]] | Graduated-interval recall — the first algorithmic spacing schedule, for language learning. |
| 1972 | [[sebastian-leitner]] | Box system — physical flashcards in escalating intervals. SRS for people who don't own a computer. |
| 1987 | Piotr Wozniak | SM-2 algorithm — the math behind SuperMemo and Anki. |
| 2016 | [[burr-settles]] | Half-Life Regression — [[duolingo]]'s data-driven take, replacing hand-tuned parameters with regression. |

Each generation takes the same core insight — *spacing works* — and operationalizes it better.

## How It Actually Works

You see a fact. You recall it (or fail to). The algorithm schedules the next review. If you got it right, the interval grows — maybe 1 day → 3 days → 10 days → 30 days. If you got it wrong, the interval collapses back to the start. The spacing curve looks like a staircase where each step is taller than the last.

The key mechanism: **retrieval right before the forgetting point** is what cements the memory. Review too early and you're wasting time. Review too late and you're re-learning, not recalling. The algorithm's entire job is to hit that sweet spot.

## The Tension: SRS Meets Math

Here's the problem for platforms like [[teach-to-one]]: spaced repetition is *fantastic* for facts. Vocabulary, anatomy, state capitals. But math isn't facts. "Reviewing" the quadratic formula at increasing intervals doesn't build conceptual understanding — it builds a reflex. You can recite the formula and have no idea when to deploy it.

[[encoding-specificity-principle]] throws another wrench in: if you learned something in one context and SRS reviews it in a stripped-down flashcard context, the retrieval cue doesn't match the encoding context. You get good at *the flashcard*, not the underlying skill.

This is why [[insight-recall]] exists as an alternative paradigm — surfacing the student's *own past thinking* at relevant moments, not just the content. And it's why [[three-ring-mastery-system]] layers spaced repetition on top of [[knowledge-tracing]] rather than treating SRS as the whole solution. The spacing handles retention; the knowledge tracing handles the "do they actually understand this?" question.

The open thread: what if the real unlock isn't *when* you review, but *what context you're in when you review*? That's the bet [[project-atlas]] is making, and it's where it starts to get interesting — spacing driven by mastery estimates, not just time.
