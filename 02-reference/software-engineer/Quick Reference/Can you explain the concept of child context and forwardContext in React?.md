---
description: Context API passes data through component trees without prop drilling, while forwardRef allows components to forward refs to child DOM nodes.
tags: ["context", "forwardRef", "interview", "props", "react"]
---
	#react #context #forwardRef #props #interview

> [[Context]] provides a way to pass data through the component tree without manually passing props at every level. forwardRef allows components to forward their ref to a child component, enabling parent components to directly interact with a child component's DOM node or methods.

```tsx
// Create context
const ThemeContext = React.createContext('light');

// Context Provider
## Overview
function App() {
  return (
    <ThemeContext.Provider value="dark">
      <ParentComponent />
    </ThemeContext.Provider>
  );
}

// Using Context with forwardRef
const ChildComponent = forwardRef((props, ref) => {
  const theme = useContext(ThemeContext);
  
  return (
    <button 
## Example
      ref={ref}
      className={`btn-${theme}`}
    >
      {props.children}
    </button>
  );
});

// Parent using forwarded ref
function ParentComponent() {
  const buttonRef = useRef(null);
  
  useEffect(() => {
    // Access child's DOM node
    buttonRef.current.focus();
  }, []);

  return <ChildComponent ref={buttonRef}>Click me</ChildComponent>;
}
```

## Key Points:
* [[Context]] avoids prop drilling through intermediate components
* forwardRef enables ref passing to custom components
* ***==Useful for theme, auth, or other global data==***
* Can affect component reusability if overused​​​​​​​​​​​​​​​​