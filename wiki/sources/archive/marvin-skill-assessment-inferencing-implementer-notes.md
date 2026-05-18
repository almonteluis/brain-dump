---
description: Implementation notes for skill assessment inferencing — validation, skill inference lookup, state updates, and event dispatching
tags:
  - source
  - work
  - marvin
  - inference
  - implementation
  - skill/assessment
  - graphql
  - skill/state
sources:
  - Skill Assessment Inferencing Implementer's notes - Marvin.md
created: 2026-04-30
updated: 2026-04-30
---

# Marvin Skill Assessment Inferencing Implementer's Notes

**Source:** `Skill Assessment Inferencing Implementer's notes - Marvin.md` (Confluence)
**Date ingested:** 2026-04-30
**Type:** Implementation specification
**Project:** Marvin inferencing system
**System:** Inference Engine

## Summary

Step-by-step implementation guide for processing a completed skill assessment and producing student skill state updates. The inference engine persists updates and sends events to the event dispatcher.

## Input

- `student_id` — Global Object ID format (`StudentNode:...`)
- `student_skill_assessment_id` — Global Object ID format (`StudentSkillAssessmentNode:...`)

## Phase 1: Validation

### 1.1 Validate Skill Assessment ID
- Must be a string
- Must be Global Object ID format with `StudentSkillAssessmentNode` type
- Query `studentSkillAssessmentById` for `skill.id`, `score`, `maxScore`, `student.id`

### 1.2 Validate Student ID
- Must be a string
- Must be Global Object ID format with `StudentNode` type
- Query `studentById` and verify `isActive = true`

### 1.3 Cross-Validation
- Payload student ID must match retrieved StudentSkillAssessment's student ID
- Score must be at or above passing threshold (0.8 = 80%)

**Error handling:** Log specific error message and stop for any validation failure.

## Phase 2: Determine Inferred Skills

1. Query `activeSkillInferencesByBaseSkillId` where:
   - `BaseSkill.Id` = assessed skill's ID
   - `SkillInference.IsActive` = true
   - `SkillInference.InferredSkill.IsActive` = true

2. Filter out skill inferences where student has existing `StudentSkillState`:
   - `SkillState = Not Complete`
   - `SkillStateReason` in: Teacher Designated, Teacher Placed Out, Skill Inactive

3. Extract `InferredSkill` from remaining inferences

## Phase 3: Determine New Incomplete Skills

New incomplete skills = active skills not already in student's skill states and not inferred by the demonstrated skill.

1. Query `skillStatesByStudentId` for all student skill states
2. Query `allActiveSkills` for all active skills
3. Select skills where:
   - Skill.ID not in any StudentSkillState.Skill.ID
   - Skill.ID not in inferred skills list
   - Skill.ID not equal to demonstrated skill ID

## Phase 4: Prepare Skill State Updates

Common fields for all updates:
- `StudentSkillState.Student.Id` = input student ID
- `StudentSkillState.SkillAssessment.Id` = input assessment ID
- `StudentSkillState.Diagnostic` = null
- `StudentSkillState.SkillStateReason` = **Skill Assessment Updated**

### Update Types

| Type | SkillState | Skill.ID Source |
|------|------------|-----------------|
| Demonstrated skill | Demonstrated | Retrieved assessment's skill ID |
| New incomplete skills | Not Complete | Each new active skill ID |
| Inferred skills | Inferred | Each inferred skill ID |

## Phase 5: Send Updates

1. Log: `There are {count} skills to update after performing inferencing for {assessment_id} of {student_id}.`
2. Call `upsertStudentSkillStates` with prepared updates
3. Send `Skill States Updated` Kinesis event:
   - `updated_skills`: JSON array of skill IDs that were Inferred or Demonstrated
4. Log: `Student skill assessment {id} has finished inferencing.`

## GraphQL Operations

### Queries
- `studentSkillAssessmentById` — retrieve assessment data
- `studentById` — retrieve student (check isActive)
- `activeSkillInferencesByBaseSkillId` — find inferrable skills
- `skillStatesByStudentId` — retrieve existing student skill states
- `allActiveSkills` — retrieve all active skills

### Mutations
- `upsertStudentSkillStates` — bulk create/update skill states

## Event Format

**Skill States Updated Event** (Kinesis):
- `type`: "Student Skill States Updated"
- `source_user_id`: (TBD — to agree on user)
- `priority`: 1
- `created_on`: UTC ISO-8601 timestamp
- `version`: 1.0.1
- `payload.updated_skill_states`: array of skill IDs
- `payload.student_id`: from input payload

## Passing Threshold

`Score / MaxScore >= 0.8` (80%)

Below threshold: log informational message and stop without inferencing.

## Related

- [[marvin-inferencing-v2]] — Full architecture specification
- [[marvin-diagnostic-inferencing-functional-requirements]] — Diagnostic inferencing requirements
- [[marvin-example-skill-assessment-json-response]] — Example Learnosity response data
- [[inference-engine]] — Inference Engine service page
- [[learnosity-result-fetcher]] — Lambda providing assessment data
