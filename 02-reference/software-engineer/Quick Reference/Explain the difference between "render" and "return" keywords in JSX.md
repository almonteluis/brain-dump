---
description: In JSX, return is a JavaScript statement that exits a function with a value, while render is a method name in class components that returns React elements to be displayed.
tags: ["components", "interview", "jsx", "react", "render"]
---

# render vs return in JSX

## Overview

#react #jsx #render #components #interview

> In React, "render" is a lifecycle method in class components that determines what should be displayed, while "return" is used in both class and functional components to specify the actual JSX that will be rendered. Render contains the component's logic before returning JSX, while return simply provides the JSX template.

#### Code Example:
```javascript
// Class Component using render
class ClassComponent extends React.Component {
  render() {
    // Logic can go here
    const name = this.props.name.toUpperCase();
    
    // JSX must be returned
    return (
      <div>
        <h1>Hello, {name}</h1>
      </div>
    );
  }
}

// Functional Component using return
function FunctionalComponent({ name }) {
  // Logic before return
  const formattedName = name.toUpperCase();
  
  // Only return statement, no render needed
  return (
    <div>
      <h1>Hello, {formattedName}</h1>
    </div>
  );
}
```

#### Key Points:
* render is only used in class components
* return is used in both class and functional components
* render can contain logic before returning JSX
* Both must return a single parent element or fragment
* return marks the end of the component's rendering logic​​​​​​​​​​​​​​​​