---
description: Prompt templates for AI-generated unit tests covering error states, edge cases, boundaries, and failure scenarios
tags:
  - synthesis
  - prompts
  - testing
  - unit-testing
  - ai/workflow
  - edge-cases
  - error-handling
created: 2026-04-11
sources:
  - "[[workflows]]"
  - "[[testing-patterns]]"
  - "[[sources/10-high-impact-claude-prompts]]"
  - "[[TEAME-218-BrainBreak-Unit-Test-Plan-2026-04-11]]"
  - "[[Frontend-Unit-Testing-Guide-2026-04-11]]"
---

# Prompts for AI Unit Test Generation (Error States & Edge Cases)

Prompt templates for generating comprehensive unit tests that cover error states, edge cases, and failure scenarios. Synthesized from vault sources on testing patterns, Claude Code workflows, and real project test plans.

## Bug-Catching Prompts

From [[workflows]] — proven patterns for adversarial test generation:

```
Write 20 unit tests designed to break this function
```

```
Generate 50 edge cases: null, empty strings, negative numbers, unicode
```

```
Find every security vulnerability in this file. Think like a pentester.
```

## Categorized Templates

### Null/Undefined/Input Validation

```
Generate unit tests for [FUNCTION/COMPONENT] covering:
- null and undefined inputs
- empty strings, empty arrays, empty objects
- whitespace-only strings
- missing required properties on objects
Show the test code using Vitest + React Testing Library.
```

### Boundary and Range Errors

```
Write tests for [FUNCTION] that exercise every boundary:
- minimum value (0, -1, MIN_SAFE_INTEGER)
- maximum value (MAX_SAFE_INTEGER, overflow)
- off-by-one at every threshold
- NaN and Infinity inputs
- what happens at exactly the boundary vs one past it
```

### Async Failure States

```
Generate tests for [HOOK/FUNCTION] handling async error states:
- network request fails (500, 403, 404)
- request times out
- partial success (some mutations fail, others succeed)
- race conditions (rapid re-renders, duplicate calls)
- cleanup on unmount during pending request
```

### State Machine Edge Cases

```
For [COMPONENT/CONTEXT], test every invalid state transition:
- action fired before hydration completes
- action fired after cleanup/unmount
- duplicate actions (idempotency check)
- state change from undefined to defined
- state change from defined to undefined
```

### Error Propagation

```
Write tests proving [MODULE] handles errors correctly:
- caught errors return safe defaults, not thrown exceptions
- error callbacks receive meaningful messages
- partial failures don't corrupt state
- thrown errors are contained and don't crash the app
```

## Real-World Template

From [[TEAME-218-BrainBreak-Unit-Test-Plan-2026-04-11]] — the structured test plan pattern:

```
For [FILE/COMPONENT], generate tests in these categories:

1. Normal Cases (Happy Path) — 5 tests
2. Same-Input Prevention / Idempotency — 3 tests
3. Edge Cases (boundaries, malformed input, clock skew) — 5 tests
4. Error Handling (graceful degradation, safe defaults) — 3 tests
5. Race Guards (already recording, already qualified) — 3 tests

Follow AAA pattern (Arrange, Act, Assert).
Use vi.hoisted() for shared mocks.
Target >90% line coverage.
```

## Edge Case Categories Checklist

When generating tests, ask the AI to cover these categories:

| Category | Examples |
|----------|----------|
| Null/Undefined | `null`, `undefined`, missing props |
| Empty Values | `""`, `[]`, `{}`, `0` |
| Boundaries | off-by-one, min/max, exact threshold |
| Type Mismatch | string where number expected, array vs object |
| Malformed Data | invalid JSON, corrupted ISO dates, extra fields |
| Async Failures | network errors, timeouts, partial success |
| Race Conditions | rapid re-renders, duplicate submissions, unmount during fetch |
| Idempotency | same action twice, re-qualification guard |
| Clock/Time | future dates, DST transitions, timezone offsets |
| Unicode | emoji in strings, RTL text, zero-width characters |
| Concurrency | parallel mutations, overlapping timers |

## Best Practices

From [[testing-patterns]] and [[Frontend-Unit-Testing-Guide-2026-04-11]]:

1. **Test behavior, not implementation** — assert outputs and DOM, not internal state
2. **Use realistic test data** — avoid generic `"test"` strings, match production shapes
3. **Keep tests independent** — `afterEach(() => vi.clearAllMocks())`
4. **Follow the test pyramid** — more unit, fewer integration, minimal E2E
5. **AAA pattern** — Arrange, Act, Assert in every test
6. **Co-locate tests** — `*.test.ts` / `*.test.tsx` next to source files

## Related

- [[testing-patterns]] — Unit, integration, and E2E testing patterns
- [[workflows]] — Claude Code power user workflows
- [[sources/10-high-impact-claude-prompts]] — 10 practical Claude prompts
