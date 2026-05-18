---
description: How thinking frameworks map to software debugging workflows — which framework to use at each phase of bug investigation
tags:
  - framework/thinking
  - debugging
  - problem-solving
  - synthesis
sources:
  - thinking-frameworks-collection.md
  - typescript-debugging-patterns.md
  - react-useeffect-patterns.md
created: 2026-04-22
updated: 2026-04-22
---

# Thinking Frameworks for Debugging

**Created:** 2026-04-22
**Type:** Synthesis — mapping thinking tools to debugging phases

Six frameworks from [[thinking-frameworks-collection]] map directly to debugging workflows, each serving a different phase.

## The Six Frameworks

### 1. OODA Loop — The core debugging cycle

Every bug investigation is an OODA loop:

- **Observe** — Reproduce the bug, read the error, check logs
- **Orient** — Hypothesize what's wrong based on evidence
- **Decide** — Pick the most likely fix (it's a hypothesis, not certainty)
- **Act** — Apply the fix, test it
- **Loop** — Did it work? If not, you have new data. Re-enter.

The key insight: speed comes from cycling fast, not from being right on the first pass. This is essentially the Red-Green-Refactor cycle in TDD — see [[testing-patterns]].

### 2. Ishikawa Diagram — Root cause analysis

The most direct debugging framework. When a bug has multiple possible causes, draw the fishbone with categories:

- **People** — Did a developer misunderstand the API?
- **Methods** — Is the algorithm wrong?
- **Tools** — Is the build step stripping needed code?
- **Environment** — Does it only fail in production (different config)?

The diagram forces structured exploration rather than jumping to a single cause. Combine with Five Whys to dig deeper under each bone.

### 3. Issue Trees — Systematic decomposition

When a bug is complex ("the app is slow"), use an issue tree to break it into MECE branches:

- Server-side processing vs Network vs Database vs Client rendering
- Each branch decomposes further
- Apply 80/20 to focus on the highest-impact branch

Issue trees prevent you from optimizing the wrong layer. Often 80% of the slowdown comes from one branch you'd never have checked first.

### 4. First Principles — Cutting through assumptions

When you're stuck debugging the same way you always have:

- "What do I *actually* know is true here?" (not what I assume)
- "What are the fundamental constraints?" (not the conventional wisdom)
- Socratic questioning: "What evidence am I assuming vs. what have I verified?"

This pairs with [[context-engineering]] — debugging AI-assisted code benefits from first-principles thinking about what context the AI had vs. what it needed.

### 5. Ladder of Inference — Avoiding premature conclusions

The biggest debugging anti-pattern is jumping to conclusions. Walk back the ladder:

1. **Action:** "I'm going to rewrite this component"
2. **Belief:** "The component is the problem"
3. **Conclusion:** "The data is corrupted here"
4. **Assumption:** "I assumed the API returns clean data"
5. **Interpretation:** "I interpreted the 500 error as a data issue"
6. **Selected data:** "I only looked at the frontend error, not the backend logs"
7. **Available data:** "What if I check the network tab, the API logs, and the database?"

Walking down the ladder often reveals you're fixing the wrong layer.

### 6. Connection Circles — Finding feedback loops

Some bugs are caused by reinforcing feedback loops — things that compound:

- Component A triggers Component B, which triggers Component A again (infinite re-renders)
- A state update causes an effect that causes another state update
- A CSS change breaks layout, which triggers a JS resize observer, which changes more CSS

Drawing a connection circle maps these cycles visually, making the loop visible and fixable.

## Quick Reference

| Debugging Phase | Framework | What It Gives You |
|----------------|-----------|-------------------|
| First reproduction | OODA Loop | Fast cycle of observe-hypothesize-test |
| Complex, multi-cause bug | Ishikawa Diagram | Structured root cause exploration |
| Vague performance issue | Issue Trees | MECE decomposition to find the 80/20 |
| Stuck, tried everything | First Principles | Challenge assumptions, rebuild from facts |
| Jumped to a fix too fast | Ladder of Inference | Walk back your reasoning chain |
| Subtle, intermittent bug | Connection Circles | Find hidden feedback loops |

## Related

- [[thinking-frameworks-collection]] — All 17 thinking frameworks
- [[typescript-debugging-patterns]] — TS-specific error patterns
- [[react-useeffect-patterns]] — useEffect anti-patterns and fixes
- [[testing-patterns]] — TDD cycles mirror the OODA loop
- [[why-we-banned-useeffect]] — Five patterns that replace useEffect
- [[teame-218-brainbreak-postmortem]] — Real-world debugging: 7 refactoring approaches tried and learned
