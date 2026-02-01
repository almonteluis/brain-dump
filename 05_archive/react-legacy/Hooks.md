---
description: React hooks reference guide covering useState, useEffect, useContext, useReducer, useCallback, useMemo, useRef, and custom hook patterns for functional component development.
tags: ["flashcards", "hooks", "react"]
---

# React Hooks Reference



#flashcards #react #hooks

## Core Hooks


? What are React Hooks? (Basic Definition)
?? React hooks are functions that let you hook into React state and lifecycle features from function components.

? Name and describe the main React Hooks
?? Core Hooks:
1. useState: Adds state to functional components
2. useEffect: Handles side effects ([[Data fetching]], DOM updates)
3. useContext: Accesses context in function components
4. useReducer: Manages complex state logic

? What is useState and show a basic implementation
?? useState allows adding state to functional components.

Example:
```javascript
function Counter() {
  const [count, setCount] = useState(0);
  const [user, setUser] = useState({ name: '', email: '' });

  const increment = () => {
    setCount(prevCount => prevCount + 1);
    setUser(prevUser => ({
      ...prevUser,
      lastActive: Date.now()
    }));
  };
}
```

? Show a complete [[useEffect]] implementation with cleanup
?? 
```javascript
function UserProfile({ userId }) {
  const [data, setData] = useState(null);

  useEffect(() => {
    const fetchUser = async () => {
      const response = await fetch(`/api/users/${userId}`);
      const user = await response.json();
      setData(user);
    };

    fetchUser();

    return () => {
      // Cleanup function
    };
  }, [userId]); 
}
```

? How do you implement a custom hook for form handling?
??
```javascript
function useForm(initialValues) {
  const [values, setValues] = useState(initialValues);
  
  const handleChange = (e) => {
    const { name, value } = e.target;
    setValues(prev => ({
      ...prev,
      [name]: value
    }));
  };

## Custom Hooks

  const handleSubmit = (onSubmit) => (e) => {
    e.preventDefault();
    onSubmit(values);
  };

  return { values, handleChange, handleSubmit };
}
```

? What is useReducer and when should you use it?
?? useReducer is used for complex state management.

Example:
```javascript
const [state, dispatch] = useReducer(reducer, initialState);

function reducer(state, action) {
  switch (action.type) {
    case 'increment':
      return { count: state.count + 1 };
    case 'decrement':
      return { count: state.count - 1 };
    default:
      throw new Error();
  }
}
```
? How do you use [[useRef]] and what is its purpose?
?? [[useRef]] provides a way to access DOM nodes or persist values across renders.

Example:
```javascript
function TextInputWithFocus() {
  const inputRef = useRef(null);

  const focusInput = () => {
    inputRef.current.focus();
  };

  return (
    <>
      <input ref={inputRef} type="text" />
      <button onClick={focusInput}>Focus Input</button>
    </>
  );
}
```

? What are the categories of Hooks and their purposes?
?? State Hooks:
- useState: Basic state management
- useReducer: Complex state logic

Effect Hooks:
- useEffect: Side effects, async operations
- useLayoutEffect: Synchronous DOM mutations

Context Hooks:
- useContext: Access React context

Performance Hooks:
- [[useMemo]]: Memoize expensive calculations
- useCallback: Memoize functions

? Show how to implement useContext with a theme example
??
```javascript
// Creating context
const ThemeContext = React.createContext('light');

// Using context
function ThemedButton() {
  const theme = useContext(ThemeContext);
  return <button className={theme}>Themed Button</button>;
}
```

What are Performance Hooks and show their implementation
?? Performance Hooks optimize expensive operations.

[[useMemo]] Example:
```javascript
const memoizedValue = useMemo(() => 
  computeExpensiveValue(a, b), [a, b]);
```

## Additional Notes

useCallback Example:
```javascript
const memoizedCallback = useCallback(
  () => doSomething(a, b), [a, b]);
```

? How do you handle form state with a custom hook?
??
```javascript
// Custom form hook
function useForm(initialValues) {
  const [values, setValues] = useState(initialValues);
  const [errors, setErrors] = useState({});

  const handleChange = (e) => {
    const { name, value } = e.target;
    setValues(prev => ({
      ...prev,
      [name]: value
    }));
  };

  // Usage example
  return {
    values,
    errors,
    handleChange,
    handleSubmit: (onSubmit) => (e) => {
      e.preventDefault();
      onSubmit(values);
    }
  };
}

// Implementation
function SignupForm() {
  const { values, handleChange, handleSubmit } = useForm({
    email: '',
    password: ''
  });

  const onSubmit = (data) => {
    console.log('Form submitted:', data);
  };
}
```

