---
description: useState manages component state with functional updates and callback access to previous values, enabling dynamic data in functional components.
tags: #react #hooks #state #use-state
date: 2026-01-31
---

# useState Manages Component State

useState is the fundamental hook for adding state to functional components.

## Basic Usage

```javascript
const [count, setCount] = useState(0);
```

## Functional Updates

```javascript
// When new state depends on old state
setCount(prev => prev + 1);
```

## Object State

```javascript
const [user, setUser] = useState({ name: '', age: 0 });

// Update specific property
setUser(prev => ({ ...prev, name: 'Alice' }));
```

## Related Notes

- [[use-effect.md]] - Side effects with state
- [[../01_fundamentals/react-core-concepts.md]] - State vs props
