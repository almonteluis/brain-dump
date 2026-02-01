---
description: React Concurrent Mode - concurrent rendering, transitions, useTransition, Suspense, and interruptible rendering for smooth UI
tags: [react, concurrent-mode, suspense, transitions, useTransition, performance, rendering]
---

# React Concurrent Mode

React Concurrent Mode (now a feature set in React 18+) enables React to interrupt rendering work, prioritize high-priority updates, and keep apps responsive even during heavy computations.

## Core Concepts

### What is Concurrent Rendering?

Concurrent rendering allows React to:
- **Interrupt** rendering to handle higher-priority events
- **Defer** non-urgent updates to keep UI responsive
- **Reuse** previous render work if interrupted
- **Batch** multiple state updates automatically

React 18 enables concurrent features by default in React 18+ with the new root API:

```tsx
// ✅ Enable concurrent features (React 18+)
const root = createRoot(document.getElementById('root'));
root.render(<App />);

// ❌ Legacy API (no concurrent features)
ReactDOM.render(<App />, document.getElementById('root'));
```

### Concurrent Features

| Feature | Purpose | Hook/Component |
|---------|---------|----------------|
| Automatic Batching | Group multiple state updates | Enabled by default |
| Transitions | Mark non-urgent updates | `useTransition` |
| Deferred Values | Defer expensive computations | `useDeferredValue` |
| Suspense | Handle async operations | `<Suspense>` |
| Optimistic UI | Show immediate feedback | `useOptimistic` |

## Transitions

Transitions separate **urgent updates** (typing, clicking) from **non-urgent updates** (search results, filtering).

### Basic useTransition

```tsx
import { useState, useTransition } from 'react';

export function Search() {
  const [query, setQuery] = useState('');
  const [isPending, startTransition] = useTransition();
  const [results, setResults] = useState<Results>([]);

  const handleSearch = (value: string) => {
    // Urgent: update input immediately
    setQuery(value);

    // Non-urgent: search in transition
    startTransition(() => {
      const filtered = performExpensiveSearch(value);
      setResults(filtered);
    });
  };

  return (
    <div>
      <input
        type="text"
        value={query}
        onChange={e => handleSearch(e.target.value)}
        disabled={isPending}
      />
      {isPending && <div className="loading">Searching...</div>}
      <ResultsList results={results} />
    </div>
  );
}

// Can also use for async operations
function handleAsyncSearch(value: string) {
  setQuery(value);

  startTransition(async () => {
    const data = await fetchSearchResults(value);
    setResults(data);
  });
}
```

### useTransition Patterns

```tsx
// Pattern 1: Search/Filter with transitions
export function FilterableList({ items }: { items: Item[] }) {
  const [filter, setFilter] = useState('');
  const [isPending, startTransition] = useTransition();

  const filteredItems = items.filter(item =>
    item.name.toLowerCase().includes(filter.toLowerCase())
  );

  return (
    <div>
      <input
        value={filter}
        onChange={e => {
          // Urgent: update input value
          setFilter(e.target.value);
        }}
        placeholder="Filter items..."
      />

      {isPending && <div className="skeleton" />}

      <ul>
        {filteredItems.map(item => (
          <li key={item.id}>{item.name}</li>
        ))}
      </ul>
    </div>
  );
}

// Pattern 2: Tab switching with heavy content
export function TabbedInterface() {
  const [activeTab, setActiveTab] = useState('home');
  const [isPending, startTransition] = useTransition();

  const tabs = [
    { id: 'home', label: 'Home', component: HomeContent },
    { id: 'analytics', label: 'Analytics', component: AnalyticsContent },
    { id: 'reports', label: 'Reports', component: ReportsContent }
  ];

  const ActiveComponent = tabs.find(t => t.id === activeTab)!.component;

  return (
    <div>
      <nav>
        {tabs.map(tab => (
          <button
            key={tab.id}
            onClick={() => {
              startTransition(() => {
                setActiveTab(tab.id);
              });
            }}
            disabled={isPending}
          >
            {tab.label}
          </button>
        ))}
      </nav>

      {isPending && <div className="loading" />}
      <ActiveComponent />
    </div>
  );
}
```

### useDeferredValue

Defer expensive computations by using a stale value during high-priority updates:

```tsx
import { useState, useDeferredValue } from 'react';

export function LargeList({ items }: { items: Item[] }) {
  const [filter, setFilter] = useState('');

  // Deferred version for expensive filtering
  const deferredFilter = useDeferredValue(filter);

  // Use deferred value for heavy computation
  const filteredItems = useMemo(() => {
    return items.filter(item =>
      item.name.toLowerCase().includes(deferredFilter.toLowerCase())
    );
  }, [items, deferredFilter]);

  return (
    <div>
      <input
        value={filter}
        onChange={e => setFilter(e.target.value)}
        placeholder="Filter..."
      />

      {/* Input stays responsive even during heavy filtering */}
      <ul>
        {filteredItems.map(item => (
          <li key={item.id}>{item.name}</li>
        ))}
      </ul>
    </div>
  );
}

// More complex: defer entire data structure
export function ExpensiveVisualization({ data }: { data: Data }) {
  const [zoom, setZoom] = useState(1);
  const deferredData = useDeferredValue(data);

  const chart = useMemo(() => {
    // Expensive computation
    return createChart(deferredData, zoom);
  }, [deferredData, zoom]);

  return (
    <div>
      <input
        type="range"
        min={0.5}
        max={2}
        step={0.1}
        value={zoom}
        onChange={e => setZoom(Number(e.target.value))}
      />
      <svg>{chart}</svg>
    </div>
  );
}
```

## Suspense in Concurrent Mode

Suspense works seamlessly with concurrent features to provide smooth loading states.

### Suspense with Transitions

```tsx
import { Suspense } from 'react';

export function ProfilePage({ userId }: { userId: string }) {
  const [tab, setTab] = useState('profile');
  const [isPending, startTransition] = useTransition();

  return (
    <div>
      <nav>
        <button onClick={() => setTab('profile')}>Profile</button>
        <button
          onClick={() => startTransition(() => setTab('posts'))}
        >
          Posts
        </button>
      </nav>

      <Suspense fallback={<ProfileSkeleton />}>
        {tab === 'profile' && <UserProfile userId={userId} />}
        {tab === 'posts' && <UserPosts userId={userId} />}
      </Suspense>

      {isPending && <div className="loading-indicator" />}
    </div>
  );
}

// Data fetching with Suspense
async function UserProfile({ userId }: { userId: string }) {
  const user = await fetchUser(userId); // Suspends until resolved

  return (
    <div>
      <h1>{user.name}</h1>
      <p>{user.bio}</p>
    </div>
  );
}
```

### Multiple Suspense Boundaries

```tsx
export function Dashboard() {
  return (
    <div className="dashboard">
      <header>
        <Suspense fallback={<UserNavSkeleton />}>
          <UserNav />
        </Suspense>
      </header>

      <main>
        <section>
          <Suspense fallback={<StatsSkeleton />}>
            <DashboardStats />
          </Suspense>
        </section>

        <section>
          <Suspense fallback={<RecentPostsSkeleton />}>
            <RecentPosts />
          </Suspense>
        </section>

        <section>
          <Suspense fallback={<ChartSkeleton />}>
            <AnalyticsChart />
          </Suspense>
        </section>
      </main>
    </div>
  );
}
```

## Concurrent Rendering Patterns

### 1. List with Expensive Items

```tsx
export function ExpensiveList({ items }: { items: Item[] }) {
  const [filter, setFilter] = useState('');
  const [isPending, startTransition] = useTransition();
  const deferredFilter = useDeferredValue(filter);

  const filtered = useMemo(() =>
    items.filter(item =>
      item.text.toLowerCase().includes(deferredFilter.toLowerCase())
    ),
    [items, deferredFilter]
  );

  return (
    <div>
      <input
        value={filter}
        onChange={e => {
          setFilter(e.target.value);
          startTransition(() => {
            // Optional: defer the state update itself
            setFilter(e.target.value);
          });
        }}
      />

      {isPending && <div className="loading" />}

      <VirtualizedList items={filtered} renderItem={ExpensiveItem} />
    </div>
  );
}
```

### 2. Form with Validation

```tsx
export function FormWithValidation() {
  const [field, setField] = useState('');
  const [errors, setErrors] = useState<Errors>({});
  const [isPending, startTransition] = useTransition();

  const handleChange = (value: string) => {
    // Urgent: update field value
    setField(value);

    // Non-urgent: validate
    startTransition(() => {
      const newErrors = validateField(value);
      setErrors(newErrors);
    });
  };

  return (
    <form>
      <input
        value={field}
        onChange={e => handleChange(e.target.value)}
      />

      {isPending && <span className="validating" />}
      {errors.field && <span className="error">{errors.field}</span>}
    </form>
  );
}
```

### 3. Infinite Scroll with Suspense

```tsx
export function InfiniteFeed() {
  const [items, setItems] = useState<Item[]>([]);
  const [page, setPage] = useState(1);
  const [isPending, startTransition] = useTransition();

  const loadMore = () => {
    startTransition(async () => {
      const newItems = await fetchItems(page + 1);
      setItems(prev => [...prev, ...newItems]);
      setPage(p => p + 1);
    });
  };

  return (
    <div>
      {items.map(item => (
        <div key={item.id}>{item.content}</div>
      ))}

      {isPending && <div className="loading-more" />}
      <button onClick={loadMore}>Load More</button>
    </div>
  );
}
```

## Concurrent Features with Server Components

```tsx
// app/dashboard/page.tsx (Server Component)
import { Suspense } from 'react';

export default async function Dashboard() {
  return (
    <div>
      <h1>Dashboard</h1>

      <Suspense fallback={<StatsSkeleton />}>
        <DashboardStats />
      </Suspense>

      <Suspense fallback={<ChartSkeleton />}>
        <AnalyticsChart />
      </Suspense>
    </div>
  );
}

// components/analytics-chart.client.tsx
'use client';

import { useDeferredValue, Suspense } from 'react';

export function AnalyticsChart({ data }: { data: Data }) {
  const deferredData = useDeferredValue(data);

  return (
    <div>
      <Suspense fallback={<ChartSkeleton />}>
        <Chart data={deferredData} />
      </Suspense>
    </div>
  );
}
```

## Performance Considerations

### When to use Transitions

✅ **Use transitions for:**
- Filtering large lists
- Tab/page navigation with heavy content
- Search suggestions
- Rendering large datasets
- Non-urgent analytics updates

❌ **Don't use transitions for:**
- Button clicks that must respond immediately
- Form submissions
- Drag-and-drop operations
- Any user interaction requiring instant feedback

### Best Practices

```tsx
// ✅ GOOD: Separate urgent from non-urgent
function Search() {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState([]);
  const [isPending, startTransition] = useTransition();

  return (
    <>
      <input
        value={query}
        onChange={e => {
          setQuery(e.target.value); // Urgent
          startTransition(() => {
            setResults(search(e.target.value)); // Non-urgent
          });
        }}
      />
      {isPending && <Spinner />}
      <Results results={results} />
    </>
  );
}

// ❌ BAD: Everything in transition (unresponsive input)
function BadSearch() {
  const [query, setQuery] = useState('');
  const [isPending, startTransition] = useTransition();

  return (
    <input
      onChange={e => startTransition(() => setQuery(e.target.value))}
    />
  );
}
```

## Debugging Concurrent Features

```tsx
import { useDebugValue } from 'react';

function useTransitionDebug() {
  const [isPending, startTransition] = useTransition();

  useDebugValue(isPending ? 'Transition in progress' : 'Idle');

  return [isPending, startTransition] as const;
}

// React DevTools shows transition updates with different colors
// Yellow = urgent update
// Purple = transition (non-urgent) update
```

## Use Cases

1. **Search/Filter UIs** - Keep input responsive while filtering large datasets
2. **Tabbed interfaces** - Smooth tab switching with heavy content
3. **Dashboards** - Defer expensive chart/data computations
4. **Infinite scroll** - Smooth loading of additional items
5. **Real-time updates** - Prioritize user interactions over background updates

## Migration Guide

### From Legacy to Concurrent

```tsx
// ❌ Before (React 17)
function App() {
  const [query, setQuery] = useState('');

  const handleSearch = (value: string) => {
    setQuery(value);
    // Immediate, blocks input during expensive search
    const results = performSearch(value);
    // ...
  };

  return <SearchInput onChange={handleSearch} />;
}

// ✅ After (React 18+)
function App() {
  const [query, setQuery] = useState('');
  const [isPending, startTransition] = useTransition();

  const handleSearch = (value: string) => {
    setQuery(value);
    startTransition(() => {
      const results = performSearch(value);
      // ...
    });
  };

  return (
    <>
      <SearchInput value={query} onChange={handleSearch} />
      {isPending && <Spinner />}
    </>
  );
}
```

## See Also

- [[react-server-components]] - Server Components and Suspense
- [[modern-react-hooks]] - useOptimistic, useDeferredValue
- [[suspense-deep-dive]] - Suspense for data fetching
- [[error-boundary-patterns]] - Error handling with Suspense

## Resources

- [React 18 Documentation - Concurrent Features](https://react.dev/blog/2022/03/29/react-v18#new-features)
- [useTransition API Reference](https://react.dev/reference/react/useTransition)
- [useDeferredValue API Reference](https://react.dev/reference/react/useDeferredValue)
- [Suspense for Data Fetching](https://react.dev/reference/react/Suspense)
