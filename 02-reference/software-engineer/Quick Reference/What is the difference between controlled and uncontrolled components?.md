---
description: Controlled components have form data controlled by React state with onChange handlers, while uncontrolled components maintain their own internal state accessed via refs.
tags: ["components", "forms", "interview", "react"]
---

# Controlled vs Uncontrolled Components

## Overview

#react #forms #components #interview

> Controlled components are form elements whose values are controlled by React state, while uncontrolled components store their own state internally in the DOM. Controlled components provide more control and validation capabilities but require more code, whereas uncontrolled components are simpler but offer less control.

```javascript
// Controlled Component
function ControlledInput() {
  const [value, setValue] = useState('');
  return (
    <input
      value={value}
      onChange={(e) => setValue(e.target.value)}
    />
  );
}

// Uncontrolled Component
function UncontrolledInput() {
  const inputRef = useRef(null);
  return (
    <input
      ref={inputRef}
      defaultValue="default value"
    />
  );
}
```

#### Key Points:
* Controlled components use state and onChange handlers
* Uncontrolled components use refs and defaultValue
* Controlled components are better for instant validation
* Controlled components provide more predictable form handling​​​​​​​​​​​​​​​​