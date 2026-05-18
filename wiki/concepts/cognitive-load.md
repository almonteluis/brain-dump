---
description: Cognitive load is why a kid who can add single digits fine suddenly melts down when you hand them three-digit addition with carrying. Working memory has ~4 slots and Sweller's theory explains what fills them.
tags:
  - concept
  - cognitive/load
  - working-memory
  - instructional-design
  - pedagogy
sources:
  - Sweller, J. (1988). Cognitive load during problem solving. Cognitive Science, 12(2).
created: 2026-05-16
updated: 2026-05-16
---

# Cognitive Load

Cognitive load is the reason a kid who can add single digits fine will melt down when you hand them three-digit addition with carrying. Working memory has about 4±1 slots. When you fill all of them — with the numbers, the carrying procedure, the place value tracking, the anxiety about getting it wrong — there's no room left for actually *understanding* what's happening. The kid is computing, but they're not learning.

Sweller laid this out in 1988. Three types of load:

| Type | What fills it | What you do about it |
|------|-------------|---------------------|
| **Intrinsic** | The actual complexity of the material. Can't remove it. | Manage it — break into smaller pieces, sequence prerequisites. |
| **Extraneous** | Bad design. Confusing instructions, split attention, unnecessary info. | *Eliminate it.* This is the low-hanging fruit. |
| **Germane** | The mental work of building schemas — connecting new stuff to what you already know. | *Maximize it.* This is where learning actually happens. |

The math is brutal: intrinsic + extraneous + germane has to fit in ~4 slots. If extraneous load eats 2 of them (bad UI, unclear instructions, split attention between two sources), you've got 2 slots left for actual learning. Cut the extraneous junk and germane load doubles.

## Why It Matters for ATLAS

[[project-atlas]] has to manage cognitive load at every level:

- The [[skill-graph]] controls intrinsic load — if a skill is too complex, break it into smaller prerequisite nodes
- The UI controls extraneous load — clean interface, focused feedback from [[adaptive-feedback-education]], no unnecessary noise
- The pedagogical design controls germane load — [[productive-struggle]] is *designed* to activate schema building, but only if the kid has enough bandwidth to actually build the schema

[[zone-of-proximal-development]] is essentially "intrinsic load fits in working memory when [[scaffolding]] is available." [[math-anxiety]] eats working memory slots directly — a kid who's anxious about math has fewer available slots for the actual math, which is why anxious kids underperform even when they *know* the material.

The design tension that keeps coming up: [[productive-struggle]] requires cognitive effort, but too much effort = overload. The line between "productive" and "destructive" isn't about the problem difficulty — it's about total load. A medium-difficulty problem with a confusing interface and an anxious kid can overload where the same problem with a calm kid and clean design wouldn't. The system has to read more than just correctness — it has to read *capacity*.
