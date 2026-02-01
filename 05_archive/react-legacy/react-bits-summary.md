# React Bits - Key Patterns Summary

Quick reference guide for React patterns from react-bits.

---

## Design Patterns

### Presentational vs Container Components

**Problem:** Components mixing data/logic with presentation.

**Solution:** Split into two types:

#### Container Components (Smart/Smart)
- Know about data sources and business logic
- Format data for presentational components
- Handle lifecycle methods and state
- Often use HOCs to create them
- Render only presentational components

```javascript
// Container
export default class ClockContainer extends React.Component {
  state = {time: props.time};

  render() {
    return <Clock {...this._extract(this.state.time)}/>;
  }

  _extract(time) {
    return {
      hours: time.getHours(),
      minutes: time.getMinutes(),
      seconds: time.getSeconds()
    };
  }
}
```

#### Presentational Components (Dumb)
- Concerned with how things look
- No dependencies on data sources
- Often stateless functional components
- Receive data via props

```javascript
// Presentational
export default function Clock({hours, minutes, seconds}) {
  return <h1>{hours} : {minutes} : {seconds}</h1>;
}
```

**Benefits:**
- Separation of concerns
- Easier testing
- Reusable presentational components
- Can swap renderers (e.g., digital → analog clock)

---

### Async Nature of setState()

**Key Points:**
- `setState()` is **asynchronous** — doesn't immediately mutate `this.state`
- React batches updates for performance
- Accessing `this.state` after `setState()` may return old value
- Outside React's control (setTimeout, AJAX, eventListeners), updates are synchronous

**Bad — relying on state immediately:**
```javascript
this.setState({count: this.state.count + 1});
this.setState({count: this.state.count + 1}); // Uses old state!
```

**Good — use callback:**
```javascript
this.setState(
  {count: this.state.count + 1},
  () => {
    console.log('State updated:', this.state.count);
  }
);
```

**Better — use functional setState:**
```javascript
this.setState((prevState, props) => ({
  count: prevState.count + props.increment
}));
```

**When to use each:**
- **Object form:** When update doesn't depend on previous state
- **Function form:** When update depends on previous state
- **Callback:** When you need to do something after state updates

---

### Passing Function to setState()

**Problem:** Multiple `setState()` calls in batch may use stale state.

```javascript
// Bad: this.state.count will be 0 for all three calls
this.setState({count: this.state.count + 1});
this.setState({count: this.state.count + 1});
this.setState({count: this.state.count + 1});
// Result: count = 1, not 3
```

**Solution:** Pass a function that receives previous state:

```javascript
// Good: each call gets the correct previous state
this.setState(prevState => ({count: prevState.count + 1}));
this.setState(prevState => ({count: prevState.count + 1}));
this.setState(prevState => ({count: prevState.count + 1}));
// Result: count = 3
```

**With props:**
```javascript
this.setState((prevState, props) => ({
  count: prevState.count + props.increment
}));
```

**Toggle pattern:**
```javascript
// Bad
this.setState({expanded: !this.state.expanded});

// Good
this.setState(prevState => ({expanded: !prevState.expanded}));
```

---

### React Fragments

**Problem:** Need to return multiple elements without wrapper `<div>`.

**Use case:** Table cells, lists where extra divs break HTML structure.

```javascript
render() {
  return (
    <React.Fragment>
      <td>Table Cell 1</td>
      <td>Table Cell 2</td>
    </React.Fragment>
  );
}

// Shorthand syntax (React 16.2+)
render() {
  return (
    <>
      <td>Table Cell 1</td>
      <td>Table Cell 2</td>
    </>
  );
}
```

**Benefits:**
- No extra DOM elements
- Preserves semantic HTML structure
- Better for CSS grid/flex layouts

---

## Anti-Patterns

### Mutating State Directly

**Problem:** Mutating state without `setState()` won't trigger re-renders.

```javascript
// Bad: mutation
this.state.items.push('lorem');
this.setState({items: this.state.items});
```

**Solution:** Always create new objects/arrays:

```javascript
// Good: immutable update
this.setState(prevState => ({
  items: prevState.items.concat('lorem')
}));

// Or with spread operator
this.setState(prevState => ({
  items: [...prevState.items, 'lorem']
}));
```

**Key rules:**
- Never mutate `this.state` directly
- Always use `setState()`
- Prefer functional `setState` when updating based on previous state
- Use immutable patterns: `concat()`, `filter()`, `map()`, spread operator

---

### Other Anti-Patterns

#### Props in Initial State
**Bad:** `this.state = {count: props.count}`
**Why:** State won't update when props change
**Fix:** Derive state from props in `getDerivedStateFromProps` or render

#### findDOMNode()
**Bad:** Using `ReactDOM.findDOMNode(this)`
**Why:** Breaks abstraction, slow, deprecated
**Fix:** Use refs properly

#### Mixins
**Bad:** Using `React.createClass` with mixins
**Why:** Implicit dependencies, name collisions
**Fix:** Use HOCs, render props, or composition

#### setState() in componentWillMount()
**Bad:** Setting state in `componentWillMount`
**Why:** May cause double-rendering, deprecated lifecycle
**Fix:** Use `componentDidMount` for side effects

#### Using Indexes as Keys
**Bad:** `{items.map((item, i) => <Item key={i} />)}`
**Why:** Breaks with reordering, performance issues
**Fix:** Use stable IDs: `{items.map(item => <Item key={item.id} />)}`

#### Spreading Props on DOM Elements
**Bad:** `<div {...props} />`
**Why:** Passes invalid attributes to DOM
**Fix:** Filter props or use destructuring

---

## Performance Tips

### Pure Components

**What:** `React.PureComponent` implements `shouldComponentUpdate` with shallow comparison.

**When to use:**
- Components with same props/state shouldn't re-render
- Performance is a concern
- Props/state are simple (shallow comparison works)

```javascript
// Instead of React.Component
export default class Example extends PureComponent {
  render() {
    return <SomeComponent someProp={this.props.someProp}/>;
  }
}
```

**How it works:**
- Shallowly compares props and state
- Returns `true` (re-render) only if something changed
- Prevents unnecessary renders for performance

**Gotchas:**
- Only works with shallow comparison (nested objects won't trigger)
- Functions in props cause issues (new reference each render)
- Not a silver bullet — profile first

---

## UX Variations Patterns

### HOC (Higher-Order Component) for Feature Toggles

```javascript
export default function withFeatureToggle(featureFlag) {
  return function(Component) {
    return class FeatureToggleWrapper extends React.Component {
      render() {
        if (this.props.features[featureFlag]) {
          return <Component {...this.props} />;
        }
        return <FallbackComponent {...this.props} />;
      }
    };
  };
}

// Usage
const EnhancedComponent = withFeatureToggle('newFeature')(MyComponent);
```

### Wrapper Components

```javascript
export default function withWrapper(Component) {
  return class Wrapper extends React.Component {
    render() {
      return (
        <div className="wrapper">
          <Component {...this.props} />
        </div>
      );
    }
  };
}
```

---

## Key Takeaways

### State Management
- Always use `setState()`, never mutate directly
- Use functional `setState` when updating based on previous state
- State updates are async — use callbacks for post-update logic

### Component Design
- Separate presentational and container components
- Prefer stateless functional components for UI
- Use `PureComponent` for performance when appropriate
- Avoid anti-patterns: indexes as keys, `findDOMNode`, mixins

### Patterns
- HOCs for cross-cutting concerns (features, tracking, styling)
- Fragments for returning multiple elements
- Container components for data/logic, presentational for UI

### Gotchas
- `setState` is async, but sometimes sync outside React's control
- Functions as props break PureComponent shallow comparison
- Deriving state from props requires careful lifecycle handling
- Direct state mutation causes silent bugs
