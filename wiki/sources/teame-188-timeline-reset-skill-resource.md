---
description: Timeline resets when students leave and return to Skill Resource page after multiple assessment iterations — suspected useEffect dependency regression
tags: ["TEAME-188", "react", "useEffect", "state-management", "timeline", "regression", "learnosity"]
sources: ["TEAME-188.md"]
created: 2026-04-30
updated: 2026-04-30
---

# TEAME-188: Timeline Reset After Leaving Skill Resource Page

**Source:** TEAME-188.md
**Date ingested:** 2026-04-30
**Type:** work-ticket
**Ticket:** TEAME-188
**Parent:** TEAME-166 (Investigate Long-Term Learnosity Stability)

## Summary

When students take a Skill Assessment multiple times within the same iteration on the Skill Resource Page, then leave the page, return to Home, and go back to the same Skill Resource Page, the timeline is reset and does not display the history of previous iterations. The behavior is intermittent/random. Database records are correct, indicating a frontend state issue.

## Key Claims

- Timeline fails to re-render with updated state when returning to the Skill Resource Page
- Database shows all previous iteration results correctly — not a data persistence issue
- Behavior is random/intermittent, not consistently reproducible
- Sam Saarinen suspects a fragile `useEffect` whose dependencies changed, causing the timeline to fail to re-render when updated state is available
- Maria Canteras confirmed this was not happening on Demo as of 2025-10-30, suggesting a regression

## Root Cause Hypothesis

Fragile `useEffect` dependency array — the timeline component and state management may not be robust enough to handle state updates correctly when the component re-mounts after navigation away and back.

## Context

- Sub-defect under TEAME-166 (Investigate Long-Term Learnosity Stability)
- Assigned to Luis Almonte
- Reported by Maria Canteras (QA)
- Sprint: Team E Sprint 48
- Has video reproduction and screenshot attachments

## Entities Mentioned

- [[teame-166-learnosity-stability]] — Parent story
- [[learnosity]] — Assessment platform integration
- [[skill-resource-page]] — Student-facing skill assessment UI

## Concepts Covered

- [[react-useeffect-patterns]] — Fragile dependency arrays causing missed re-renders
- [[state-management]] — Timeline state not persisting across navigation
- [[regression-testing]] — QA verification that bug was not present on Demo
