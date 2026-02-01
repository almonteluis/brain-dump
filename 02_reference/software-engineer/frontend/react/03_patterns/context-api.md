---
description: Context API solves prop drilling by enabling cross-component data sharing without passing props through intermediate components.
tags: #react #patterns #context-api #state-management #prop-drilling
date: 2026-01-31
---

# Context API Solves Prop Drilling for Cross-Component Data

React Context provides a way to pass data through the component tree without manually threading props.

## Basic Pattern

```javascript
const MyContext = createContext(null);

function Provider({ children }) {
  const [value, setValue] = useState(null);
  return (
    <MyContext.Provider value={{ value, setValue }}>
      {children}
    </MyContext.Provider>
  );
}

function Consumer() {
  const { value } = useContext(MyContext);
  return <div>{value}</div>;
}
```

## When to Use Context

- Global state (theme, language, auth)
- Cross-component data
- Avoiding prop drilling

## Related Notes

- [[../05_architecture/state-management-patterns.md]] - State management approaches
