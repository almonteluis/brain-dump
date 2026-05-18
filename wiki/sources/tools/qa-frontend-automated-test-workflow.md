---
description: Manual workflow steps for triggering qa-frontend-automated-tests GitHub Actions, monitoring CloudWatch logs, and locating S3 results
tags:
  - source
  - qa
  - github
  - automation
  - e2e
  - work
  - marvin
sources:
  - How to run the QA frontend automated test workflow - Quality Assurance.md
created: 2026-05-03
updated: 2026-05-03
---

# QA Frontend Automated Test Workflow

**Source:** `How to run the QA frontend automated test workflow - Quality Assurance.md`
**Date ingested:** 2026-05-03
**Type:** Process / runbook

## Summary

Manual GitHub Actions workflow for the **frontend test automation suite**. Triggered from `qa-frontend-automated-tests` repo. Caller picks branch, run count, and target environment. Task deploys in ~3 min, logs lag CloudWatch by ~5 min, total runtime ~20 min, results land in S3 and a Slack notification fires to `#test-automation-workflow-results`.

## Trigger Steps

1. Open the [qa-frontend-automation workflow](https://github.com/NewClassrooms/qa-frontend-automated-tests/actions/workflows/application-frontend-test.yaml)
2. Click **Run workflow** (blue box, right side)
3. Selections:
   - **Branch** of `qa-frontend-automated-tests` repo (leave `main` unless testing test changes)
   - **Number of runs** — leave at 1 unless specific need. **5x recommended** for reliability after each automation ticket.
   - **Environment** to test against (where code is already deployed)
4. Click **Run workflow**

## Timing

| Stage | Duration |
|---|---|
| Task deploy | ~3 min |
| CloudWatch log appearance | ~5 min after start |
| Total runtime | ~20 min |

Notifications:
- Start: Slack `#test-automation-workflow-results`
- End: Slack with pass/fail + S3 link to bucket containing `index.html`

## Troubleshooting

ECS task logs in target env's AWS account:
- CloudWatch Logs Insights → log group `/ecs/tto-deveng-use2-bear-qa-frontend-automation`
- Type `frontend` in autocomplete to find quickly

## Key Claims

- 5x recommended run count after every automation-ticket merge to surface flakiness
- 5-minute log lag is the gotcha — devs assume "no logs = no run" and wrongly retrigger
- Slack notification with S3 `index.html` link is the result delivery mechanism (not GitHub Actions UI)

## Concepts Covered

- [[e2e-testing]] — End-to-end test execution
- [[github-actions]] — Manual workflow triggering
- [[ci-pipeline]] — Test automation in CI

## Related

- [[playwright-testing]] — Playwright as test framework
- [[testing-patterns]] — Testing strategy
- [[cloudwatch-logs-insights-queries]] — Log group querying
- [[nc-tech-stack-overview]] — Tech stack context
