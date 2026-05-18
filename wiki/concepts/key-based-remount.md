---
description: Using React's key prop to force clean component remount instead of manual useEffect cleanup
tags:
  - react
  - pattern
  - refactor
sources:
  - teame-218-brainbreak-postmortem
created: 2026-04-11
updated: 2026-04-11
---

# Key-Based Remount Pattern

React's key prop can force component remounting for clean state reset — a preferred alternative to manual useEffect cleanup.

## Problem: Manual State Reset

```typescript
// ❌ Manual reset with useEffect (error-prone)
function BrainBreakProvider({ userId, children }) {
  const [state, setState] = useState(initialState);

  useEffect(() => {
    // Reset 6 different state values when userId changes
    setState({
      step: 1,
      confidenceValue: null,
      selectedEmotions: [],
      hasSeenBrainBreak: false,
      isQualified: false,
      timerStarted: false
    });
  }, [userId]);

  return <Context.Provider value={state}>{children}</Context.Provider>;
}
```

## Solution: Key-Based Remount

```typescript
// ✅ Key-based remount (automatic cleanup)
function BrainBreakProvider({ userId, children }) {
  const [state, setState] = useState(initialState);

  return (
    <Context.Provider value={state} key={userId}>
      {children}
    </Context.Provider>
  );
}
```

## How It Works

When `key` changes:
1. React unmounts the old component instance
2. React creates a fresh component instance
3. All state is reset to initial values
4. All effects are cleaned up and re-run

## Benefits

| Aspect | Manual useEffect | Key-Based |
|--------|-----------------|-----------|
| Lines of code | 6+ reset lines | 1 prop change |
| Omission risk | High (forget one state) | None (automatic) |
| Effect cleanup | Manual dependencies | Automatic |
| Cognitive load | High (track all state) | Low (React handles) |

## When to Use

- User authentication changes
- Tenant/organization switches
- Data source changes requiring fresh state
- Any scenario requiring complete component reset

## Real-World Example

From TEAME-218 BrainBreak implementation:

```typescript
// Before: 6-state reset useEffect
useEffect(() => {
  resetSessionState();
}, [userId]);

// After: Key-based remount
<BrainBreakProvider key={userId}>
  {children}
</BrainBreakProvider>
```

## Related

- [[rules-of-hooks]] — Hooks must be called at top level
- [[react-useeffect-patterns]] — When to avoid useEffect
- [[teame-218-brainbreak-postmortem]] — Real-world application
