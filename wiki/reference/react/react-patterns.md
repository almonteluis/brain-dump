---
description: React patterns and best practices from industry standards including Airbnb style guide and 2026 React Compiler patterns
tags:
  - react
  - javascript
  - pattern
  - best-practices
  - reference
  - react/compiler
  - concurrent-rendering
created: 2026-04-08
updated: 2026-04-09
sources:
  - airbnb-react-patterns-summary.md
  - React Design Patterns Research 2026.md
---

# React Patterns

Industry-standard patterns for writing maintainable, performant React applications.

## Component Structure

### Stateful vs Stateless

| Type          | When to Use          | Syntax                          |
| ------------- | -------------------- | ------------------------------- |
| **Stateful**  | Internal state, refs | `class extends React.Component` |
| **Stateless** | No state/refs        | Normal function (not arrow)     |

### File Organization

- **One component per file** (multiple stateless OK)
- **Extension:** `.jsx`
- **Naming:** PascalCase (`ReservationCard.jsx`)

---

## Architecture Patterns (2026)

### Container/Presentational Pattern

Separate data logic from UI rendering:

- **Container components**: Handle data fetching, state management, business logic
- **Presentational components**: Focus purely on rendering UI based on props
- **Benefit**: Improved testability and separation of concerns

### Compound Components

Build flexible UI elements where parent and child share state implicitly:

```jsx
<Tabs>
  <Tabs.List>
    <Tabs.Trigger value="1">Tab 1</Tabs.Trigger>
    <Tabs.Trigger value="2">Tab 2</Tabs.Trigger>
  </Tabs.List>
  <Tabs.Content value="1">Content 1</Tabs.Content>
  <Tabs.Content value="2">Content 2</Tabs.Content>
</Tabs>
```

- Ideal for design systems and reusable libraries
- Users compose without explicitly defining behavior

---

## React Compiler Patterns (2026)

The React Compiler has moved from experimental to **recommended status**.

### Migration Strategy

1. **Remove manual memoization** — `useMemo`, `useCallback`, `React.memo`
2. **Let compiler optimize** — Automatic dependency tracking
3. **Write cleaner code** — Focus on business logic, not optimizations

### When to Keep Manual Memoization

- **Without compiler**: Use `React.memo` for expensive components
- **Without compiler**: Use `useMemo`/`useCallback` for expensive calculations
- **With compiler**: Remove all manual memoization

---

## Concurrent Rendering

### useTransition

Mark non-urgent updates to keep UI responsive:

```jsx
const [isPending, startTransition] = useTransition();

const handleSearch = (value) => {
  startTransition(() => {
    setSearchQuery(value); // Non-urgent update
  });
};
```

**Use for:** Search filtering, pagination, sorting — anything that shouldn't block user input.

### Suspense for Lazy Loading

```jsx
const Analytics = React.lazy(() => import("./Analytics"));

<Suspense fallback={<Loader />}>
  <Analytics />
</Suspense>
```

**Benefits:**
- Defer loading of heavy components
- Reduce initial bundle size
- Show loading fallbacks

---

## State Management Patterns

### Provider Pattern with Context

```jsx
const ThemeContext = createContext();

function ThemeProvider({ children }) {
  const [theme, setTheme] = useState('light');
  const value = useMemo(() => ({ theme, setTheme }), [theme]);

  return (
    <ThemeContext.Provider value={value}>
      {children}
    </ThemeContext.Provider>
  );
}
```

**Best practices:**
- Use `useMemo` for provider values to prevent re-renders
- Ideal for: theme, user auth, cart data
- Avoid deeply nested context trees

### Reducer Pattern with useReducer

Centralize complex state transitions:

```jsx
const [state, dispatch] = useReducer(reducer, initialState);

dispatch({ type: 'increment', payload: 5 });
```

**Use for:** Multi-step forms, complex conditional logic, state machines.

---

## Naming Conventions

| Item | Convention | Example |
|------|------------|---------|
| Files | PascalCase | `ReservationCard.jsx` |
| Component refs | PascalCase | `ReservationCard` |
| Instances | camelCase | `reservationItem` |
| Props | camelCase | `myProp` |

### Higher-Order Components

Set `displayName` to show relationship:

```jsx
WithFoo.displayName = `withFoo(${wrappedComponentName})`;
```

---

## JSX Syntax

### Quotes
- **Attributes:** Double quotes `"bar"`
- **JS expressions:** Single quotes `'20px'`

```jsx
<Foo bar="bar" style={{ left: '20px' }} />
```

### Spacing
- **Self-closing tags:** One space before slash `<Foo />`
- **Curly braces:** No padding `{bar}`

---

## Props Best Practices

### Boolean Props
Omit value when `true`:

```jsx
<Foo hidden />         // good
<Foo hidden={true} />  // bad
```

### Default Props
Always define for non-required props.

### Keys
Use stable IDs, never array indexes:

```jsx
// Bad
{todos.map((todo, index) => <Todo key={index} />)}

// Good
{todos.map(todo => <Todo key={todo.id} />)}
```

---

## Event Handlers

Bind in constructor, not render:

```jsx
// Good
constructor(props) {
  super(props);
  this.onClickDiv = this.onClickDiv.bind(this);
}

// Bad - creates new function every render
onClick={this.onClickDiv.bind(this)}
```

Arrow functions OK for passing additional data:

```jsx
<Item onClick={(event) => { doSomethingWith(event, item.id); }} />
```

---

## Custom Hooks Strategy

Encapsulate reusable logic:

```jsx
function useLocalStorage(key, initialValue) {
  const [value, setValue] = useState(() => {
    const item = localStorage.getItem(key);
    return item ? JSON.parse(item) : initialValue;
  });

  useEffect(() => {
    localStorage.setItem(key, JSON.stringify(value));
  }, [key, value]);

  return [value, setValue];
}
```

**Benefits:**
- Keep components focused on rendering
- Test hooks independently
- Reuse logic across components

---

## Performance Optimization

### List Virtualization

Essential for large lists:

```jsx
import { FixedSizeList } from 'react-window';

<FixedSizeList
  height={500}
  itemCount={10000}
  itemSize={35}
>
  {Row}
</FixedSizeList>
```

**Libraries:** `react-window`, `react-virtualized`

### Strategic Memoization (Pre-Compiler)

| Pattern | When to Use |
|---------|-------------|
| `React.memo` | Expensive components with same props |
| `useMemo` | Expensive calculations |
| `useCallback` | Functions passed to optimized children |

### Code Splitting

```jsx
const HeavyComponent = React.lazy(() => import('./HeavyComponent'));
```

---

## Project Structure

### Atomic Design Organization

```
src/
├── atoms/        # Buttons, inputs, labels
├── molecules/    # Search bars, form fields
├── organisms/    # Headers, cards, navs
├── templates/    # Page layouts
└── pages/        # Route-level components
```

**Reported impact:** ~70% reduction in code duplication

### Folder Best Practices

- Separate **Logic** (hooks, utilities) from **Design** (styles, layouts)
- Use absolute imports (`@/components`) over relative paths

---

## Accessibility

- Always include `alt` prop on images
- Don't use redundant words like "picture of"
- Use only valid, non-abstract ARIA roles
- Don't use `accessKey`

---

## Anti-Patterns to Avoid

### 2026 Specific
1. **Overusing `useEffect`** — Many side effects belong in event handlers
2. **Disabling Strict Mode** — Essential for concurrent rendering
3. **Premature manual optimization** — Let React Compiler handle it first
4. **Monolithic components** — Break into single-responsibility units

### General
- ❌ `isMounted()` — deprecated
- ❌ Array indexes as keys
- ❌ Mixins
- ❌ `React.createClass`
- ❌ Arrow function class properties for handlers
- ❌ String refs

---

## Mental Models

- **Developer experience through automation** — React Compiler eliminates manual optimization
- **Performance through concurrency** — Transitions and Suspense keep UI responsive
- **Maintainability through functional patterns** — Hooks, reducers, pure functions
- **Composition over inheritance** — Flexible, reusable components via children prop

---

## Related

- [[react]]
- [[react-design-patterns-research-2026]]
- [[atomic-design]]
- [[performance-patterns]]
