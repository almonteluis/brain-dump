---
description: Post-mortem of the March 2026 axios npm supply chain compromise — social engineering attack, malicious versions, and lessons learned
tags:
  - security
  - supply-chain
  - package-manager/npm
  - social-engineering
  - axios
sources:
  - Post Mortem axios npm supply chain compromise · Issue 10636 · axiosaxios.md
created: 2026-04-28
updated: 2026-04-28
---

# Post Mortem: axios npm Supply Chain Compromise

**Source:** `Post Mortem axios npm supply chain compromise · Issue 10636 · axiosaxios.md`
**Date ingested:** 2026-04-28
**Type:** Security incident post-mortem
**Date of incident:** March 31, 2026

## Summary

Two malicious versions of axios (1.14.1 and 0.30.4) were published to npm through the lead maintainer's compromised account. Both versions injected `plain-crypto-js@4.2.1`, which installed a remote access trojan on macOS, Windows, and Linux. The malicious versions were live for about 3 hours before removal.

## Attack Vector

Social engineering campaign targeting the lead maintainer (Jason Saayman):

1. Attacker masqueraded as founder of a cloned company
2. Invited maintainer to a real Slack workspace branded to the company
3. Scheduled a meeting on MS Teams with fake participants
4. Meeting said something was "out of date" on the system
5. Maintainer installed the "missing item" — this was the RAT (Remote Access Trojan)
6. With RAT on machine, attacker had full unilateral control including 2FA bypass

**Pattern matches:** Google-documented UNC1069 campaign targeting cryptocurrency/AI via social engineering.

## Timeline

| Time (UTC) | Event |
|------------|-------|
| ~2 weeks before | Social engineering campaign initiated |
| March 30, 05:57 | `plain-crypto-js@4.2.0` published to npm |
| March 31, 00:21 | `axios@1.14.1` published with injected dependency |
| March 31, ~01:00 | `axios@0.30.4` published; first external detections |
| March 31, ~01:00 | Community reports compromised; attacker deletes issues |
| March 31, 01:38 | Collaborator DigitalBrainJS opens deprecation PR, contacts npm |
| March 31, 03:15 | Malicious versions removed from npm |
| March 31, 03:29 | `plain-crypto-js` removed from npm |

## Detection

```bash
grep -E "axios@(1\.14\.1|0\.30\.4)|plain-crypto-js" package-lock.json yarn.lock bun.lock pnpm-lock.yaml 2>/dev/null
```

If matched: treat machine as compromised. Rotate every secret.

## Lessons Learned

1. **OIDC-based publishing** — Removes long-lived credentials entirely (highest-leverage change)
2. **Publish from CI, not local machine** — If laptop is compromised, blast radius doesn't include release ability
3. **Hardware keys for 2FA** — TOTP on compromised machine is not real 2FA
4. **No automated unauthorized publish detection** — Detection depended entirely on community noticing
5. **Targeted social engineering is the new normal** — Sophisticated, persistent campaigns against high-impact package maintainers

## Changes Being Made

- Reset of all devices and credentials
- Immutable release setup
- OIDC flow for publishing
- Updated GitHub actions to best practices
- Improved overall security posture

## Key Comments

**feross (Socket.dev):**
> "This kind of targeted social engineering against individual maintainers is the new normal. It's not a reflection on Jason or the axios team — these campaigns are sophisticated and persistent."

**jasonsaayman:**
> "i have been told that once the RAT is on your machine they have full unilateral control of everything on your machine... and yes i did have 2fa enabled on my account."

## Concepts Covered

- [[supply-chain-security]] — npm package compromise and prevention
- [[social-engineering]] — Targeted attacks on open source maintainers
- [[oidc-publishing]] — OIDC-based provenance attestation for npm
- [[rat-malware]] — Remote access trojans as attack vector

## Related

- [[toctou-wikipedia]] — Another security vulnerability class
- [[toctou-explained-deepstrike]] — Race condition security guide
