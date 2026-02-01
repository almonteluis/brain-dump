---
description: useEffect is a React hook that handles side effects and lifecycles in functional components with dependency-based execution control, cleanup support, and external system interactions.
tags: ["flashcards", "hooks", "react", "useEffect"]
---

Q:: What is useEffect and why do we need it in React?
?? useEffect is React's solution for handling side effects in functional components.

Key purposes:
- Performs side effects after component rendering
- Controls execution via dependency array
- Handles external system interactions
- Manages resource cleanup
- Replaces lifecycle methods

The useEffect hook ==runs after==^[timing] the component ==renders==^[execution] and is used for ==side effects==^[external operations.
<!--SR:!2000-01-01,1,250!2025-02-13,1,184!2000-01-01,1,250-->

Basic Pattern:
==useEffect(() => {
  // Effect code
  return () => {
    // Cleanup code
  };
}, [dependencies]);==

Common Patterns:
1. On Mount: ==useEffect(() => {}, [])==^[empty deps]
1. On Update: ==useEffect(() => {})==^[no deps]
2. With Dependencies: ==useEffect(() => {}, [count])==^[specific deps]
<!--SR:!2025-02-17,5,230!2025-03-29,5,228!2025-02-03,2,228-->

[[Data fetching]] Pattern:
==useEffect(() => {
  const fetchData = async () => {
    try {
      const response = await fetch(url);
      const data = await response.json();
      setData(data);
    } catch (error) {
      console.error(error);
    }
  };
  fetchData();
}, [url]);==

Event Listener Pattern:
==useEffect(() => {
  window.addEventListener('event', handler);
  return () => {
    window.removeEventListener('event', handler);
  };
}, []);==[^5]


## Core Concept Understanding

QUESTION: What is useEffect and why do we need it in React?

EVIDENCE:
- 🔄 [SIDE_EFFECT] Allows performing "side effects" in functional components
- 🔄 [TIMING] Executes after component rendering
- 🎯 [CONTROL] Can be controlled via dependency array
- 🛠️ [USAGE] Handles external system interactions
- 🧹 [CLEANUP] Manages resource cleanup

CONCLUSION: useEffect is React's solution for handling [SIDE_EFFECT] operations in functional components, replacing lifecycle methods and providing a way to [SYNC] components with external systems.

## Basic Implementation

### Core Syntax
```javascript
// 📝 [BASIC_PATTERN]
useEffect(() => {
  // 🔄 Effect code (runs after render)
  return () => {
    // 🧹 Cleanup code
  };
}, [dependencies]); // 🎯 Dependency array
```

### Common Patterns

1. **Component Mount** 
```javascript
// 📝 [MOUNT_PATTERN]
useEffect(() => {
  // 🔄 Runs once after initial render
}, []); // 🎯 Empty dependency array
```

2. **Component Update**
```javascript
// 📝 [UPDATE_PATTERN]
useEffect(() => {
  // 🔄 Runs on every render
}); // ⚠️ No dependency array
```

3. **With Dependencies**
```javascript
// 📝 [DEPENDENCY_PATTERN]
useEffect(() => {
  // 🔄 Runs when count changes
}, [count]); // 🎯 Specific dependency
```

4. **Cleanup Pattern**
```javascript
// 📝 [CLEANUP_PATTERN]
useEffect(() => {
  return () => {
    // 🧹 Cleanup code
  };
}, []);
```

## Implementation Patterns

### 1. [[Data fetching]]
```javascript
// 📝 [FETCH_PATTERN]
function UserProfile({ userId }) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // 🔄 [ASYNC_OPERATION]
    const fetchUser = async () => {
      try {
        const response = await fetch(`/api/users/${userId}`);
        const data = await response.json();
        setUser(data);
      } catch (error) {
        // 🔍 [ERROR_HANDLING]
        console.error(error);
      } finally {
        setLoading(false);
      }
    };

    fetchUser();
  }, [userId]); // 🎯 [DEPENDENCY]
}
```

### 2. Event Listeners
```javascript
// 📝 [EVENT_PATTERN]
function ScrollComponent() {
  const [scrollY, setScrollY] = useState(0);

  useEffect(() => {
    // 🛠️ [EVENT_SETUP]
    const handleScroll = () => {
      setScrollY(window.scrollY);
    };

    window.addEventListener('scroll', handleScroll);

    // 🧹 [EVENT_CLEANUP]
    return () => {
      window.removeEventListener('scroll', handleScroll);
    };
  }, []); 
}
```
[[Common Patterns for useEffect]]
## Best Practices & Gotchas

QUESTION: What are the key considerations when using useEffect?

EVIDENCE:

1. **Dependency Management**
```javascript
// ⚠️ [DEPENDENCY_MANAGEMENT]
function Example({ id, query }) {
  useEffect(() => {
    fetchData(id, query);
  }, [id, query]); // 🎯 [REQUIRED_DEPS]
}
```

2. **Race Condition Prevention**
```javascript
// 🚀 [RACE_CONDITION]
useEffect(() => {
  let mounted = true;
  async function fetchData() {
    const result = await getData();
    if (mounted) {
      setData(result);
    }
  }
  fetchData();
  return () => {
    mounted = false;
  };
}, []);
```

## Quick Reference for Interviews

KEY CONCEPTS:
- 🔄 [EXECUTION] Runs after render
- 🧹 [CLEANUP] Prevents memory leaks
- 🎯 [DEPENDENCIES] Controls effect execution
- ⚠️ [PITFALL] Stale closures
- 🚀 [PERFORMANCE] Optimization via dependencies

COMMON ISSUES:
- ⚠️ Infinite re-render loops
- ⚠️ Missing dependencies
- ⚠️ Memory leaks
- ⚠️ Race conditions
- ⚠️ Stale closures

## Tag Reference
---
- 🔄 Core concepts
- 🧹 Cleanup
- 🎯 Dependencies
- ⚠️ Common Pitfalls
- 🛠️ Implementation
- 🔍 Debugging
- 🚀 Performance
- 📝 Pattern