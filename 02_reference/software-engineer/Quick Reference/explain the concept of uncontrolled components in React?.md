---
description: Uncontrolled components maintain their own internal DOM state accessed via refs, using defaultValue instead of the value prop for simpler form handling.
tags: ["DOM", "defaultValue", "forms", "interview", "react", "refs", "uncontrolled-components"]
---

# Uncontrolled Components in React

## Overview

#react #forms #uncontrolled-components #refs #interview

> Uncontrolled components are form elements that maintain their own internal state in the DOM rather than being controlled by React state. They use refs to access form values directly.

```javascript
function UncontrolledForm() {
  const inputRef = useRef(null);

  const handleSubmit = (e) => {
    e.preventDefault();
    // Access value directly from DOM
    console.log(inputRef.current.value);
  };

  return (
    <form onSubmit={handleSubmit}>
      <input 
        type="text"
        ref={inputRef}
        defaultValue="default value"
      />
      <button type="submit">Submit</button>
    </form>
  );
}
```

#### Key Points:
* Values accessed via refs instead of state
* Use defaultValue instead of value prop
* Simpler but less control over form data
* Useful for integrating with non-React code

#### Reference
- [[What is the difference between controlled and uncontrolled components?]]
- [[Can you explain the difference between functional components and class components in React?]]

#### Additional Tags:
#forms #refs #DOM #defaultValue​​​​​​​​​​​​​​​​