---
description: Five patterns that replaced useEffect at Factory for more predictable React code
tags: ["react", "hooks", "useeffect", "patterns", "state-management"]
sources: ["Why we banned React's useEffect.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Why We Banned React's useEffect

**Source:** Why we banned React's useEffect.md (raw, deleted)
**Author:** [[@alvinsng]] (Factory)
**Date ingested:** 2026-04-09
**Type:** Engineering guideline

## Summary

Factory's frontend rule: **no useEffect**. Only exception is `useMountEffect()` for one-time external system sync. The rule eliminates race conditions, infinite loops, and dependency hell while making code more predictable — especially important when agents write the code.

## The Rule

```typescript
// ❌ BANNED: Direct useEffect
useEffect(() => { ... }, [deps]);

// ✅ ALLOWED: Explicit mount effect wrapper
export function useMountEffect(
  effect: () => void | (() => void)
) {
  /* eslint-disable no-restricted-syntax */
  useEffect(effect, []);
}
```

## Why useEffect Causes Problems

| Problem | Cause |
|---------|-------|
| **Brittleness** | Dependency arrays hide coupling |
| **Infinite loops** | State update → render → effect → state update |
| **Effect chains** | Time-based control flow (A triggers B triggers C) |
| **Debugging pain** | "Why did this run?" has no clear entrypoint |

useEffect shifted teams from explicit event-driven logic to implicit synchronization through dependency arrays.

## The Five Replacement Patterns

### 1. Derive State Inline

```typescript
// ❌ BAD: Extra render cycle, loop hazard
const [filtered, setFiltered] = useState([]);
useEffect(() => {
  setFiltered(products.filter(p => p.inStock));
}, [products]);

// ✅ GOOD: Single render, no effect
const filtered = products.filter(p => p.inStock);
```

**Smell**: `useEffect(() => setX(deriveFromY(y)), [y])`

---

### 2. Use Data-Fetching Libraries

```typescript
// ❌ BAD: Race conditions, duplicated caching
const [product, setProduct] = useState(null);
useEffect(() => {
  fetchProduct(productId).then(setProduct);
}, [productId]);

// ✅ GOOD: Cancellation, caching, staleness handled
const { data: product } = useQuery(
  ['product', productId],
  () => fetchProduct(productId)
);
```

**Smell**: `fetch()` then `setState()` in effect

---

### 3. Event Handlers, Not Effects

```typescript
// ❌ BAD: State as action relay
const [liked, setLiked] = useState(false);
useEffect(() => {
  if (liked) {
    postLike();
    setLiked(false);
  }
}, [liked]);

// ✅ GOOD: Direct event-driven action
<button onClick={() => postLike()}>Like</button>
```

**Smell**: "Set flag → effect runs → reset flag" mechanics

---

### 4. useMountEffect for External Sync

```typescript
// Explicit wrapper for one-time setup
function useMountEffect(callback) {
  useEffect(callback, []);
}

// Usage: DOM integration, third-party widgets, browser APIs
function VideoPlayer() {
  useMountEffect(() => {
    initializePlayer();
    return () => cleanupPlayer();
  });
}
```

**Good uses**:
- DOM integration (focus, scroll)
- Third-party widget lifecycles
- Browser API subscriptions

---

### 5. Reset with Key, Not Dependencies

```typescript
// ❌ BAD: Effect emulates remount
useEffect(() => {
  loadVideo(videoId);
}, [videoId]);

// ✅ GOOD: key forces clean remount
function VideoPlayer({ videoId }) {
  useMountEffect(() => loadVideo(videoId));
}

<VideoPlayer key={videoId} videoId={videoId} />
```

**Smell**: Effect's only job is resetting state when ID changes

## Conditional Mounting Pattern

```typescript
// ❌ BAD: Guard inside effect
useEffect(() => {
  if (!isLoading) playVideo();
}, [isLoading]);

// ✅ GOOD: Mount only when preconditions met
function VideoPlayerWrapper({ isLoading }) {
  if (isLoading) return <LoadingScreen />;
  return <VideoPlayer />;
}

function VideoPlayer() {
  useMountEffect(() => playVideo());
}
```

## Forcing Function for Component Design

Banning useEffect enforces cleaner tree design:
- **Parents** own orchestration and lifecycle boundaries
- **Children** assume preconditions are met
- **Result**: Simpler components, fewer hidden side effects

Unix philosophy applied to React: each unit does one job; coordination at clear boundaries.

## Failure Mode Tradeoffs

| Pattern | Failure Type |
|---------|--------------|
| useMountEffect | Binary and loud (ran or didn't) |
| useEffect | Gradual degradation (flaky, slow, then breaks) |

Choose your bug: loud and fixable vs silent and accumulating.

## Official React Position

React docs have full guide: [You Might Not Need an Effect](https://react.dev/learn/you-might-not-need-an-effect)

## Adoption

1. Add ESLint rule: `no-restricted-syntax` for `useEffect`
2. Add `useMountEffect` wrapper
3. Mass-fix with agent (reference this guide)
4. Update AGENTS.md with rule

## Results

- Fewer infinite loops
- Fewer race-condition regressions
- Faster onboarding (control flow is explicit)
- Rule felt extreme at first, now feels like baseline guardrail

## Related

- [[react-hooks]] — General hook patterns
- [[you-might-not-need-an-effect]] — Official React guide
- [[state-derivation]] — Computing values without effects
- [[event-driven-architecture]] — Explicit action patterns

## Entities

- [[@alvinsng]] — Author, Factory
- [[Factory]] — Company with no-useEffect policy
- [[React Team]] — Official guidance

## Resources

- Source: https://x.com/alvinsng/status/2033969062834045089
- React docs: https://react.dev/learn/you-might-not-need-an-effect
