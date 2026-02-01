---
description: Transitions are a Concurrent Mode feature in React that let you mark UI updates as non-urgent, allowing React to prioritize more critical updates and prevent slower updates from feeling laggy. They help maintain UI responsiveness during expensive state updates.
tags: #react #transitions #concurrent-mode #frontend #performance
---

## Definition
> Transitions are a Concurrent Mode feature in React that let you mark UI updates as non-urgent, allowing React to prioritize more critical updates and prevent slower updates from feeling laggy. They help maintain UI responsiveness during expensive state updates.

## Key Points
- Marks updates as non-urgent
- Prevents UI freezing
- Shows pending state
- Maintains interactivity
- Handles race conditions
- Improves user experience

## How Transitions Work
### 1. Basic Usage
```javascript
import { startTransition, useTransition } from 'react';

function SearchBar() {
  const [query, setQuery] = useState('');
  const [isPending, startTransition] = useTransition();

  const handleChange = (e) => {
    // Urgent: Update input
    setQuery(e.target.value);
    
    // Non-urgent: Update search results
    startTransition(() => {
      setSearchResults(e.target.value);
    });
  };

  return (
    <div>
      <input value={query} onChange={handleChange} />
      {isPending ? <Spinner /> : <SearchResults />}
    </div>
  );
}
```

### 2. Prioritizing Updates
```javascript
function TabContainer() {
  const [tab, setTab] = useState('home');
  const [isPending, startTransition] = useTransition();

  return (
    <div>
      <TabButton 
        onClick={() => {
          startTransition(() => {
            setTab('messages');
          });
        }}
      >
        Messages {isPending && '...'}
      </TabButton>
      <TabPanel>{tab}</TabPanel>
    </div>
  );
}
```

## Best Practices
1. Use for non-urgent UI updates
2. Show pending state appropriately
3. Keep UI responsive
4. Handle loading states
5. Consider user interaction
6. Combine with Suspense when needed

## Common Patterns

### 1. Deferred Value Pattern
```javascript
function SearchResults({ query }) {
  const deferredQuery = useDeferredValue(query);
  
  // Non-urgent render
  const results = useMemo(() => {
    return computeExpensiveResults(deferredQuery);
  }, [deferredQuery]);

  return (
    <div style={{
      opacity: query !== deferredQuery ? 0.8 : 1,
    }}>
      {results}
    </div>
  );
}
```

### 2. Loading States
```javascript
function AsyncImage({ src }) {
  const [isPending, startTransition] = useTransition();
  const [image, setImage] = useState(defaultImage);

  function loadImage(url) {
    startTransition(() => {
      setImage(url);
    });
  }

  return (
    <div className={isPending ? 'loading' : ''}>
      <img src={image} />
    </div>
  );
}
```

## Visual Diagrams

### 1. Transition Flow
```
[User Input] → [Urgent Update] → [Start Transition] → [Complete Update]
     ↓             ↓                    ↓                    ↓
   Type "a"     Update Input      Schedule Update     Show Results
```

### 2. Priority Levels
```
High Priority (Urgent)
├─► Input updates
├─► Click feedback
└─► UI animations

Low Priority (Transition)
├─► Search results
├─► Page transitions
└─► Data filtering
```

## Performance Impact
| Update Type | Response Time | User Experience |
|-------------|---------------|-----------------|
| Regular | Blocking | Can feel laggy |
| Transition | Non-blocking | Stays responsive |
| Deferred | Background | Always smooth |

## Common Pitfalls
```javascript
// ❌ Incorrect: Using transition for urgent updates
startTransition(() => {
  setInputValue(e.target.value);
});

// ✅ Correct: Only transition non-urgent updates
setInputValue(e.target.value); // Urgent
startTransition(() => {
  setFilteredResults(e.target.value); // Non-urgent
});
```

## Implementation Checklist
- [ ] Identify non-urgent updates
- [ ] Implement useTransition
- [ ] Handle pending states
- [ ] Show loading indicators
- [ ] Test user experience
- [ ] Monitor performance

## Real-World Examples

### 1. Search Interface
```javascript
function SearchInterface() {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState([]);
  const [isPending, startTransition] = useTransition();

  function handleSearch(value) {
    setQuery(value); // Urgent: Update input
    startTransition(() => {
      // Non-urgent: Filter and update results
      setResults(filterItems(value));
    });
  }

  return (
    <div>
      <input onChange={e => handleSearch(e.target.value)} />
      {isPending ? <Spinner /> : <ResultsList items={results} />}
    </div>
  );
}
```

### 2. Tab Switching
```javascript
function TabPanel() {
  const [tab, setTab] = useState('home');
  const [isPending, startTransition] = useTransition();

  function selectTab(newTab) {
    startTransition(() => {
      setTab(newTab);
    });
  }

  return (
    <div>
      <nav>
        {tabs.map(tabName => (
          <button
            className={isPending ? 'pending' : ''}
            onClick={() => selectTab(tabName)}
          >
            {tabName}
          </button>
        ))}
      </nav>
      <TabContent tab={tab} />
    </div>
  );
}
```

## Summary
- Transitions improve UX for non-urgent updates
- Help maintain app responsiveness
- Work well with Suspense
- Enable better loading states
- Handle expensive computations gracefully

## Resources
- [React Docs - useTransition](https://react.dev/reference/react/useTransition)
- [React Docs - Transitions](https://react.dev/learn/managing-state)
- [Using Transitions in Practice](https://react.dev/learn/managing-state)
```