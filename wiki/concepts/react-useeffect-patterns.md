---
description: Patterns that replace useEffect for more predictable React code
tags: ["react", "hooks", "useeffect", "state-management", "patterns"]
created: 2026-04-09
updated: 2026-04-09
---

# React useEffect Patterns

Five patterns that replace most useEffect usage for more predictable, declarative React code.

## The Problem with useEffect

- **Brittleness**: Dependency arrays hide coupling
- **Infinite loops**: State update → render → effect → state update
- **Effect chains**: Time-based control flow (A triggers B triggers C)
- **Debugging pain**: "Why did this run?" has no clear answer

## The Five Replacement Patterns

### 1. Derive State Inline

```typescript
// ❌ BAD
const [filtered, setFiltered] = useState([]);
useEffect(() => {
  setFiltered(products.filter(p => p.inStock));
}, [products]);

// ✅ GOOD
const filtered = products.filter(p => p.inStock);
```

**Use when**: Computing values from props/state

---

### 2. Use Data-Fetching Libraries

```typescript
// ❌ BAD
const [product, setProduct] = useState(null);
useEffect(() => {
  fetchProduct(productId).then(setProduct);
}, [productId]);

// ✅ GOOD
const { data: product } = useQuery(
  ['product', productId],
  () => fetchProduct(productId)
);
```

**Libraries**: React Query, SWR, RTK Query

---

### 3. Event Handlers

```typescript
// ❌ BAD
const [liked, setLiked] = useState(false);
useEffect(() => {
  if (liked) {
    postLike();
    setLiked(false);
  }
}, [liked]);

// ✅ GOOD
<button onClick={() => postLike()}>Like</button>
```

**Use when**: Responding to user actions

---

### 4. useMountEffect (One-Time Setup)

```typescript
function useMountEffect(callback) {
  useEffect(callback, []);
}

// Usage
function VideoPlayer() {
  useMountEffect(() => {
    initializePlayer();
    return () => cleanupPlayer();
  });
}
```

**Use when**: External system sync (DOM, third-party widgets)

---

### 5. Reset with Key

```typescript
// ❌ BAD
useEffect(() => {
  loadVideo(videoId);
}, [videoId]);

// ✅ GOOD
function VideoPlayerWrapper({ videoId }) {
  return <VideoPlayer key={videoId} videoId={videoId} />;
}

function VideoPlayer({ videoId }) {
  useMountEffect(() => loadVideo(videoId));
}
```

**Use when**: "Start fresh when ID changes"

## Conditional Mounting

```typescript
// ❌ BAD
useEffect(() => {
  if (!isLoading) playVideo();
}, [isLoading]);

// ✅ GOOD
function VideoPlayerWrapper({ isLoading }) {
  if (isLoading) return <LoadingScreen />;
  return <VideoPlayer />;
}
```

## Decision Flowchart

```
Need side effect?
├── Sync with external system?
│   └── One-time? → useMountEffect
│   └── On every change? → Rethink (probably wrong)
├── Fetch data? → Data-fetching library
├── Respond to event? → Event handler
├── Compute value? → Derive inline
└── Reset on prop change? → Key prop
```

## ESLint Rule

```json
{
  "rules": {
    "no-restricted-syntax": ["error", {
      "selector": "CallExpression[callee.name='useEffect']",
      "message": "Use useMountEffect or alternative patterns. See docs."
    }]
  }
}
```

## Related

- [[why-we-banned-useeffect]] — Factory's approach
- [[react-hooks]] — General hook patterns
- [[you-might-not-need-an-effect]] — Official React guide
- [[state-derivation]] — Computing values without effects
- [[react-coding-standards]] — Internal React standards (functional components, hooks, Redux)

## Resources

- React docs: https://react.dev/learn/you-might-not-need-an-effect
- Source: https://x.com/alvinsng/status/2033969062834045089
