---
description: Speculative data writes are a state-management problem masquerading as a CRUD problem — TEAME-287 root cause analysis with state-machine refactor proposal
tags:
  - synthesis
  - state-management
  - experiments
  - speculative-data
  - teame-287
  - refactor
created: 2026-05-06
type: synthesis
---

# Speculative Data as State Machine

## Hypothesis

`experiments_speculative_data` writes are a **state-management problem**, not a CRUD problem. Treating them as direct table mutations leaks state and produces bugs like TEAME-287 (`created` bumped instead of `modified`).

The graph already saw this: `Experiment Speculative Data` ↔ `State Management` is an INFERRED `semantically_similar_to` edge in the knowledge graph. AI noticed the conceptual overlap before we wrote it down. This page makes the connection explicit and proposes a refactor.

## The bug pattern

From [[teame-287-speculative-data-created-bug]] and [[brainbreak-lts-cooldown-speculative-bugs]]:

When a student hits BrainBreak more than once, `created` on the active modal row bumps instead of `modified`. Original creation timestamp lost.

Surface symptom: insert/update logic confuses the operation.
Underlying cause: **the code treats every write as opaque mutation** instead of distinguishing state transitions.

## Why CRUD framing produces this bug

Speculative data has a small but real lifecycle:

```
NONE → INITIAL_WRITE → REPEATED_WRITE → EXPIRED → DELETED
```

CRUD framing flattens this to a single `upsert(payload)` call. The mutation has to *infer* the transition from row presence + timestamps. When the inference is wrong (e.g. matches by `userId+flagName` but conflates first-write vs repeat-write), columns get bumped wrong.

Same shape as the React anti-pattern of [[state-management|treating server state as local state]] — the rules aren't enforced by structure, just by convention. Convention rots.

## State machine framing

Reframe the same writes through explicit transitions:

```typescript
type SpeculativeDataState =
  | { kind: 'none' }
  | { kind: 'active'; created: Date; modified: Date; payload: object; count: number }
  | { kind: 'expired'; created: Date; modified: Date }

type SpeculativeDataEvent =
  | { type: 'first_write'; payload: object }
  | { type: 'repeat_write'; payload: object }
  | { type: 'expire' }
  | { type: 'reset' }

function transition(state: SpeculativeDataState, event: SpeculativeDataEvent): SpeculativeDataState {
  switch (state.kind) {
    case 'none':
      if (event.type === 'first_write') {
        const now = new Date()
        return { kind: 'active', created: now, modified: now, payload: event.payload, count: 1 }
      }
      return state
    case 'active':
      if (event.type === 'repeat_write') {
        return { ...state, modified: new Date(), payload: event.payload, count: state.count + 1 }
      }
      if (event.type === 'expire') {
        return { kind: 'expired', created: state.created, modified: state.modified }
      }
      return state
    // ...
  }
}
```

The `created` column **cannot** be bumped on repeat write because the `repeat_write` transition doesn't touch it. Bug class eliminated by structure, not vigilance.

## Implementation paths

### Path A: thin wrapper at GraphQL mutation layer
Wrap `commitSpeculativeData` in a function that classifies the operation:

```typescript
async function commitSpeculativeData(input: SpeculativeDataInput): Promise<SpeculativeDataState> {
  const existing = await fetchSpeculativeData(input.userId, input.flagName)
  const event: SpeculativeDataEvent = existing
    ? { type: 'repeat_write', payload: input.payload }
    : { type: 'first_write', payload: input.payload }

  const nextState = transition(existing ?? { kind: 'none' }, event)
  return persistSpeculativeData(nextState)
}
```

`persistSpeculativeData` is now dumb — takes a fully-resolved state and writes it. No insert-vs-update guesswork.

**Pros:** small change, no schema change, contained to BrainBreak.
**Cons:** still possible to call the raw mutation directly and re-introduce the bug.

### Path B: enforce at backend service
Move state machine into the .NET / GraphQL service. Expose only event-shaped mutations:

```graphql
type Mutation {
  recordSpeculativeDataEvent(input: SpeculativeDataEventInput!): SpeculativeDataState!
}
```

Frontend sends `{type: 'first_write' | 'repeat_write' | ...}`, backend resolves the state. No client can write the wrong column because the wrong column isn't accessible.

**Pros:** correctness enforced at boundary. All experiments using speculative data benefit.
**Cons:** requires service change. Coordination with BFF + .NET team.

### Path C: schema-level append-only
Make `experiments_speculative_data` append-only. Each write is a new row. `current_state` is a view over latest row by `(userId, flagName)`.

**Pros:** state transitions become first-class history. Auditable. No update bugs possible.
**Cons:** larger storage, harder cleanup at experiment end. Rejects the "speculative = ephemeral" intent.

## Recommendation

**Ship Path A immediately to fix TEAME-287.** Targeted, low risk, fits current sprint. Wrap `commitCooldownMutation` with explicit event classification.

**Open ticket for Path B.** Backend boundary enforcement is the structural fix — every future experiment avoids the same bug class. Coordinate with Sam + GraphQL team.

**Skip Path C.** Append-only conflicts with the "discard at experiment end" principle from [[ab-testing-lifecycle]].

## Other speculative data writes worth auditing

If TEAME-287 hit BrainBreak's cooldown row, similar bugs likely lurk in other experiments using the same table. Check for:

- Any code calling `commitSpeculativeData` / equivalent mutation directly without classifying first-vs-repeat
- Any test that asserts `created` instead of `modified` (may have been wrong all along)
- Any analytics query joining on `created` for "first occurrence" — if `created` bumps, the metric is broken

## Why this matters for refactoring beyond TEAME-287

Same shape applies anywhere transient mutable state lives outside React:

- Browser localStorage (often "upsert blob" with same insert/update confusion)
- Server-side session cache
- Feature-flag-scoped user metadata
- Any "save my partial form" flow

Wherever a write needs to know "is this the first or a repeat" to set the right field — that's a state machine waiting to be made explicit.

## Code quality signals from the knowledge graph

The graph also flagged:
- `Experiment Speculative Data` shares a community with `cooldown-system` (same root cluster)
- `state-context-reducer-pattern` and `cooldown-system` share an INFERRED similarity (both pattern-match the "imperative writes need a state machine wrapper" shape)

These are evidence the same refactor pattern is reusable across BrainBreak runtime — not just speculative data.

## Related

- [[experiment-speculative-data]] — Concept page (CRUD framing)
- [[state-management]] — General state management decision framework
- [[teame-287-speculative-data-created-bug]] — Ticket
- [[brainbreak-lts-cooldown-speculative-bugs]] — Refined debug write-up with Fix A + Fix B
- [[cooldown-system]] — Adjacent state machine candidate
- [[ab-testing-lifecycle]] — Containment rules speculative data follows
- [[state-context-reducer-pattern]] — Reducer pattern (same shape, React-side)
