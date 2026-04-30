---
tags: [software-engineering, operations, reliability, clippings]
sources: ["The unwritten laws of software engineering.md"]
created: 2026-04-29
updated: 2026-04-29
---

# The Unwritten Laws of Software Engineering

**Source:** The unwritten laws of software engineering.md
**Date ingested:** 2026-04-29
**Type:** Essay

## Summary

Anton Zaides lists 7 unwritten rules every engineer learns by breaking things. Practical operational wisdom that doesn't appear in textbooks.

## Key Claims

1. **Backups aren't real until you've restored from them**
   - Know: incremental vs full, permissions, click path, duration
   - Not a one-time exercise — processes change, data grows

2. **You'll always hate yourself for how you write logs**
   - Balance: enough info, searchable, shared request ID, not too verbose
   - AI tools create opposite problem: too many verbose confusing logs

3. **Always have a rollback plan. ALWAYS.**
   - Tested rollback plan, not theoretical
   - Adding column? Have migration to remove it. Inserting data? Know exact rows to delete
   - Untested rollback has 50/50 chance to break

4. **Every external dependency will fail**
   - 99.9% SLA × 99.9% SLA = doubled downtime (8h → 17h/year)
   - Ask: rate limits, failure impact, tested fallback, caching, contact/SLA
   - Actually test in production how app behaves when API is down

5. **If there is ANY risk — "4 eyes" rule**
   - Half the time you catch the mistake yourself just explaining it out loud
   - Weekend/night + don't want to bother anyone = strongest signal not to proceed alone

6. **There is nothing more lasting than a temporary fix**
   - "We'll address this later" means "we'll never do it"
   - 90% of MVPs with hacks never get V2
   - Push for minimal solution you're actually happy with
   - Difference between "simple and limited" vs "held together with duct tape"

7. **New for 2026: AI-generated code is only as good as your context**
   - "Satisfaction of search" — agents stop at first answer, don't know if it's right

## Entities Mentioned

- [[anton-zaides|Anton Zaides]] — Author, manager.dev newsletter
- [[jessica-kerr|Jessica Kerr]] — Referenced (adding correctness conditions)

## Concepts Covered

- [[rollback-planning]] — Every change needs tested reversal
- [[dependency-failure]] — External APIs will fail; plan for it
- [[backup-verification]] — Restore process must be practiced
- [[log-design]] — Balancing completeness with searchability
- [[four-eyes-principle]] — Pair review for risky operations
- [[temporary-fixes]] — Most permanent code starts as "temporary"
