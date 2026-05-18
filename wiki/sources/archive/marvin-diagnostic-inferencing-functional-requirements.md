---
description: Functional requirements and acceptance criteria for diagnostic inferencing — user stories, formula weights, and skill state determination rules
tags:
  - source
  - work
  - marvin
  - inference
  - requirements
  - diagnostics
  - skill/state
sources:
  - Diagnostic Inferencing Functional Requirements - Marvin.md
created: 2026-04-30
updated: 2026-04-30
---

# Marvin Diagnostic Inferencing Functional Requirements

**Source:** `Diagnostic Inferencing Functional Requirements - Marvin.md` (Confluence)
**Date ingested:** 2026-04-30
**Type:** Functional requirements specification
**Project:** Marvin inferencing system

## Summary

User stories and acceptance criteria for the diagnostic inferencing subsystem. Defines how the system calculates student result scores from diagnostic assessment data and determines skill states (Inferred vs Not Complete).

## User Stories

| ID | Requirement |
|----|-------------|
| INF-DG-R001 | Calculate ability distance value for a skill: `ability estimate - difficulty` (Part B, or Part A if no B) |
| INF-DG-R003 | Count skills a student could infer from passing a skill after diagnostic |
| INF-DG-R004 | Count questions answered correctly for each skill on diagnostic |
| INF-DG-R005 | Count questions answered incorrectly for each skill on diagnostic |
| INF-DG-R006 | Calculate result score for Part B: weighted sum of ability distance, inferred skills count, correct answers, incorrect answers |
| INF-DG-R007 | Calculate result score for Part A (if no Part B): same formula using Part A values |
| INF-DG-R008 | Calculate result score for Part C (if no Part A or B): sum without ability distance |
| INF-DG-R012 | If only ability distance is available, use it without any multiplier/weight/coefficient |
| INF-DG-R009 | If result score >= 0.3, set skill state to Inferred |
| INF-DG-R010 | If result score < 0.3, set skill state to Not Complete |
| INF-DG-R011 | Update ability estimate for the skill when updating skill states |

## Acceptance Criteria

### AC-1: Ability Distance Calculation (Non-Part-C)
**Given:** A student submits any Diagnostic and is not part C
**When:** Inferencing System is called
**Then:** Calculate `ability distance value = ability estimate - skill difficulty` for each skill; hold for later use

### AC-2: Inferred Skills Count
**Given:** A student submits any diagnostic
**When:** Inferencing System is called
**Then:** Count skills inferred after diagnostic; hold for later use

### AC-3: Correct Answers Count
**Given:** A student takes any diagnostic
**When:** Inferencing System is called
**Then:** Count correctly answered questions per skill; hold for later use

### AC-4: Incorrect Answers Count
**Given:** A student takes any diagnostic
**When:** Inferencing System is called
**Then:** Count incorrectly answered questions per skill; hold for later use

### AC-5: Part B Formula
**Given:** Student submitted diagnostic, Part B found
**When:** Calculating results
**Then:** Use Part B values:
```
student results = (abilityDistance * 0.21) + (countOfInferredSkills * 0.31) + (correctlyAnsweredQuestions * 0.31) + (incorrectlyAnsweredQuestions * -0.22)
```

### AC-6/7: Part A Fallback
**Given:** No Part B found
**When:** System looks for Part A
**Then:** Use Part A values with same formula as AC-5

### AC-8/9: Part C Fallback
**Given:** No Part B nor Part A
**When:** System finds Part C
**Then:** Use Part C values (no ability distance):
```
student results = (countOfInferredSkills * 0.31) + (correctlyAnsweredQuestions * 0.31) + (incorrectlyAnsweredQuestions * -0.22)
```

### AC-10: Ability-Distance-Only Fallback
**Given:** Student completed diagnostic, cannot find inferred skills count, correct answers, or incorrect answers
**When:** Calculating student results
**Then:** `student results = abilityDistance` (no multipliers)

### AC-11: Inferred Threshold
**Given:** Result score >= 0.3
**When:** Setting skill states
**Then:** Set skill state to Inferred

### AC-12: Not Complete Threshold
**Given:** Result score < 0.3
**When:** Setting skill states
**Then:** Set skill state to Not Complete

### AC-13: Ability Estimate Update
**Given:** Result score calculated
**When:** Setting skill states
**Then:** Update ability estimate for the skill

## Formula Weights

| Component | Weight | Condition |
|-----------|--------|-----------|
| Ability Distance | 0.21 | Part A/B only |
| Count of Inferred Skills | 0.31 | All parts |
| Correctly Answered Questions | 0.31 | All parts |
| Incorrectly Answered Questions | -0.22 | All parts |

## Thresholds

| Threshold | Value | Action |
|-----------|-------|--------|
| Inferred | >= 0.3 | Set `SkillStateNode:2` (Inferred) |
| Not Complete | < 0.3 | Set `SkillStateNode:1` (Not Complete) |

## Related

- [[marvin-inferencing-v2]] — Full architecture specification
- [[marvin-skill-assessment-inferencing-implementer-notes]] — Skill assessment implementation
- [[inference-engine]] — Inference Engine service page
- [[diagnostic-inferencing-formula]] — Concept page for the scoring formula
