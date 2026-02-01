---
description: Notes about custom debounce hook in React.
tags: #react #hooks #debounce #custom-hooks #performance
---


description: Implementation.
---

**Key Points:**
* Delays execution of a function
* Prevents excessive API calls
* Useful for search inputs
* Improves performance

# Implementation

## 1. Basic Debounce Hook
```javascript
import { useState, useEffect } from 'react';

function useDebounce(value, delay = 500) {
  const [debouncedValue, setDebouncedValue] = useState(value);

  useEffect(() => {
    const timer = setTimeout(() => {
      setDebouncedValue(value);
    }, delay);

    return () => {
      clearTimeout(timer);
    };
  }, [value, delay]);

  return debouncedValue;
}
```

## 2. Usage Example
```javascript
function SearchComponent() {
  const [searchTerm, setSearchTerm] = useState('');
  const debouncedSearch = useDebounce(searchTerm, 500);

  useEffect(() => {
    if (debouncedSearch) {
      // Make API call here
      searchApi(debouncedSearch);
    }
  }, [debouncedSearch]);

  return (
    <input
      type="text"
      value={searchTerm}
      onChange={(e) => setSearchTerm(e.target.value)}
      placeholder="Search..."
    />
  );
}
```

## 3. Advanced Debounce Hook
```javascript
function useDebounceCallback(callback, delay = 500) {
  const [timer, setTimer] = useState(null);

  const debouncedCallback = useCallback((...args) => {
    if (timer) clearTimeout(timer);

    const newTimer = setTimeout(() => {
      callback(...args);
    }, delay);

    setTimer(newTimer);
  }, [callback, delay, timer]);

  useEffect(() => {
    return () => {
      if (timer) clearTimeout(timer);
    };
  }, [timer]);

  return debouncedCallback;
}
```

## Best Practices

### With Loading State
```javascript
function useDebounceWithLoading(value, delay = 500) {
  const [debouncedValue, setDebouncedValue] = useState(value);
  const [isLoading, setIsLoading] = useState(false);

  useEffect(() => {
    setIsLoading(true);
    const timer = setTimeout(() => {
      setDebouncedValue(value);
      setIsLoading(false);
    }, delay);

    return () => {
      clearTimeout(timer);
      setIsLoading(false);
    };
  }, [value, delay]);

  return { debouncedValue, isLoading };
}
```

### With Error Handling
```javascript
function SearchWithError() {
  const [search, setSearch] = useState('');
  const [error, setError] = useState(null);
  const debouncedSearch = useDebounce(search);

  useEffect(() => {
    async function fetchData() {
      try {
        const results = await searchApi(debouncedSearch);
        setError(null);
      } catch (err) {
        setError(err.message);
      }
    }

    if (debouncedSearch) {
      fetchData();
    }
  }, [debouncedSearch]);

  return (
    <div>
      <input
        value={search}
        onChange={(e) => setSearch(e.target.value)}
      />
      {error && <div className="error">{error}</div>}
    </div>
  );
}
```

### With Cancelable Requests
```javascript
function useDebounceWithCancel(value, delay) {
  const [debouncedValue, setDebouncedValue] = useState(value);
  const cancelRequest = useRef(null);

  useEffect(() => {
    if (cancelRequest.current) {
      cancelRequest.current();
    }

    const timer = setTimeout(() => {
      setDebouncedValue(value);
    }, delay);

    return () => {
      clearTimeout(timer);
      if (cancelRequest.current) {
        cancelRequest.current();
      }
    };
  }, [value, delay]);

  return {
    debouncedValue,
    setCancelRequest: (cancelFn) => {
      cancelRequest.current = cancelFn;
    }
  };
}
```

### Performance Tips
```javascript
// Memoize callback function
const debouncedCallback = useCallback(
  debounce((value) => {
    // Handle debounced value
  }, 500),
  []
);

// Clean up on unmount
useEffect(() => {
  return () => {
    debouncedCallback.cancel();
  };
}, [debouncedCallback]);
```

Remember:
* Choose appropriate delay times
* Clean up timeouts
* Handle loading states
* Implement error handling
* Consider cancelable requests
* Use proper TypeScript types
* Test edge cases
* Document usage examples
* Consider performance implications
* Handle race conditions​​​​​​​​​​​​​​​​