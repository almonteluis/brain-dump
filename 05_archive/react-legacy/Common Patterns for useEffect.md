---
description: # Common Patterns.
tags: #react #use-effect #hooks #patterns #frontend
---

## Common Patterns

### Conditional Effects
```javascript
useEffect(() => {
  if (isEnabled) {
    // Only run effect if enabled
  }
}, [isEnabled]);
```

### Multiple Effects
```javascript
function MultipleEffects() {
  useEffect(() => {
    // Handle one concern
  }, []);

  useEffect(() => {
    // Handle different concern
  }, [differentDependency]);
}
```

### Async Effects
```javascript
useEffect(() => {
  let mounted = true;

  const loadData = async () => {
    const result = await fetchData();
    if (mounted) {
      setData(result);
    }
  };

  loadData();

  return () => {
    mounted = false;
  };
}, []);
```
