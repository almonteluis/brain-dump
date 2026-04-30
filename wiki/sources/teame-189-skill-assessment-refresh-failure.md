---
description: Skill assessment fails to load after page refresh when timeline has previous attempts — involves state management and page lifecycle
tags: ["TEAME-189", "react", "page-refresh", "state-management", "skill-assessment", "learnosity"]
sources: ["TEAME-189.md"]
created: 2026-04-30
updated: 2026-04-30
---

# TEAME-189: Skill Assessment Fails to Load After Page Refresh

**Source:** TEAME-189.md
**Date ingested:** 2026-04-30
**Type:** work-ticket
**Ticket:** TEAME-189
**Parent:** TEAME-166 (Investigate Long-Term Learnosity Stability)

## Summary

When on the Skill Resource Page for a skill that has more than one iteration of Skill Assessments taken in the past, starting a new iteration, answering a couple of questions, and then refreshing the page causes the Practice Problems and Skill Assessment "Start" button to not load.

## Key Claims

- Issue occurs specifically when the timeline has previous assessment attempts
- Triggered by page refresh during an active assessment iteration
- Practice Problems and Start button fail to load after refresh
- Sam Saarinen noted a brief flash of more than 3 skills on initial load in the reproduction video — potentially a separate UI issue
- Maria Canteras thought the "more than 3 skills" flash was a known bug with an existing ticket

## Root Cause Hypothesis

State not being properly rehydrated or re-fetched after page refresh. The component may depend on transient state that is lost on refresh, or the data fetch on re-mount may not correctly handle the case where previous attempts exist in the timeline.

## Context

- Sub-defect under TEAME-166 (Investigate Long-Term Learnosity Stability)
- Assigned to Luis Almonte
- Reported by Maria Canteras (QA)
- Sprint: Team E Sprint 48
- Has video reproduction attachment

## Related Issues

- [[teame-188-timeline-reset-skill-resource]] — Related timeline state issue under same parent
- [[teame-166-learnosity-stability]] — Parent investigation story

## Concepts Covered

- [[state-management]] — State rehydration after page refresh
- [[react-lifecycle]] — Component mount behavior with existing data
- [[learnosity]] — Third-party assessment integration state handling
