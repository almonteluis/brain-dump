---
description: "Implementation notes for adding readiness score tracking to assignment creation logging via GraphQL and telemetry"
tags: [graphql, relay, telemetry, logging, work, readiness-score]
sources: ["TEAME-246 Assignment Creation Logging - Readiness Score Tracking.md"]
created: 2026-04-09
updated: 2026-04-09
---

# TEAME-246: Assignment Creation Logging - Readiness Score Tracking

**Source:** raw/01_thinking/notes/TEAME-246 Assignment Creation Logging - Readiness Score Tracking.md
**Date ingested:** 2026-04-09
**Type:** thinking note

## Summary

Implementation notes for adding readiness score tracking to assignment creation logging. Backend and frontend changes to expose readiness scores through GraphQL and track them in telemetry.

## Status

**Complete — Ready for Dev Testing**

## What Was Implemented

### Backend (C# GraphQL Service)

| File | Change |
|------|--------|
| `graphql-service/Nc.GraphQL.Service/Schema/Outputs/SkillStatus.cs` | Added `ReadinessScore` property |
| `graphql-service/Nc.GraphQL.Service/Schema/Queries/Query.StudentSkillAndPredecessorsProgress.cs` | Include `ReadinessScore` in query projection |

### Frontend (TypeScript/Relay)

| File | Change |
|------|--------|
| `frontend/schema.graphql` | Added `readinessScore: Float` to `SkillStatus` type |
| `frontend/src/graphQLOperations/Assignment.ts` | Added `readinessScore` to GraphQL query |
| `frontend/src/businessLogicService/trackAssignments.ts` | Added `studentReadinessScores?: number[]` to interface |
| `frontend/src/components/AssignmentSidebar/AssignmentSidebarContainer.tsx` | Updated `Student.skills` type |
| `frontend/src/components/AssignmentSidebar/AssignmentSidebarStudentsList.tsx` | Map `readinessScore` from GraphQL response |
| `frontend/src/components/AssignmentSidebar/AssignmentSidebarPreview.tsx` | Extract and pass readiness scores to `trackAssignment` |

## Current State

- **Commits ready:** Backend and frontend changes staged separately
- **Readiness scores returning `null`:** Expected behavior — the `ReadinessScoreCalculator` Lambda (in `roadmap-builder` service) populates these values
- **Frontend handles nulls gracefully:** Telemetry omits missing scores via `.filter((rs): rs is number => rs !== undefined && rs !== null)`

## Next Steps for Dev Testing

1. Deploy backend changes to dev
2. Deploy frontend changes to dev
3. Trigger `ReadinessScoreCalculator` Lambda for test students:
   ```json
   {"student_id": "UserNode:10", "updated_skill_states": ["SkillNode:322"]}
   ```
4. Create an assignment and verify `readiness_score_*` observations are logged

## Concepts Covered

- [[GraphQL Schema Evolution]] — Adding fields to existing types
- [[Relay Query Updates]] — Modifying fragments to include new fields
- [[Telemetry Integration]] — Tracking data through business logic layer
- [[Null Handling]] — Graceful handling of optional data

## Related

- [[relay-fragment-composition]]
- [[relay-mutations-guide]]
