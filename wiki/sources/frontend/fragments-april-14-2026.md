---
description: Martin Fowler's April 2026 fragments — AI and laziness, TDD for agents, AI doubt and restraint
tags:
  - martin-fowler
  - ai
  - TDD
  - laziness
  - programming
sources:
  - Fragments April 14 2.md
created: 2026-04-28
updated: 2026-04-28
---

# Fragments: April 14, 2026 (Martin Fowler)

**Source:** `Fragments April 14 2.md` (martinfowler.com)
**Date ingested:** 2026-04-28
**Type:** Blog post / fragments
**Author:** Martin Fowler

## Summary

Three short pieces from Martin Fowler: AI's impact on programming virtues (particularly laziness), Jessica Kerr's TDD-for-agents approach, and Mark Little's metaphor of teaching AI doubt via the movie Dark Star.

## AI and the Virtue of Laziness

Larry Wall's three virtues of a programmer: hubris, impatience, and **laziness**.

Bryan Cantrill:
> "Laziness drives us to make the system as simple as possible (but no simpler!) — to develop the powerful abstractions that then allow us to do much more, much more easily."

> "The problem is that LLMs inherently lack the virtue of laziness. Work costs nothing to an LLM. LLMs do not feel a need to optimize for their own (or anyone's) future time, and will happily dump more and more onto a layercake of garbage."

Fowler's personal experience: Needed a music playlist modification. Considered throwing an agent at it, but instead realized he was overcomplicating it. Applied YAGNI, solved it in a couple dozen lines. "If I had used an LLM for this, would it have made a similar over-complication? Would I just shrug and say LGTM?"

## TDD for Agents (Jessica Kerr)

See [[adding-correctness-conditions-code-changes]] for full analysis. Core idea: verification before instructions when programming agents.

## AI and Doubt (Mark Little / Dark Star)

Metaphor from the sci-fi movie *Dark Star*: a crew member must use philosophical argument to prevent a sentient bomb from detonating.

Mark Little:
> "Most AI systems are optimised for decisiveness. Given an input, produce an output. Given ambiguity, resolve it probabilistically. Given uncertainty, infer. This works well in bounded domains, but it breaks down in open systems where the cost of a wrong decision is asymmetric or irreversible."

> "If we want AI systems that can operate safely without constant human oversight, we need to teach them not just how to decide, but when not to. In a world of increasing autonomy, restraint isn't a limitation, it's a capability."

## Key Concepts

- [[ai-laziness]] — LLMs lack the constraint of human time, leading to over-engineering
- [[yagni]] — You ain't gonna need it; apply before throwing agents at problems
- [[agent-restraint]] — Teaching AI when not to act
- [[tdd-for-agents]] — Verification-first approach to agent workflows

## Related

- [[adding-correctness-conditions-code-changes]] — Full analysis of Kerr's article
- [[ai-as-management-skill]] — Human skills for AI integration
