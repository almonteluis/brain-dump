---
description: shouldComponentUpdate is a lifecycle method for performance optimization that returns boolean to prevent re-renders, while getDerivedStateFromProps is a static method for updating state based on props.
tags: ["class-components", "interview", "lifecycle-methods", "optimization", "react"]
---

# shouldComponentUpdate and getDerivedStateFromProps

## Overview

#react #lifecycle-methods #optimization #class-components #interview

> shouldComponentUpdate is a lifecycle method that controls whether a component should re-render, returning true or false based on prop/state changes. getDerivedStateFromProps updates state based on prop changes before rendering, making it useful for state that depends on props.

#### Code Example:
```javascript
class OptimizedComponent extends React.Component {
  // Update state based on prop changes
  static getDerivedStateFromProps(nextProps, prevState) {
    if (nextProps.value !== prevState.value) {
      return {
        value: nextProps.value,
        computed: nextProps.value * 2
      };
    }
    return null; // No state update needed
  }

  // Control re-rendering
  shouldComponentUpdate(nextProps, nextState) {
    // Only re-render if id or status changes
    return (
      nextProps.id !== this.props.id ||
      nextProps.status !== this.props.status
    );
  }

  state = {
    value: this.props.value,
    computed: this.props.value * 2
  };

  render() {
    const { value, computed } = this.state;
    return (
      <div>
        <p>Value: {value}</p>
        <p>Computed: {computed}</p>
      </div>
    );
  }
}
```

#### Key Points:
* shouldComponentUpdate prevents unnecessary renders
* getDerivedStateFromProps runs before every render
* getDerivedStateFromProps must be static and pure
* Consider [[React.memo]] for functional components​​​​​​​​​​​​​​​​