# Airbnb React Patterns - Key Takeaways

Quick reference guide based on Airbnb's React/JSX Style Guide.

## Core Principles

- **One component per file** (multiple stateless components OK)
- **Always use JSX syntax** (no `React.createElement` except in non-JSX files)
- **No mixins** — use HOCs, utility modules, or composition instead

---

## Component Types

### Stateful Components
Use `class extends React.Component` when you have:
- Internal state
- Refs

```jsx
class Listing extends React.Component {
  render() {
    return <div>{this.state.hello}</div>;
  }
}
```

### Stateless Components
Use normal functions (not arrow functions) when no state/refs:

```jsx
// Good
function Listing({ hello }) {
  return <div>{hello}</div>;
}

// Bad (arrow function)
const Listing = ({ hello }) => <div>{hello}</div>;
```

---

## Naming Conventions

- **Files**: PascalCase (`ReservationCard.jsx`)
- **Extension**: `.jsx`
- **Component references**: PascalCase
- **Instances**: camelCase

```jsx
import ReservationCard from './ReservationCard';
const reservationItem = <ReservationCard />;
```

### Higher-Order Components
Set `displayName` to show the relationship:

```jsx
WithFoo.displayName = `withFoo(${wrappedComponentName})`;
```

### Props
- Use `camelCase` for prop names
- Use `PascalCase` if prop value is a React component
- Don't reuse DOM prop names (`style`, `className`) for different purposes

---

## JSX Syntax

### Quotes
- **Attributes**: Double quotes `"bar"`
- **JS expressions**: Single quotes `'20px'`

```jsx
<Foo bar="bar" style={{ left: '20px' }} />
```

### Spacing
- **Self-closing tags**: One space before slash `<Foo />`
- **Curly braces**: No padding `{bar}`

### Alignment

```jsx
// Multiline props
<Foo
  superLongParam="bar"
  anotherSuperLongParam="baz"
>
  <Quux />
</Foo>

// Conditional rendering
{showButton && (
  <Button />
)}
```

---

## Props Best Practices

### Boolean Props
Omit value when `true`:

```jsx
<Foo hidden />  // good
<Foo hidden={true} />  // bad
```

### Default Props
Always define for non-required props:

```jsx
SFC.defaultProps = {
  bar: '',
  children: null,
};
```

### Keys
Use stable IDs, never array indexes:

```jsx
// Bad
{todos.map((todo, index) => <Todo key={index} />)}

// Good
{todos.map(todo => <Todo key={todo.id} />)}
```

### Spread Props
Use sparingly. Filter out unnecessary props:

```jsx
const { irrelevantProp, ...relevantProps } = this.props;
<WrappedComponent {...relevantProps} />
```

---

## Methods & Events

### Event Handler Binding
Bind in constructor, not render:

```jsx
// Good
constructor(props) {
  super(props);
  this.onClickDiv = this.onClickDiv.bind(this);
}

// Bad - creates new function every render
onClick={this.onClickDiv.bind(this)}

// Very bad - arrow function in class field
onClickDiv = () => { ... }
```

### Arrow Functions for Context
OK for passing additional data to handlers:

```jsx
<Item
  onClick={(event) => { doSomethingWith(event, item.name, index); }}
/>
```

### No Underscore Prefix
Don't use `_` for "private" methods — everything is public in JS.

---

## Component Ordering

For `class extends React.Component`:

1. Optional static methods
2. `constructor`
3. Lifecycle methods (`componentDidMount`, etc.)
4. Event handlers starting with `handle` (e.g., `handleSubmit`)
5. Event handlers starting with `on` (e.g., `onClickSubmit`)
6. Getter methods for render (e.g., `getSelectReason`)
7. Optional render methods (e.g., `renderNavigation`)
8. `render`

```jsx
class Link extends React.Component {
  static methodsAreOk() { return true; }

  constructor(props) { ... }

  componentDidMount() { ... }

  handleSubmit() { ... }
  onClickSubmit() { ... }

  getFooterContent() { ... }
  renderNavigation() { ... }

  render() { ... }
}

Link.propTypes = propTypes;
Link.defaultProps = defaultProps;
```

---

## Refs

Always use callback refs:

```jsx
// Good
<Foo ref={(ref) => { this.myRef = ref; }} />

// Bad
<Foo ref="myRef" />
```

---

## Accessibility

### Images
Always include `alt` prop:

```jsx
<img src="hello.jpg" alt="Me waving hello" />

// Presentational images
<img src="icon.svg" alt="" role="presentation" />
```

Don't use redundant words like "picture of" in `alt` text.

### ARIA
- Use only valid, non-abstract roles
- Don't use `accessKey`

```jsx
// Bad
<div role="datepicker" />  // Not a valid ARIA role
<div role="range" />  // Abstract role

// Good
<div role="button" />
```

---

## Anti-Patterns

- ❌ `isMounted()` — deprecated, use cancellation instead
- ❌ Array indexes as keys
- ❌ Mixins
- ❌ `React.createClass` — use ES6 classes
- ❌ Arrow function class properties for handlers
- ❌ String refs

---

## Quick Checklist

- [ ] One component per file (or multiple stateless)
- [ ] `.jsx` extension, PascalCase filename
- [ ] Stateful → `class extends Component`, Stateless → `function`
- [ ] Double quotes for JSX props, single for JS
- [ ] Boolean props without `=true`
- [ ] Stable IDs for keys (no indexes)
- [ ] Bind handlers in constructor
- [ ] Include `alt` on images
- [ ] Define `defaultProps` for optional props
- [ ] No `isMounted()` usage
