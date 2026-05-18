---
description: Duolingo blog post on November 2022 home screen redesign — replaced skill tree with linear path, interspersing skill-levels for built-in spaced repetition, practice baked into path
tags:
  - source
  - learning
  - ux
  - spaced/repetition
  - duolingo
  - design
  - gamification
sources:
  - Introducing the new Duolingo learning path.md
created: 2026-05-03
updated: 2026-05-03
---

# Introducing the New Duolingo Learning Path

**Source:** [blog.duolingo.com/new-duolingo-home-screen-design](https://blog.duolingo.com/new-duolingo-home-screen-design/) — Holly Munson, Anton Yu, Ananya Rajgarhia, AJ Noh, 2022-05-06
**Date ingested:** 2026-05-03
**Type:** Product redesign blog
**Launched:** 2022-11-01

## Summary

Duolingo replaced its long-standing skill tree home screen with a **linear path** in November 2022. Each circle on the path = one crown level of a skill. Levels from different skills are **interspersed across the path** so learners get spaced repetition automatically, without needing to manually plan a "hover method" review schedule. Practice and Stories are baked into the path rather than separate tabs. Feature labels were rewritten to be descriptive ("get directions" instead of "City 3").

## What Changed

| Old (skill tree) | New (linear path) |
|---|---|
| Tree of skills, each with 5 crown levels | Single linear path, each circle = 1 crown level |
| Practice as separate "cracked skill" tab | Practice baked into path |
| Stories as separate tab | Stories embedded in path circles |
| Tips appearing before lessons | Tips moved to per-unit "guidebook" |
| Skill-level Legendary status | Unit-level Legendary status |
| Monthly challenges + Quests scattered | Quests tab (chest icon) in bottom menu |

## Science: Spaced Repetition by Design

The path **interleaves levels from different skills**. Learner faces a mix of new concepts + previously-introduced concepts they need to review.

> The ordering of lessons in the path is grounded in spaced repetition... Basically, it's more effective to space out practice for a particular concept than to cram. When you initially learn a concept, you'll want to revisit it fairly soon after, but then you can gradually expand the time between practice sessions.

Previously called the "hover method" (or "waterfall method") — Duolingo's recommended manual approach. New path makes this **the default**.

## Practice Built Into the Path

> Reviewing concepts and vocabulary is an important part of language learning, but it shouldn't feel like you're "going back" to "old" lessons. Practice is also forward progress, and now, it's built into your daily lessons!

This reframes practice as **forward progress** rather than backtracking — directly addresses the psychology of "tending a living tree" vs "being stuck reviewing".

## Stories Inline

Stories now embedded as circles in the path (book icon) rather than separate Stories tab. Reading + listening practice + ambient grammar exposure happen at scheduled intervals like other lessons.

## Migration Logic

| Asset | Migration |
|---|---|
| **Lessons** | All progress preserved. Some users start earlier in path to complete missing levels. |
| **Legendary** | If >50% of unit's levels were Legendary, whole unit marked Legendary. |
| **Stories** | Repositioned in path by difficulty. Some previously-read stories may reappear (consistent with practice-is-progress principle). |

## Practice Hub for Super Subscribers

Practice Hub became a tab (barbell icon) in the bottom menu. Multiple sets of practice sessions available.

## Key Claims

- Linear path = automatic implementation of spaced repetition without user planning
- "Practice is forward progress" reframes review psychologically — directly counters the "going back" mental model
- Interspersing levels from different skills creates desirable difficulty
- Stories + practice baked into path is more effective than as separate tabs (UX collapse)
- Old skill tree allowed users to over-optimize one skill before moving on; path enforces breadth-first by default

## Entities Mentioned

- [[duolingo]] — Language learning platform
- [[Holly Munson]], [[Anton Yu]], [[Ananya Rajgarhia]], [[AJ Noh]] — Authors

## Concepts Covered

- [[spaced-repetition]] — Spacing built into UX
- [[interleaving]] — Mixing concepts across path
- [[gamification]] — Path metaphor + characters
- [[progressive-disclosure]] — Lesson topic info on tap

## Related

- [[duolingo-half-life-regression]] — HLR drives practice content selection
- [[duolingo-learning-strategy]] — Gamification + SRS playbook
- [[spaced-repetition-wikipedia]] — Canonical reference
- [[three-ring-mastery-system]] — Direct UI inspiration for ring + path design
- [[mastery-velocity-three-ring-feature-concept]] — Brainstorm referencing this pattern
