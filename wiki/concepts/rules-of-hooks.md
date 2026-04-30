---
description: React's Rules of Hooks ensure component behavior consistency across renders
tags: ["react", "hooks", "patterns"]
sources: ["teame-218-brainbreak-postmortem"]
created: 2026-04-11
updated: 2026-04-11
---

# Rules of Hooks

React's Rules of Hooks ensure component behavior consistency across renders.

## The Two Rules

1. **Only call hooks at the top level** — Don't call hooks inside loops, conditions, or nested functions
2. **Only call hooks from React function components** — Or from custom hooks

## Why This Matters

Hooks rely on call order to work correctly. React tracks which hook corresponds to which piece of state by the order they're called. Breaking the rules causes:
- State to be associated with the wrong hook
- Bugs that are difficult to debug
- Inconsistent behavior between renders

## Common Violations

### Conditional Hooks (Wrong)

```typescript
// ❌ Violation — hook inside condition
if (isLoading) {
  useEffect(() => {
    fetchData();
  }, []);
}
```

### Correct Pattern

```typescript
// ✅ Hook at top level, condition inside
useEffect(() => {
  if (isLoading) {
    fetchData();
  }
}, [isLoading]);
```

### Hooks in Callbacks (Wrong)

```typescript
// ❌ Violation — hook called inside callback
const handleCallback = () => {
  const [state, setState] = useState(initial);
  setState(value);
};
```

### HOC Pattern Violation

```typescript
// ❌ Violation — HOC calling hooks conditionally
function withBrainBreak(callback: () => void) {
  if (someCondition) {
    const data = useSomeHook();
    callback(data);
  }
}
```

### Correct Hook Pattern

```typescript
// ✅ Proper hook — all hooks at top level
function useBrainBreakCallback() {
  const [state, setState] = useState(initial);
  const callback = useCallback(() => {
    setState(value);
  }, [dependencies]);
  return callback;
}
```

## Key-Based Remount Pattern

For user changes that require full state reset, use React's `key` prop instead of manual useEffect cleanup:

```typescript
// ❌ Manual reset with useEffect
useEffect(() => {
  resetState();
}, [userId]);

// ✅ Key-based remount (automatic cleanup)
<BrainBreakProvider key={userId}>
  <ChildComponents />
</BrainBreakProvider>
```

## Related

- [[react-useeffect-patterns]] — When to use useEffect
- [[brainbreak-mvc-refactor]] — Real-world Rules of Hooks fix
- [[key-based-remount]] — Clean component reset pattern
