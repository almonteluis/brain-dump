---
description: Jessica Kerr on applying TDD principles to agent workflows — verification before implementation for documentation updates
tags:
  - TDD
  - documentation
  - verification
  - jessitron
  - agent/workflow
sources:
  - Adding Correctness Conditions to Code Changes.md
created: 2026-04-28
updated: 2026-04-28
---

# Adding Correctness Conditions to Code Changes

**Source:** `Adding Correctness Conditions to Code Changes.md` (jessitron.com)
**Date ingested:** 2026-04-28
**Type:** Blog post / methodology
**Author:** Jessica Kerr (Jessitron)

## Summary

Jessica Kerr applies TDD principles to coding agent workflows. When a PR added a run script but didn't update the README, she didn't comment on the PR — she asked how to fix this for *all* PRs. The answer: verification before instructions.

## The Correctness Condition

> All PRs include updates to all relevant documentation files.

## Two Approaches

### Instructions First (Easy, Wrong)

Change `AGENTS.md` to tell the agent to look for documentation files and update them.

**Problem:** Will work most of the time. But when it fails on a future PR, will you notice? If you're scanning PRs at that level of detail, "we have failed to automate enough of this project."

### Validation First (Harder, Right)

Add a reviewer agent that checks each PR for missed documentation updates. Incorrect PRs get rejected.

**Result:** The correctness condition is guaranteed. The instructions change becomes an *optimization*, not a requirement.

## Key Insight

> "It's a little like test-first development, but at a higher level. We're adding a check to every feature implementation, not just one."

> "It's more like property testing than unit testing. We aren't hard-coding 'every feature should update the README.' We're stating a property: the documentation should be up-to-date after every feature change."

## The New Boy Scout Rule

Old: "Leave the codebase cleaner than I found it."  
New: "Make the whole development system stronger than it was."

## Concepts Covered

- [[agent-verification]] — Verification agents as gates in the development pipeline
- [[property-testing]] — Stating invariants rather than hard-coding examples
- [[tdd-at-scale]] — Applying test-first principles to development systems, not just code
- [[documentation-sync]] — Keeping docs in sync with code automatically

## Related

- [[teame-218-brainbreak-postmortem]] — PR review and counter-arguments
- [[agent-self-check-framework]] — MISS/FIX logging for agent improvement
