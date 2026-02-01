---
description: React uses synthetic events for cross-browser compatibility, controlled components for form handling, and refs for uncontrolled components.
tags: #react #events #forms #controlled-components #uncontrolled-components
date: 2026-01-31
---

# React Event Handling

React wraps native browser events in **Synthetic Events** for cross-browser compatibility.

## Event Naming Convention

| HTML Event | React Event |
|------------|-------------|
| onclick | onClick |
| onsubmit | onSubmit |
| onchange | onChange |

## Controlled Components

Form data controlled by React state:

```javascript
function ControlledForm() {
  const [value, setValue] = useState('');
  return <input value={value} onChange={e => setValue(e.target.value)} />;
}
```

## Uncontrolled Components

Form data managed by DOM:

```javascript
function UncontrolledForm() {
  const inputRef = useRef(null);
  return <input ref={inputRef} defaultValue="initial" />;
}
```

## Related Notes

- [[react-core-concepts.md]] - React fundamentals and state
- [[component-lifecycle.md]] - Component lifecycle and useEffect
