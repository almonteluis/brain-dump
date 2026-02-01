---
description: JavaScript debounced search implementation with API calls, React hooks, and performance optimization patterns.
tags: ["api", "debounce", "fundamentals", "hooks", "javascript", "optimization", "patterns", "performance", "react"]
---

#javascript #performance #optimization #api #patterns #hooks #react #fundamentals #debounce

# Debounced Search Implementation
Parent: [[👨‍💻JavaScript Roadmap]]

Introduction:
Creating a debounced search component is a common requirement that combines several important JavaScript concepts: debouncing, API calls, and state management.

Knowledge Points:
- [[Debounce Implementation]]
  - setTimeout/clearTimeout
  - Closure patterns
  - Event handling

- [[API Integration]]
  - Fetch/Axios usage
  - Error handling
  - Loading states

- [[Component Architecture]]
  - State management
  - Props interface
  - Event handlers

Explain how you would implement a debounced search input component that makes API calls. The requirements are:

- User input should be debounced by 300ms
- Show loading state while fetching
- Handle error states
- Cancel in-flight requests if user types again
- Implement proper cleanup to prevent memory leaks
- Bonus: Cache previous search results"

This tests multiple important concepts:
- Custom hooks
- Effect cleanup
- [[Race conditions]]
- Performance optimization
- Error handling
- API management
- State management

Let's break this down step by step. I'll help you build the SearchInput component and necessary hooks.

1. First, let's create a custom hook for debouncing:

```typescript
// hooks/useDebounce.ts
import { useState, useEffect } from 'react';

function useDebounce<T>(value: T, delay: number = 300): T {
  const [debouncedValue, setDebouncedValue] = useState<T>(value);

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

2. Now, let's create a hook for handling the search API:

```typescript
// hooks/useSearch.ts
import { useState, useEffect } from 'react';

interface SearchResult {
  id: number;
  name: string;
  // ... other fields
}

interface UseSearchReturn {
  results: SearchResult[];
  isLoading: boolean;
  error: Error | null;
}

export function useSearch(query: string): UseSearchReturn {
  const [results, setResults] = useState<SearchResult[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    // Don't search on empty query
    if (!query.trim()) {
      setResults([]);
      return;
    }

	// what this for?
    const controller = new AbortController();
    const signal = controller.signal;

    const fetchResults = async () => {
      setIsLoading(true);
      setError(null);

      try {
        const response = await fetch(
          `https://api.example.com/search?q=${query}`,
          { signal }
        );
        
        if (!response.ok) {
          throw new Error('Search failed');
        }

        const data = await response.json();
        setResults(data);
      } catch (err: unknown) {
        if (err instanceof Error && err.name === 'AbortError') {
          return; // Ignore abort errors
        }
        setError(err instanceof Error ? err : new Error('Search failed'));
      } finally {
        setIsLoading(false);
      }
    };

    fetchResults();

    // Cleanup: abort fetch on new search or unmount
    return () => {
      controller.abort();
    };
  }, [query]);

  return { results, isLoading, error };
}
```

3. Now let's create the SearchInput component that puts it all together:
In the atomic design system, this `SearchInput` component would be best classified as a **Molecule** or potentially an **Organism**, depending on your application's specific needs. Let's break it down:

1. **Current Structure (Molecule/Organism hybrid)**:
```tsx
SearchInput
├── Input element (Atom)
├── Loading indicator (Atom)
├── Error message (Atom)
└── Results list (Molecule)
    └── Result items (Atoms)
```

## Implementation

2. **Recommended Refactor for Atomic Design**:

```typescript
// atoms/Input.tsx
export const Input = ({ value, onChange, placeholder }: InputProps) => (
  <input
    type="text"
    value={value}
    onChange={onChange}
    placeholder={placeholder}
    className="w-full p-2 border rounded"
  />
);

// atoms/LoadingIndicator.tsx
export const LoadingIndicator = () => (
  <div className="absolute right-2 top-2">
    Loading...
  </div>
);

// atoms/ErrorMessage.tsx
export const ErrorMessage = ({ message }: { message: string }) => (
  <div className="text-red-500">
    {message}
  </div>
);

// molecules/SearchResultItem.tsx
export const SearchResultItem = ({ result }: { result: SearchResults }) => (
  <li className="p-2 border rounded">
    {result.name}
  </li>
);

// molecules/SearchResultsList.tsx
export const SearchResultsList = ({ results }: { results: SearchResults[] }) => (
  <ul className="space-y-2">
    {results.map((result) => (
      <SearchResultItem key={result.id} result={result} />
    ))}
  </ul>
);

// organisms/SearchInput.tsx
export const SearchInput: React.FC = () => {
  const [inputValue, setInputValue] = useState('');
  const debouncedSearch = useDebounce(inputValue, 300);
  const { results, isLoading, error } = useSearch(debouncedSearch);
  const searchResults = useMemo(() => results, [results]);

  return (
    <div className="flex flex-col gap-4">
      <div className="relative">
        <Input
          value={inputValue}
          onChange={(e) => setInputValue(e.target.value)}
          placeholder="Search..."
        />
        {isLoading && <LoadingIndicator />}
      </div>
      {error && <ErrorMessage message={error.message} />}
      <SearchResultsList results={searchResults} />
    </div>
  );
};
```

This refactored version better follows atomic design principles where:
- **Atoms**: The smallest, indivisible components (Input, LoadingIndicator, ErrorMessage)
- **Molecules**: Simple groups of atoms working together (SearchResultItem, SearchResultsList)
- **Organisms**: Complex components composed of molecules and/or atoms (SearchInput)

The final folder structure would look like:
```
src/
├── components/
│   ├── atoms/
│   │   ├── Input.tsx
│   │   ├── LoadingIndicator.tsx
│   │   └── ErrorMessage.tsx
│   ├── molecules/
│   │   ├── SearchResultItem.tsx
│   │   └── SearchResultsList.tsx
│   └── organisms/
│       └── SearchInput.tsx
└── hooks/
    ├── useDebounce.ts
    └── useSearch.ts
```

This organization:
1. Makes components more reusable
2. Follows the single responsibility principle
3. Makes testing easier
4. Creates a clear component hierarchy
5. Makes maintenance and updates more manageable

4. Optional: Add result caching:
```typescript
// hooks/useSearch.ts (modified)
function useSearch(query: string): UseSearchReturn {
  // ... previous state declarations ...
  const [cache, setCache] = useState<Record<string, SearchResult[]>>({});

  useEffect(() => {
    if (!query.trim()) {
      setResults([]);
      return;
    }

    // Check cache first
    if (cache[query]) {
      setResults(cache[query]);
      return;
    }

    const controller = new AbortController();
    // ... rest of fetch logic ...

    const data = await response.json();
    setResults(data);
    // Update cache
    setCache(prev => ({
      ...prev,
      [query]: data
    }));

    // ... rest of the hook ...
  }, [query, cache]);
}
```

For practice, you could use any of these free, public APIs:

1. **GitHub Users Search API** (Popular choice):
```typescript
`https://api.github.com/search/users?q=${query}`
// Returns GitHub users matching the search term
```

2. **Pokemon API** (Simple to use):
```typescript
`https://pokeapi.co/api/v2/pokemon/${query}`
// Returns Pokemon data
```

3. **JSONPlaceholder** (Fake data, but reliable):
```typescript
`https://jsonplaceholder.typicode.com/users?username_like=${query}`
// Returns mock user data
```

Let's use the GitHub API as it's real-world and doesn't require authentication. Here's how we'd modify the useSearch hook:

```typescript
interface GitHubUser {
  id: number;
  login: string;
  avatar_url: string;
  html_url: string;
}

interface GitHubResponse {
  items: GitHubUser[];
  total_count: number;
}

function useSearch(query: string) {
  const [results, setResults] = useState<GitHubUser[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    if (!query.trim()) {
      setResults([]);
      return;
    }

    const controller = new AbortController();

    const fetchResults = async () => {
      setIsLoading(true);
      setError(null);

      try {
        const response = await fetch(
          `https://api.github.com/search/users?q=${query}`,
          { 
            signal: controller.signal,
            headers: {
              'Accept': 'application/vnd.github.v3+json'
            }
          }
        );
        
        if (!response.ok) {
          throw new Error('Search failed');
        }

        const data: GitHubResponse = await response.json();
        setResults(data.items);
      } catch (err) {
        if (err.name === 'AbortError') return;
        setError(err instanceof Error ? err : new Error('Search failed'));
      } finally {
        setIsLoading(false);
      }
    };

    fetchResults();
    return () => controller.abort();
  }, [query]);

  return { results, isLoading, error };
}
```


This implementation:
- Debounces user input to prevent excessive API calls
- Handles loading and error states
- Cancels in-flight requests using AbortController
- Cleans up timeouts and requests on unmount
- Caches results for better performance
- Uses TypeScript for type safety
- Is split into reusable hooks for better maintainability

### Questions: 
Great question! Both [[useEffect]] and useCallback serve different purposes, but there's a reason we choose useEffect for debouncing:

**useEffect** is used when we want to:
- Synchronize with external systems (like timers)
- Handle side effects
- Clean up resources
- React to state/prop changes

**useCallback** is used when we want to:
- Memoize functions
- Prevent unnecessary re-renders
- Pass stable function references to child components

Here's why useEffect is better for debouncing:

```typescript
// ❌ With useCallback:
const debouncedSetValue = useCallback((value: T) => {
  setTimeout(() => {
    setDebouncedValue(value);
  }, delay);
}, [delay]); // Can't include value in deps array

// Problems:
// 1. No cleanup of previous timeouts
// 2. Multiple timeouts can run simultaneously
// 3. Can't properly react to value changes

// ✅ With useEffect:
useEffect(() => {
  const timer = setTimeout(() => {
    setDebouncedValue(value);
  }, delay);

  // Advantages:
  // 1. Cleanup previous timeout
  // 2. Only one timer runs at a time
  // 3. Properly reacts to value changes
  return () => clearTimeout(timer);
}, [value, delay]);
```

Real-world example showing the difference:
```typescript
function SearchComponent() {
  const [text, setText] = useState("");

  // ❌ Wrong approach with useCallback
  const debouncedSearch = useCallback((value: string) => {
    setTimeout(() => {
      console.log("Searching for:", value);
    }, 300);
  }, []); // If we add 'text' here, it defeats the purpose of debouncing

  // ✅ Correct approach with useEffect
  useEffect(() => {
    const timer = setTimeout(() => {
      console.log("Searching for:", text);
    }, 300);

    return () => clearTimeout(timer);
  }, [text]);

  return <input onChange={(e) => setText(e.target.value)} />;
}
```

The key differences:
1. **Cleanup**: [[useEffect]] lets us clean up previous timeouts
2. **Synchronization**: [[useEffect]] better handles synchronizing with the timer system
3. **Dependencies**: [[useEffect]] can properly react to value changes while maintaining the debounce behavior

useCallback would be more appropriate if we were creating a function to pass to child components, like:
```typescript
// This is a good use of useCallback
const handleSearch = useCallback((searchTerm: string) => {
  // Do something with searchTerm
}, [/* dependencies */]);

return <ChildComponent onSearch={handleSearch} />;
```