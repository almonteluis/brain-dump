---
tags:
  - work
  - teame
  - marvin/frontend/brain-break
  - bug/fix
  - speculative-data
  - lts
created: 2026-05-05
updated: 2026-05-05
status: done
---
****
# TEAME-287 — Speculative Data `created` Column Bug

**Date ingested:** 2026-05-05
**Type:** Work ticket
**Status:** Open

## Summary

When a student experiences BrainBreak more than once, the `created` column on the active modal row in `experiments_speculative_data` gets updated instead of the `modified` column. Should be a quick fix.

## Bug Description

**Expected:** On repeat BrainBreak, `modified` column should update to reflect the latest interaction time.

**Actual:** `created` column is bumped, losing the original creation timestamp.

## Context

Part of the BrainBreak LTS conversion cleanup. Two bugs remained going into today: this one and the cooldown parser bug ([[2026-05-05 BrainBreak Cooldown & Speculative Data Bugs]]).

### Root cause

The `experiments_speculative_data` table has `modified_by_id` and `modified_on` columns that were `null` on newly inserted rows. The insert path set only `created_by` / `created_on` and never touched the `modified_*` columns. The update path then had nothing to update against, so subsequent BrainBreak completions ended up bumping `created_*` instead of `modified_*` — losing the original creation timestamp.

Both paths needed to handle both column pairs correctly.

### Phase 1 — Frontend workaround (rejected)

Original plan was to avoid touching the backend by stashing `modified` and `modified_by_id` inside the JSONB payload column (which the frontend already controls).

- Added `modified` and `modified_by_id` to the payload, wired up the writes
- Tested: the JSONB payload picked up the new fields correctly
- But the actual table columns were still `null` — workaround masked the symptom in the payload without fixing the underlying data

Abandoned in favor of fixing it properly on the backend.

### Phase 2 — Backend fix

Read the mutation that writes to `experiments_speculative_data` and found the actual bug: the insert initializer was missing `modified_by` and `modified_on`.

- Two-line fix: add `modified_by = current_user` and `modified_on = datetime_utc_now()` to the insert initializer (matching the existing logic on the update path)
- Tested via the GraphQL API viewer — table columns now populate correctly on insert
- Update path was already correct, so subsequent BrainBreak completions now update `modified_*` as expected

### Phase 3 — Frontend cleanup

With the backend now populating the table columns properly, the frontend no longer needs to double-bookkeep this metadata into JSONB.

- Reverted all Phase 1 frontend changes
- Payload returned to its original lean shape: `session_id` and the claim fields only

## ## Fix Direction

> [!note] Direction changed Original direction (struck through below) would have ensured `created` is set only on insert and `modified` on update. Replaced with the heartbeat approach below.
> 
> ~~Locate the GraphQL mutation or backend service that writes to `experiments_speculative_data` on BrainBreak completion. Ensure `created` is set only on insert, `modified` on update.~~

### Why not the original approach

Forcing `modified_*` to populate on insert would break the existing pattern across the table — every other consumer of `experiments_speculative_data` leaves `modified_by` / `modified_on` null on freshly inserted rows. Touching that convention for one feature is not worth the blast radius.

### The actual bug

The session-lock heartbeat is what's supposed to update `modified_*`. It fires every 30 seconds to check whether another tab is open in the same session.

The problem: the **first** heartbeat doesn't fire until 30 seconds in. If a user opens BrainBreak in a single tab and the session ends inside that 30-second window — no heartbeat ever fires, and `modified_*` stays null indefinitely. That null state is what makes downstream queries misbehave.

### Proposed fix

Front-load the heartbeat cadence so the null window can't outlive a typical session:

- **t = 5s** — fire the first heartbeat. Confirms no other tabs, writes `modified_*` for the first time.
- **t = 5s onward** — heartbeat every 15s for the rest of the first minute (~4 total over the opening minute).
- **After 1 minute** — TBD, likely the existing 30s cadence. Confirm before implementing.

The insert path stays untouched, the convention holds, and the `modified_*` columns get populated within 5 seconds of session start instead of 30.

### Open

- [ ] Confirm steady-state heartbeat cadence after the first minute (15s vs back to 30s)
- [ ] Verify there's no thundering-herd risk if many users start sessions simultaneously and all hit the 5s mark together

This is an open question about the recent changes that I've made.

- Are we fetching after we log in and on the student dashboard?
- Are we checking the speculative table data to see the last completed day?
- Are we checking that before we do any placements?

I feel like we did this earlier; however, I want to ensure, because the QA person is trying to skip the brain break feature from the automated tests. How can I explain it? They inserted a table, but when they visit the page on load we’re not reading from that table, so it just triggers the brain break model even though the database says that they did.

## Testing

I got a fix in where it's pretty much decreasing the heartbeat. Once the first active modal is active within five seconds we will shoot off the first heartbeat signal. Before it was at 30 seconds so they should work.

I'm going to have two browsers open, Chrome and Firefox. I'm going to run both of the local hosts instances on both browsers and see if the five-second heartbeat is working There’s no need to test it. I opened the modal on my front end and checked. I submitted one earlier, and the active modal session already shows the modified on and modified by updated, so there’s no need to proceed further. That’s it. I'm going to say this ticket is ready for QA and it's done with all my books.

## Related

- [[brainbreak-lts-cooldown-speculative-bugs]] — Sprint write-up where this was identified
- [[experiment-speculative-data]] — Pattern for experiment transient data storage
- [[teame-268-brain-brake-retry-cooldown]] — Related cooldown ticket
