---
description: Comprehensive architecture specification for Marvin/Kermit assessment inferencing — diagnostic and skill assessment flows, formulas, validation, and GraphQL operations
tags: [source, work, marvin, inference, architecture, lambda, csharp, graphql, assessment, skill-state]
sources: ["Inferencing v2 - Marvin.md"]
created: 2026-04-30
updated: 2026-04-30
---

# Marvin Inferencing v2 Architecture

**Source:** `Inferencing v2 - Marvin.md` (Confluence)
**Date ingested:** 2026-04-30
**Type:** Architecture specification
**Project:** Marvin → Kermit migration
**Scope:** Diagnostic inferencing + Skill assessment inferencing

## Summary

This document specifies the first version of inferencing to be implemented in Kermit, ported from Marvin. The [[Inference Engine|inference-engine]] is deployed as an AWS Lambda (`InferenceEngine`) that receives a JSON payload with either `student_diagnostic_id` or `student_skill_assessment_id`, performs validation, runs inferencing logic, updates student skill states via GraphQL, and emits a Kinesis event.

## Payload Structure

| Field | Type | Required | Purpose |
|-------|------|----------|---------|
| `student_id` | string | Yes | Student to run inferencing for |
| `student_diagnostic_id` | string | Conditionally | Diagnostic flow — either this or `student_skill_assessment_id` |
| `student_skill_assessment_id` | string | Conditionally | Skill assessment flow — either this or `student_diagnostic_id` |

## Two Inferencing Paths

```
Payload received
    ├── student_diagnostic_id present → Diagnostic Assessment Inferencing
    └── student_skill_assessment_id present → Skill Assessment Inferencing
```

## Diagnostic Assessment Inferencing

### Validation Phase
1. **Check Diagnostic ID Exists** — validates format (`StudentDiagnosticNode:123`), queries `studentDiagnosticById`
2. **Check Student Exists and Is Active** — validates format (`StudentNode:123`), queries `studentById`, checks `isActive`
3. **Check Student ID matches Diagnostic** — compares payload student to diagnostic's student

### Inferencing Phase
1. **Check inactive skills** — find skill states for inactive skills (reason: not active)
2. **Check previously inactive now-active skills** — find skills that were inactive but are now active
3. **Retrieve diagnostic data** — full diagnostic record via `studentDiagnosticById`
4. **Retrieve ability estimate** — from `diagnosticPartsByStudentDiagnosticId`
5. **Retrieve filtered skill states** — Not Tested states with specific reasons
6. **Check all active skill states exist** — find gaps between active skills and student skill states
7. **Retrieve all active skills** — with `id` and `difficulty`

### Calculation Phase

For each skill allowed for inferencing:

1. **Ability Distance** = Skill Difficulty – Ability Estimate
2. **Count of Strong Successor Skills** — base skills that infer this skill, answered correctly
3. **Correctly Answered Questions** — diagnostic items with score > 0 for this skill
4. **Incorrectly Answered Questions** — diagnostic items with score = 0 for this skill

### Formula Selection

| Condition | Formula |
|-----------|---------|
| Part B exists (default) | `(abilityDistance * 0.21) + (countOfStrongSuccessorSkills * 0.31) + (correctlyAnswered * 0.31) + (incorrectlyAnswered * -0.22)` |
| No Part B, Part A exists | Same formula, using Part A values |
| No Part A or B, Part C exists | `(countOfStrongSuccessorSkills * 0.31) + (correctlyAnswered * 0.31) + (incorrectlyAnswered * -0.22)` (no abilityDistance) |
| Only ability distance available | `student results = abilityDistance` (no multipliers) |

### Skill State Determination

| Result Score | Skill State |
|--------------|-------------|
| >= 0.3 | Inferred (`SkillStateNode:2`) |
| < 0.3 | Not Tested (`SkillStateNode:1`) |

Previously passed skills (`SkillStateNode:3`) or tested skills can also be set to Inferred.

### Updates
- Update skill states via `upsertStudentSkillStates`
- Emit `Skill States Updated` Kinesis event with inferred skills list
- Log completion message

## Skill Assessment Inferencing

### Validation Phase
1. **Check Skill Assessment ID Exists** — validates format (`StudentSkillAssessmentNode:123`), queries `studentSkillAssessmentById`
2. **Check Student Exists and Is Active** — same as diagnostic flow
3. **Check Student ID matches Skill Assessment** — compares payload student to assessment's student
4. **Score check** — if `score / maxScore >= 0.8`, proceed; otherwise log and stop

### Inferencing Phase
1. **Retrieve all skill inferences** from base skill via `activeSkillInferencesByBaseSkillId`
2. **Retrieve filtered student skill states** — Not Tested with specific reasons, for inferred skills
3. **Determine new active skills** — compare active skills to inferred skills

### Updates
- **Not Inferred new skills** → `Not Tested` (`SkillStateNode:1`)
- **Demonstrated skill** (the assessed skill) → `Passed` (`SkillStateNode:3`)
- **Inferred skills** → `Inferred` (`SkillStateNode:2`)

All updates use reason `Skill Assessment Updated` (`SkillStateReasonNode:4`).

## Key GraphQL Operations

### Queries
- `studentDiagnosticById` — retrieve diagnostic record
- `studentSkillAssessmentById` — retrieve skill assessment
- `studentById` — retrieve student (with `isActive`)
- `skillStatesByStudentId` — retrieve student skill states (with filters)
- `allActiveSkills` — all active skills with difficulty
- `allSkills` — all skills (with `isActive` filter)
- `diagnosticPartsByStudentDiagnosticId` — diagnostic parts with ability estimate
- `activeSkillInferencesByBaseSkillId` — skill inferences for a base skill
- `activeBaseSkillIDsByInferredSkillId` — reverse lookup of skill inferences
- `correctResponsesFromDiagnosticSession` — correct responses per skill
- `diagnosticDataByStudentDiagnosticId` — diagnostic item data

### Mutations
- `upsertStudentSkillStates` — bulk create/update skill states

## Events

**Skill States Updated Event** (Kinesis):
- `type`: "Student Skill States Updated"
- `source_user_id`: student_id
- `priority`: 1
- `version`: 1.0.1
- `payload.updated_skill_states`: comma-delimited skill IDs

## Logging

All logs use structured format with:
- `timestamp` (UTC)
- `log_level`
- `message`
- `environment` (Test/Staging/Production)
- `service`: "InferenceEngine"
- `host`: hostname

## Key Functions

| Function | Purpose |
|----------|---------|
| Ability Distance Value Calculation | `difficulty - abilityEstimate` per skill |
| Count of Strong Successor Skills | Base skills inferring this skill, answered correctly |
| Count of Inferred Skills | Skills inferrable from this skill |
| Questions Answered Correctly | Diagnostic items with score > 0 |
| Questions Answered Incorrectly | Diagnostic items with score = 0 |
| Diagnostic Skill Inferencing Formula | Weighted linear combination |
| Determine Formula To Use | Select regular vs ability-distance-only formula |
| Remove Inactive Skills | Filter out inactive skills from lists |
| Skills Allowed For Inferencing | Match potential skills to active skills with difficulties |
| New Active Skills To Determine If Inferred | Categorize new skills as inferred or not |

## Related

- [[inference-engine]] — Existing inference engine wiki page
- [[marvin-diagnostic-inferencing-functional-requirements]] — Detailed functional requirements for diagnostic inferencing
- [[marvin-skill-assessment-inferencing-implementer-notes]] — Implementation notes for skill assessment inferencing
- [[marvin-example-skill-assessment-json-response]] — Example Learnosity response format
- [[learnosity]] — Third-party assessment platform
- [[learnosity-result-fetcher]] — Lambda that feeds assessment data to inference
- [[graphql-service]] — Service the Inference Engine reads/writes through
