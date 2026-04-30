---
description: Securing software supply chains — npm package integrity, publishing best practices, and maintainer protection
tags: ["security", "supply-chain", "npm", "open-source"]
sources: ["axios-supply-chain-compromise-postmortem"]
created: 2026-04-28
updated: 2026-04-28
---

# Supply Chain Security

Protecting software from compromise at any point in the dependency, build, or distribution pipeline.

## npm Package Compromise: The axios Incident (March 2026)

**What happened:** Lead maintainer's account compromised via targeted social engineering + RAT malware. Two malicious versions (1.14.1, 0.30.4) published to npm, injecting `plain-crypto-js` trojan. Live for ~3 hours.

**Attack vector:**
1. Attacker cloned a real company's identity
2. Invited maintainer to branded Slack workspace
3. Scheduled fake MS Teams meeting
4. Tricked maintainer into installing "update" — the RAT
5. With RAT on machine, bypassed 2FA and published malicious versions

## Prevention Measures

### For Maintainers

| Measure | Priority | Why |
|---------|----------|-----|
| **OIDC-based publishing** | Critical | Removes long-lived credentials entirely |
| **Publish from CI, not local** | Critical | Compromised laptop ≠ ability to release |
| **Hardware security keys** | High | TOTP on compromised machine is bypassable |
| **Immutable releases** | High | Prevents republishing/overwriting existing versions |
| **Automated detection** | Medium | Don't rely solely on community noticing |

### For Consumers

- **Lock files:** Use `package-lock.json`, `yarn.lock`, `pnpm-lock.yaml`, or `bun.lock`
- **Audit regularly:** `npm audit`, Snyk, Socket.dev
- **Pin versions:** Avoid wildcard ranges for critical dependencies
- **Verify provenance:** npm supports publish provenance attestation

### Detection After Compromise

```bash
grep -E "axios@(1\.14\.1|0\.30\.4)|plain-crypto-js" *.lock 2>/dev/null
```

If matched: treat machine as compromised. Rotate all secrets, check network logs for connections to known C2 domains.

## Key Insight

> "This kind of targeted social engineering against individual maintainers is the new normal. It's not a reflection on Jason or the axios team — these campaigns are sophisticated and persistent." — feross, Socket.dev

Maintainers of high-download packages are active targets. Hyper vigilance is needed both on the registry and in personal capacity.

## Related

- [[axios-supply-chain-compromise-postmortem]] — Full incident details
- [[toctou]] — Another class of security vulnerability
