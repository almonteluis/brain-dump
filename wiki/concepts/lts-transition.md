---
description: Long-Term Support transition — converting temporary A/B experiment code into permanent production features with full rigor
tags:
  - process
  - lts
  - ab-testing
  - experiments
  - technical-debt
  - concept
created: 2026-04-30
updated: 2026-04-30
sources:
  - ab-testing-lifecycle
  - teame-177-in-platform-polling-cleanup
---

# LTS Transition

Long-Term Support (LTS) transition is the process of converting temporary A/B experiment code into permanent production features. The core principle: **trade code quality for speed during experiments, then pay off that debt with proper implementation.**

## A/B Test vs LTS Comparison

| Aspect | A/B Test | LTS |
|--------|----------|-----|
| Code review | Fast-tracked (containment only) | Full rigor |
| QA | Tests flag-off only | Tests everything |
| Testing scope | "Does it break anything?" | "Does it work correctly?" |
| Flag behavior | Default OFF | Default ON (shutoff if broken) |
| Flag name | `TEAME-###-description` | `LTS-shutoff-###-description` |
| Lifetime | 1 week – 3 months | ~3 months, then delete flag |

## LTS Process

1. **Engineers rebuild properly** — New code, not refactored experiment
2. **Full code review** — No shortcuts
3. **Full QA** — Usability testing, bug hunting, automation updates
4. **Release with inverted flag** — Exists to shut OFF if broken
5. **Monitor for months** — If stable, delete flag and old code

## The Deal

A/B tests trade code quality for speed because the code will be deleted. LTS pays off that debt by building the permanent version properly. Containment rules make this safe.

## Related

- [[ab-testing-lifecycle]] — Complete three-stage lifecycle
- [[teame-177-in-platform-polling-cleanup]] — Example LTS conversion ticket
- [[technical-debt]] — Conscious trade-off for experiment speed
- [[experiment-containment]] — Rules that make A/B testing safe
