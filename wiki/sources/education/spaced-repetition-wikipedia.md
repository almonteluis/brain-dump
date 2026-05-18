---
description: Wikipedia canonical reference for spaced repetition — history (Ebbinghaus to FSRS), algorithms (Leitner, SM family, DASH, FSRS, SSP-MMC), implementations (Anki, SuperMemo, RemNote)
tags:
  - source
  - learning
  - spaced/repetition
  - algorithms
  - srs
  - wikipedia
  - reference
sources:
  - Spaced repetition.md
created: 2026-05-03
updated: 2026-05-03
---

# Spaced Repetition (Wikipedia Reference)

**Source:** [en.wikipedia.org/wiki/Spaced_repetition](https://en.wikipedia.org/wiki/Spaced_repetition)
**Date ingested:** 2026-05-03
**Type:** Wikipedia reference article

## Summary

Comprehensive Wikipedia reference for spaced repetition: history from Ebbinghaus (1880s) through Pimsleur (1967), Leitner (1973), SuperMemo (1980s), HLR (Settles 2016), and **FSRS** / **SSP-MMC** modern algorithms. Includes algorithm families, paper-flashcard implementations, software (Anki, SuperMemo, RemNote), and evidence/criticism around expanding-vs-uniform intervals.

## History Timeline

| Year | Person | Contribution |
|---|---|---|
| 1880s | Hermann Ebbinghaus | Forgetting curve, expanding-interval review |
| 1932 | C. A. Mace | "Acts of revision should be spaced in gradually increasing intervals" |
| 1939 | H. F. Spitzer | First large-scale empirical test (3600 sixth-graders, Iowa) |
| 1967 | Paul Pimsleur | Graduated-interval recall (5s/25s/2m/10m/1h/5h/1d/5d/25d/4mo/2yr) |
| 1973 | Sebastian Leitner | Leitner box system (paper flashcards) |
| 1985 | Schacter, Rich, Stampp | Extended to amnesia + memory disorders |
| 1989 | C. J. Camp | Dementia/Alzheimer's application |
| 2016 | Burr Settles (Duolingo) | Half-Life Regression (HLR) |

## Algorithm Families

- **Leitner system** — 5 levels, arbitrary study stages
- **Neural-network-based**
- **SM family** (SuperMemo) — SM-0 (paper) through SM-18 (in SuperMemo 18/19)
- **DASH** — Difficulty, Ability, Study History
- **SSP-MMC** — Stochastic Shortest Path Minimize Memorization Cost
- **FSRS** — Free Spaced Repetition Scheduler (Anki 23.10+, RemNote 1.16+)

## Paper Flashcards: Leitner System

Cards sorted into groups by knowledge strength. Recall correctly → next group (longer interval). Fail → back to first group.

**Original 1973 spec**: partition sizes 1/2/5/8/14 cm. Review only when partition full.

## Software Implementations

| Software | Algorithm | Notes |
|---|---|---|
| **Anki** | SM-2 default, FSRS opt-in (23.10+) | Open-source, billions of users |
| **SuperMemo** | SM-18 / SM-19 | Original commercial SRS |
| **RemNote** | FSRS (1.16+) | Note-taking + SRS |
| **Mnemosyne** | SM-2 variant | Open-source |
| **Quizlet** | Proprietary | Commercial education focus |

Software refinements:
- Confidence-based repetition (1-5 self-rating)
- Audio prompts for spoken-word recognition
- Auto-generated question pairs from vocabulary lists
- Online community sharing

## Domains Beyond Vocabulary

Originally limited to fact memorization. Recent applications:

- **Math** (Pashler/Rohrer/Cepeda/Carpenter 2007): spaced > massed for learning principles
- **Procedural skills** (Robertson et al 2023): six-week neurosurgery simulation showed significant proficiency improvement with structured SRS practice
- **Medical training** (Wollstein/Jabbour 2022): blunt the forgetting curve

## Evidence: Expanding vs Uniform Intervals

Mixed results. Some studies show expanding > uniform. Others find both yield similar recall. **Karpicke & Bauernschmidt 2011**: absolute spacing matters more than relative spacing pattern.

Schedule may be **learner-dependent** — general recommendations may not generalize.

## Bui et al. 2013 Working Memory Finding

Higher working memory benefits more from spaced repetition, especially on challenging tasks. Suggests SRS efficacy interacts with cognitive load capacity.

## Key Claims

- Spaced repetition is one of the most empirically-validated interventions in cognitive psychology
- Modern algorithms (FSRS, SSP-MMC) outperform classical Leitner on retention prediction
- Domain has expanded from vocabulary → math → procedural surgical skill
- Optimal schedule is likely learner-dependent — fixed schedules are a compromise
- Working memory capacity moderates SRS benefits

## Entities Mentioned

- [[hermann-ebbinghaus]], [[paul-pimsleur]], [[sebastian-leitner]], [[piotr-wozniak]], [[burr-settles]]
- [[Anki]], [[SuperMemo]], [[RemNote]], [[Mnemosyne]], [[Quizlet]]

## Concepts Covered

- [[spaced-repetition]] — Core concept
- [[forgetting-curve]] — Ebbinghaus model
- [[half-life-regression]] — Duolingo HLR
- [[fsrs-algorithm]] — Modern open-source scheduler
- [[testing-effect]] — Retrieval-induced retention boost
- [[lag-effect]] — Expanding intervals beat fixed
- [[spacing-effect]] — Distribution > massing

## Related

- [[teachers-guide-spaced-repetition]] — Classroom playbook
- [[duolingo-half-life-regression]] — Modern SRS algorithm at scale
- [[duolingo-new-learning-path]] — Path-as-SRS UI pattern
- [[three-ring-mastery-system]] — TTO mastery feature application
