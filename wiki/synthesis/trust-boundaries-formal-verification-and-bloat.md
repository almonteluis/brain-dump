---
description: Formal verification and dependency bloat are both responses to the trust boundary problem — what you ship runs code you didn't write, and proof beats inspection at scale
tags:
  - synthesis
  - security
  - formal-verification
  - dependency-bloat
  - trust-boundaries
  - ai/code
created: 2026-05-06
type: synthesis
---

# Trust Boundaries — Formal Verification + Dependency Bloat

## Hypothesis

[[formal-verification]] and [[dependency-bloat]] look like unrelated topics — one is about Lean theorem provers, the other about npm packages. Graphify flagged them as `semantically_similar_to` (INFERRED). This page makes the connection explicit: **both are responses to the trust boundary problem.**

When you ship code, almost none of it is yours. The question is how you decide to trust the rest.

## Two strategies for the same problem

| Strategy | Goal | Mechanism | Cost |
|----------|------|-----------|------|
| **Formal verification** | Eliminate need to trust | Mathematical proof + small trusted kernel | Hard upfront, free at scale |
| **Dependency reduction** | Shrink the surface to inspect | Fewer + smaller dependencies | Continuous discipline |

Both attack the same root: the production binary contains code you can't personally audit. Either you prove it correct (verification) or you reduce how much there is (bloat reduction).

## Why this matters now (AI-code era)

From [[when-ai-writes-worlds-software-who-verifies]]: AI generates code 1000× faster than humans with the same review defenses. From [[axios-supply-chain-compromise-postmortem]]: a single compromised maintainer compromised millions of downstream apps via a single npm package.

These two threats compound. AI-generated code that pulls in 200 npm packages multiplies your trust surface in two dimensions at once:

1. Did the AI write correct code? → verification problem
2. Did all 200 packages stay benign? → dependency problem

You cannot solve one without the other.

## The trusted kernel principle

Formal verification's core idea: keep the *trusted* part small. Lean's kernel is a few thousand lines that everything else builds on. You audit the kernel once, exhaustively. Everything verified by the kernel inherits its trust without re-audit.

[[dependency-bloat]] applies the same principle in reverse direction: keep the *unverified* part small. Every npm package added is code you can't audit but must trust. Smaller dependency graph = smaller trust surface = lower compromise probability.

Same shape:
- **Verification:** trust grows from a small audited kernel outward
- **Dependencies:** trust shrinks as the unaudited surface grows

## Why ponyfills and AI-code share a failure mode

Both of these patterns from [[three-pillars-javascript-bloat]] are *trust without verification*:

- **`globalthis` (49M downloads/week, supported natively since 2019):** code you can't audit, doing something the runtime already does. Net: pure trust surface.
- **AI-generated function that "looks right":** code you didn't author, doing something a human could verify but didn't. Net: pure trust surface.

The defense for both is the same: ask "do I need this?" and remove if no.

## Practical synthesis — graduated trust strategies

### Tier 1: own + verify
Code you wrote, with proofs or property tests covering invariants. Highest cost, highest assurance. Reserve for crypto, auth, financial logic.

### Tier 2: own + test
Code you wrote, covered by unit + integration tests. Default for application code.

### Tier 3: trust + audit
Third-party code you read end-to-end. Requires the dependency be small enough to audit (i.e. not bloated).

### Tier 4: trust + monitor
Third-party code too large to audit but pinned + monitored for advisories. Most dependencies live here. Monitor via [[knip]], `npm audit`, GHSA advisories.

### Tier 5: trust + pray
Code in transitive dependency tree you've never looked at. The implicit default for most projects. **Goal: minimize what lives here.**

[[dependency-bloat]] is about getting more code out of Tier 5 into Tier 4 (audit + pin) or out entirely.
[[formal-verification]] is about pulling code OUT of Tiers 2-3 into Tier 1 (proof not just test).

## Code quality decision framework

When adding a new dependency or generating new code with AI:

1. **Can I delete it?** (Native API exists, simple inline implementation, etc.)
2. **Can I make the trusted kernel smaller?** (Use a verified library where one exists — e.g. AWS Cedar for auth)
3. **Can I bound the failure?** (Run untrusted code in WASM sandbox, isolate AI-generated code in a service boundary)
4. **Can I prove what it does?** (Property tests, fuzz tests, formal proof for the critical path)

If the answer to all four is "no" — the code goes in Tier 5 and you're trusting on faith.

## What this means for the New Classrooms stack

Concrete audits worth running:

- **`marvin/package.json`:** how many Tier-5 transitive deps? Tools like `knip` and `e18e` from [[dependency-bloat]] surface the candidates.
- **AI-generated code:** which production paths have meaningful test coverage? Which only have "looks right" review?
- **Auth + assignment + billing:** are any of these candidates for verified components (e.g. authorization rules through AWS Cedar)?
- **Speculative data writes (TEAME-287):** would pulling them through a [[speculative-data-as-state-machine|state-machine wrapper]] eliminate a class of bugs by structure? (Yes — same principle: prove correctness instead of relying on convention.)

## Related

- [[formal-verification]] — Mathematical proof of code correctness
- [[dependency-bloat]] — JS ecosystem trust-surface explosion
- [[supply-chain-security]] — Compromise pathways (axios postmortem, etc.)
- [[ai-code-generation]] — AI as primary code author
- [[when-ai-writes-worlds-software-who-verifies]] — Leonardo de Moura on the verification gap
- [[axios-supply-chain-compromise-postmortem]] — Real-world Tier 5 failure
- [[programmers-oath]] — Ethical commitments around code correctness
- [[speculative-data-as-state-machine]] — Adjacent synthesis: same "prove by structure" principle in BrainBreak speculative data
