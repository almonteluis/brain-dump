---
description: "Quick reference for A/B test releases vs LTS releases using Unleash feature flags"
tags: ['research', 'marvin', 'new-classrooms']
raw_file: "Unleash Release Flag Management.md"
created: 2026-05-17
---

By Sam Saarinen

Cross-link: [Experiment Lifecycle Doc](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/1355120664)

---

# A/B Test Releases

**The idea:** Turn a feature ON for some users, see how they react, collect data.

The flag starts OFF. Nothing changes for users until we flip it.

## How it works

1. **PO creates the flag in Unleash.** Uses the ticket name, sets an automatic shutoff date (so we don't forget about it).

2. **Engineers build it.** Expedited code review + QA. Merge it.

3. **Deploy.** Code goes live but the flag is still OFF — users see nothing new yet. Deploy same-day if possible.

4. **Safety check.** Release Management turns the flag ON just to make sure the experiment doesn't break the rest of the platform. We're not testing the new feature — just checking it doesn't block students from doing their work.

5. **Roll out slowly.**
   - Start: Carmen only (our internal test user)
   - If no issues: expand to 50% of early-adopter schools
   - If issues: shut it down immediately

   **What counts as an issue?**
   - Students asking "what is this?" → Not an issue. Keep running.
   - Students can't complete their work → Issue. Kill it.

6. **PO watches the data.** If the numbers look bad, shut it down early. If they look good, keep it running longer.

## How long does an A/B test live?

Usually about a week to collect data. Sometimes longer if we're building a permanent version.

**Hard deadline:** 3 months max. After that, either kill it or make it permanent.

---

# LTS Releases (Long-Term Support)

**The idea:** The feature is now permanent. The flag exists to turn it OFF if something goes wrong.

This is backwards from A/B tests. The flag starts ON (feature is hidden). We turn the flag OFF to show the feature.

## How it works

1. **PO creates the flag.** Name it `LTS-shutoff-<ticket>-<description>`. No automatic shutoff date — this flag might stay for months.

2. **Engineers build the permanent version and delete the A/B test code.** Full code review + full QA (not expedited anymore). Test that the shutoff switch actually works.

3. **Test both states.** Try the platform with the feature ON and with it OFF. Make sure nothing breaks either way.

4. **Deploy.** Feature is hidden for late-adopter schools (they're change-averse). Early adopters already saw it during the A/B test.

5. **Watch for a week.** Check data, check support tickets. If all good, show it to late adopters.

6. **Watch another week.** If still good, turn the flag OFF completely (feature is now ON for everyone).

7. **Wait a few months.** Then delete the flag and the shutoff code. Feature is now permanent — no safety net.

## Timeline

Deploy → 1 week (show to more users) → 1 week (show to everyone) → ~3 months (delete the flag)

---

# Quick Comparison

| | A/B Test | LTS |
|---|---|---|
| **Flag does what?** | Turns feature ON | Turns feature OFF |
| **Who gets it first?** | Small test group | Everyone (but hidden for late adopters at first) |
| **Code review** | Fast-tracked | Full rigor |
| **How long?** | 1 week – 3 months | ~3 months, then archive |
| **End state** | Kill it or make it LTS | Permanent feature, no flag |
