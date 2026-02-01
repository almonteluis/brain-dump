---
description: React state management patterns include local component state, context API, and external libraries like Redux, each suited for different application scales.
tags: #react #architecture #state-management #context #redux
date: 2026-01-31
---

# State Management Patterns Scale with Application Complexity

Choosing the right state management approach depends on application size and complexity.

## Decision Guide

| Scenario | Solution |
|----------|----------|
| Single component state | useState |
| 2-3 sibling components | Lift state up |
| Deep nesting | Context API |
| Complex state logic | useReducer |
| Global app state | Zustand / Jotai / Redux |

## Context API Example

```javascript
const AuthContext = createContext();

function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  return (
    <AuthContext.Provider value={{ user, setUser }}>
      {children}
    </AuthContext.Provider>
  );
}
```

## Related Notes

- [lifting-state-up.md] - Parent-child state sharing
- [../03_patterns/context-api.md] - Context API deep dive
