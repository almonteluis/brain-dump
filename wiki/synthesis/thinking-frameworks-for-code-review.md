---
description: How thinking frameworks, cognitive science, and clean code principles map to code review workflows
tags: ["thinking-frameworks", "code-review", "clean-code", "synthesis"]
sources: ["thinking-frameworks-collection.md", "cognitive-load.md", "clean-code-javascript.md", "programmers-oath.md", "teame-218-brainbreak-postmortem.md"]
created: 2026-04-22
updated: 2026-04-22
---

# Thinking Frameworks for Code Review

**Created:** 2026-04-22
**Type:** Synthesis — mapping thinking tools, cognitive science, and clean code to review workflows

Seven frameworks and principles from the wiki map to code review, organized by review phase.

## 1. Cognitive Load — Reviewer capacity is limited

[[cognitive-load]] is the most directly applicable framework:

> "Reviewer working memory is limited too. Large changes exceed capacity. Staged reviews (architecture → logic → style)"

Working memory holds 7±2 items. A 500-line PR with 30 changed files far exceeds that. Small PRs aren't just nice — they're necessary for effective review. If the reviewer can't hold the mental model, they can't catch bugs.

**Staged reviews reduce cognitive load by narrowing focus:**
- **Pass 1:** Architecture and design decisions
- **Pass 2:** Logic correctness and edge cases
- **Pass 3:** Naming, formatting, style

## 2. SBI (Situation-Behavior-Impact) — Giving review feedback

From [[thinking-frameworks-collection]]: SBI removes judgment by structuring feedback into three parts. Code review example:

> Instead of "Your code is sloppy" (judgment), use: "In the PR for the payment module yesterday (**situation**), the error handling didn't cover network timeouts (**behavior**), which means we could silently fail transactions in production (**impact**). What was your reasoning there? (**intent**)."

This maps directly to the PR review findings in [[teame-218-brainbreak-postmortem]], where blocking issues were stated with file paths (situation), specific code patterns (behavior), and production consequences (impact).

## 3. Six Thinking Hats — Ensuring complete review coverage

From [[thinking-frameworks-collection]]. Each hat is a review lens:

| Hat | Review Question |
|-----|----------------|
| **White** (data) | Do tests pass? What's the coverage? Any lint warnings? |
| **Yellow** (benefits) | What does this improve? What problem does it solve well? |
| **Black** (risks) | What breaks? Edge cases? Security? Performance? |
| **Green** (creativity) | Is there a simpler approach? A more idiomatic pattern? |
| **Red** (intuition) | Does this feel right? Code smell? Something off I can't articulate? |
| **Blue** (process) | Is this PR too large? Should it be split? Am I reviewing the right things? |

Most reviews default to Black hat only (finding problems). Yellow hat ensures you acknowledge good decisions. Green hat catches missed simplifications.

## 4. Ladder of Inference — Avoiding review assumptions

From [[thinking-frameworks-collection]]. During review, it's easy to jump from "this code looks unusual" to "this developer doesn't know what they're doing." Walk back the ladder:

- **Action:** "Request a complete rewrite"
- **Belief:** "This approach is wrong"
- **Assumption:** "I assume the standard pattern works here"
- **Selected data:** "I only looked at this file, not the calling code"
- **Available data:** "What constraints does the author know that I don't?"

This is the principle from [[teame-218-brainbreak-postmortem]]: **"Ask questions first, measure before optimizing, consider constraints."**

## 5. Minto Pyramid — Writing review comments

From [[thinking-frameworks-collection]]. Good review comments lead with the conclusion:

> "Extract this validation into a shared utility (**conclusion**). It's duplicated in 3 places and will drift (**key argument**). See lines 45, 112, and 287 for the duplicates (**evidence**)."

Bad review comments bury the point in paragraphs of context. The BLUF (Bottom Line Up Front) principle respects the author's time.

## 6. Conflict Resolution Diagram — Resolving review disagreements

From [[thinking-frameworks-collection]]. When reviewer and author disagree:

- **Demand A:** "Rewrite using pattern X"
- **Demand B:** "Keep the current approach"
- **Need A:** Code that's maintainable long-term
- **Need B:** Ship the feature this sprint
- **Shared goal:** Deliver reliable software on schedule

The solution is usually staged: "Approve current approach with a follow-up ticket for the refactor, and document why the current approach was chosen."

## 7. Clean Code Principles — The actual review checklist

[[clean-code-javascript]] and [[ecc-coding-standards]] provide the concrete checklist behind the frameworks:

- Functions do one thing, 2 or fewer arguments
- Meaningful, searchable names
- No side effects, no flagged parameters
- SOLID principles applied
- No commented-out code (use version control)
- Error handling doesn't swallow exceptions

The [[programmers-oath]] adds the ethical layer: "Code is written for people, not computers" (tenet 8) and "Be kind to fellow programmers; never feign surprise or disparage others' code" (tenet 12).

## Quick Reference: Framework by Review Activity

| Activity | Framework | What It Gives You |
|----------|-----------|-------------------|
| Sizing the PR | Cognitive Load | Keep PRs to 7±2 mental items; split if larger |
| Structuring feedback | SBI | Non-judgmental: situation, behavior, impact, intent |
| Ensuring coverage | Six Thinking Hats | Every review lens: data, benefits, risks, alternatives |
| Avoiding assumptions | Ladder of Inference | Walk back from "this is wrong" to "what do I actually know?" |
| Writing comments | Minto Pyramid | Lead with the ask, then reasoning, then evidence |
| Resolving disagreements | Conflict Resolution Diagram | Find the shared goal, then build win-win solutions |
| The actual checklist | Clean Code + Oath | Concrete principles + kindness as a professional obligation |

## Related

- [[thinking-frameworks-for-debugging]] — Companion synthesis for debugging workflows
- [[thinking-frameworks-collection]] — All 17 thinking frameworks
- [[cognitive-load]] — Working memory limitations applied to code comprehension
- [[clean-code-javascript]] — Clean Code adapted for JavaScript
- [[ecc-coding-standards]] — Cross-language coding standards
- [[teame-218-brainbreak-postmortem]] — Real PR review findings with blocking issues and discussion items
