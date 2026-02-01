---
description: Legacy getInitialState and getDefaultProps are replaced by class fields, while getDerivedStateFromProps is a static method for updating state based on props.
tags: ["interview", "lifecycle-methods", "props", "react", "state"]
---

# React Lifecycle Methods Comparison

## Overview

#react #lifecycle-methods #state #props #interview

> "getInitialState" and "getDefaultProps" are legacy methods used in older React class components, while "getDerivedStateFromProps" is a newer static lifecycle method. getInitialState set initial state, getDefaultProps defined default props, and getDerivedStateFromProps updates state based on prop changes before render.

#### Code Example:
```javascript
// Legacy methods (React < 16.3)
class OldComponent extends React.Component {
  getInitialState() {
    return {
      count: 0
    };
  }

  static getDefaultProps() {
    return {
      initialCount: 0
    };
  }
}

// Modern approach
class ModernComponent extends React.Component {
  // Replace getInitialState
  state = {
    count: 0
  };

  // Replace getDefaultProps
  static defaultProps = {
    initialCount: 0
  };

  // Modern lifecycle method
  static getDerivedStateFromProps(props, state) {
    if (props.count !== state.prevCount) {
      return {
        count: props.count,
        prevCount: props.count
      };
    }
    return null;
  }

  render() {
    return <div>{this.state.count}</div>;
  }
}
```

#### Key Points:
* getInitialState and getDefaultProps are deprecated
* Use class fields for initial state and default props
* getDerivedStateFromProps is static and returns new state or null
* Consider using hooks in functional components instead​​​​​​​​​​​​​​​​