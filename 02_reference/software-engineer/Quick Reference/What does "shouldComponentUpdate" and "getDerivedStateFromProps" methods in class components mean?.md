---
description: shouldComponentUpdate is a lifecycle method for performance optimization that returns boolean to prevent re-renders, while getDerivedStateFromProps is a static method for updating state based on prop changes.
tags: ["class-components", "interview", "lifecycle-methods", "optimization", "react"]
---

# shouldComponentUpdate and getDerivedStateFromProps

## Overview

#react #lifecycle-methods #class-components #optimization #interview

> [[shouldComponentUpdate]] and getDerivedStateFromProps are lifecycle methods in class components. [[shouldComponentUpdate]] lets you control if a component should re-render based on prop/state changes for performance optimization. [[getDerivedStateFromProps]] is a static method that lets you update state based on prop changes before rendering.

```javascript
class ExampleComponent extends React.Component {
  static getDerivedStateFromProps(props, state) {
    // Return new state or null
    if (props.value !== state.value) {
      return { value: props.value };
    }
    return null;
  }

  shouldComponentUpdate(nextProps, nextState) {
    // Return true or false to control re-rendering
    return this.props.value !== nextProps.value;
  }

  state = {
    value: this.props.value
  };

  render() {
    return <div>{this.state.value}</div>;
  }
}
```

#### Key Points:
* [[shouldComponentUpdate]] returns boolean to optimize rendering
* [[getDerivedStateFromProps]] is static and returns new state object
* Both methods run before rendering
* Rarely needed in modern React (use [[Hooks]] instead)​​​​​​​​​​​​​​​​