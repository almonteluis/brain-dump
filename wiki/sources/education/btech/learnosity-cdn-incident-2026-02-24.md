---
description: Post-mortem of February 2026 Learnosity Items API CDN incident — v1.132.1 archived by Learnosity, pinning to v1.132.3 within v2025.1.LTS, inference engine hang on newer LTS versions
tags: [source, incident, post-mortem, learnosity, cdn, third-party, marvin, work]
sources: ["Learnosity incident 2026-02-24.md"]
created: 2026-05-03
updated: 2026-05-03
---

# Learnosity CDN Incident — 2026-02-24

**Source:** `Learnosity incident 2026-02-24.md`
**Date ingested:** 2026-05-03
**Type:** Incident post-mortem
**Tracking:** [TEAMF-393](https://newclassrooms.atlassian.net/browse/TEAMF-393)
**Lead:** Luis

## Summary

Around **2026-02-19**, Learnosity removed the Items API library version Marvin's frontend depended on (`v1.132.1`) from the CDN. All assessment types in Roadmaps stopped loading sporadically. **Luis pinned the frontend to `v1.132.3` within the `v2025.1.LTS` release**, restoring connectivity. Newer LTS branches (v2025.2.LTS+) cause the inference engine to hang on the post-diagnostic screen. No customer reports as of 2026-02-26 but Sentry tracked errors disruptive to the experience.

## Symptoms

1. **Items API 404** — `release-150` in prod could not load any Learnosity content (assessments, practice problems, diagnostics, exit slips). Cause: pinned version `v1.132.1` was archived by Learnosity.
2. **Diagnostic hang** — `v2025.1.LTS` exposed a separate bug: final diagnostic item missing `ability_estimate` and `standard_error` fields, breaking the Learnosity Result Fetcher (LRF). Could be worked around by ignoring bad items in LRF, but academic implications are bad.
3. **`Invalid domain` errors** — sporadic across all versions. Learnosity support engaged.
4. **Allowlist briefly blank** in the Learnosity console for the dev consumer. Adding `*.ttoworks.net` restored the list after a 10-minute refresh.
5. **Marcos's Learnosity API keys not working** — Chris rotating keys.

## Resolution

Luis pinned to **v1.132.3 within v2025.1.LTS**:

- Confirms with Learnosity's verified logs
- Resolves the 404 errors
- Avoids the inference-engine hang from v2025.2.LTS+
- Manual end-to-end testing on **deer** environment confirmed: diagnostic submission → home page → multiple skill assignments loaded and submitted without error

## Key Insight: "Bleeding Edge" Regressions

> By moving away from the `latest` tag and explicitly targeting the v2025.1 branch, we ensure we aren't pulling in developer versions or newer LTS branches that haven't been fully vetted for our inference engine compatibility.

Learnosity's release cadence:

- Major LTS milestone every **4 months** (Feb / Jun / Oct)
- LTS supported for **2 years**
- Marvin uses **self-hosted** version (not Learnosity's managed LTS) — no automatic updates **and** no automatic version archiving notifications

## Follow-Up Notes

- Cause unclear root-wise — result of using a lot of third-party code
- Learnosity published new versions AND removed old versions in same window — the removal hit Marvin
- **Need a process for staying on top of archive notifications**: monthly? sprintly? Webpage monitor → Slack notification?
- Self-hosting tradeoff: avoid auto-updates but lose archival visibility
- Marvin doesn't use Learnosity's FE logging library (rollbar) — duplicate-event support ticket open with Learnosity to disable it

## Key Claims

- Pinning to a specific patch version within an LTS branch is more stable than tracking `latest` or LTS-major
- Self-hosting Learnosity decouples from Learnosity's release cadence but eliminates the archival warning surface — net negative if no monitoring exists
- Learnosity's `v2025.2.LTS` introduced changes that hang the inference engine — newer is not always more stable
- Sentry served as the early warning for users (since no customer reports came in)
- Manual end-to-end verification on the deer environment is the team's regression gate before merging Learnosity-version pins

## Entities Mentioned

- [[learnosity]] — Third-party assessment platform
- [[learnosity-result-fetcher]] — Lambda receiving Learnosity assessment results
- [[inference-engine]] — Lambda processing diagnostic results
- [[sentry]] — Error tracking
- [[marvin-architecture]] — Marvin frontend
- [[bff-learnosity-bridge]] — Backend-for-Frontend bridging Learnosity APIs

## Concepts Covered

- [[third-party-version-management]] — Managing pinned versions of vendor libraries
- [[supply-chain-security]] — Vendor archive risk
- [[lts-transition]] — LTS as version stability marker
- [[observability]] — Sentry as user-impact early-warning

## Related

- [[learnosity-access-product]] — Learnosity allowlist domain config
- [[learnosity-swap-out-notes-product]] — Long-term Learnosity replacement context
- [[bff-learnosity-bridge]] — BFF Lambda for Learnosity APIs
- [[teame-218-brainbreak-postmortem]] — Earlier post-mortem pattern
