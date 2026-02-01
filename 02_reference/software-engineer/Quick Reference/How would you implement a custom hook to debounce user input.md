---
description: Implement a custom debounce hook in React using useState, useEffect, and setTimeout to delay input processing until a specified time has passed since the last keystroke.
tags: ["custom-hooks", "debounce", "hooks", "interview", "optimization", "performance-optimization", "react", "setTimeout", "useEffect"]
---

# Debounce Custom Hook

## Overview


#react #hooks #debounce #optimization #interview

> A debounce hook delays function execution until after a pause in frequent events (like typing), useful for preventing excessive API calls or expensive operations.

```javascript
function useDebounce(value, delay = 500) {
  const [debouncedValue, setDebouncedValue] = useState(value);

  useEffect(() => {
    const timer = setTimeout(() => {
      setDebouncedValue(value);
    }, delay);

    return () => clearTimeout(timer);
  }, [value, delay]);

  return debouncedValue;
}

// Usage
function SearchComponent() {
  const [search, setSearch] = useState('');
  const debouncedSearch = useDebounce(search, 500);

  useEffect(() => {
    if (debouncedSearch) {
      // Make API call
      fetchResults(debouncedSearch);
    }
  }, [debouncedSearch]);
}
```

#### Key Points:
* Prevents excessive function calls during rapid changes
* Cleans up timeout to prevent memory leaks
* Commonly used for search inputs or API calls
* Returns stable value after specified delay
- [[custom debounce hook in React]]
#### Additional Tags:
#custom-hooks #useEffect #setTimeout #performance-optimization​​​​​​​​​​​​​​​​

