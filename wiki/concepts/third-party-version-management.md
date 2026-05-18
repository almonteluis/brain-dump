---
description: Third-party version management — pinning, monitoring, and self-hosting tradeoffs for vendor library versions including archival risk and LTS branch selection
tags: [third-party, versioning, vendor, lts, supply-chain, concept]
sources: ["learnosity-cdn-incident-2026-02-24.md"]
created: 2026-05-03
updated: 2026-05-03
---

# Third-Party Version Management

Patterns for managing vendor library versions including pinning strategies, archival risk, and self-hosting tradeoffs. Driven by post-mortems where a vendor's archive policy or LTS instability disrupted production.

## Pinning Strategies

| Strategy | Stability | Surface Area |
|---|---|---|
| `latest` tag | Worst | Any release breaks you |
| `vN.LTS` (LTS major) | Better | LTS-branch issues hit you |
| `vN.M.LTS` (LTS minor) | Best for stability | Newer minor LTS still risk |
| `vN.M.P` (specific patch) | **Most stable** | Loses patch updates — drift |

## Self-Hosted vs Vendor-Hosted

| Self-hosted | Vendor-hosted (CDN) |
|---|---|
| Avoid auto-updates | Auto-update with vendor |
| **Lose archive notification** | Vendor signals archive |
| Full control | Vendor controls cadence |
| Larger ops surface | No infra |

**Tradeoff**: self-hosting decouples release cadence but eliminates archival visibility. Net negative without manual monitoring.

## "Bleeding Edge" Regression Risk

Newer LTS versions can regress for your specific integration. Vendor LTS = supported for many users, not yours.

**Signals**:
- Inference engines hang post-content load
- Required fields missing from response
- Sporadic "Invalid domain" errors

**Mitigation**: pin exact patch within LTS. Validate end-to-end on staging before prod.

## Archive Monitoring Process

When self-hosting and using `latest` is not safe:
- Subscribe to vendor release notes
- Webpage monitor → Slack notification on changelog updates
- Sprint cadence review of pinned versions
- Track support ticket counts as proxy for stability

## Lessons from Learnosity Feb 2026 Incident

See [[learnosity-cdn-incident-2026-02-24]].

- **Cause**: vendor (Learnosity) removed `v1.132.1` from CDN. Marvin's pinned version 404'd.
- **Newer not better**: `v2025.2.LTS+` introduced inference-engine hangs.
- **Resolution**: pin to specific patch `v1.132.3` within `v2025.1.LTS`.
- **Process gap**: no monitoring for vendor archival. Self-hosted decoupling lost the archival signal.

## Related

- [[supply-chain-security]] — Third-party trust patterns
- [[lts-transition]] — LTS as stability marker
- [[observability]] — Sentry as user-impact early-warning
- [[learnosity]] — Third-party assessment platform
- [[learnosity-cdn-incident-2026-02-24]] — Post-mortem case
- [[axios-supply-chain-compromise-postmortem]] — Adjacent supply-chain incident
