---
description: React lifecycle method getDerivedStateFromProps - deriving state from props in React components.
tags: ["interview", "lifecycle-methods", "props", "react", "state"]
---

# getDerivedStateFromProps

## Overview

## Usage

#react #lifecycle-methods #state #props #interview

> getDerivedStateFromProps is a static lifecycle method that runs when a component mounts and before every render. It allows you to update the internal state of a component based on changes in props. Unlike other lifecycle methods, it is static and should be pure, with no side effects.

```javascript
class ExampleComponent extends React.Component {
  static getDerivedStateFromProps(nextProps, prevState) {
    // Compare props and return updated state
    if (nextProps.count !== prevState.count) {
      return {
        count: nextProps.count,
        computed: nextProps.count * 2
      };
    }
    // Return null if no state update is needed
    return null;
  }

  state = {
    count: this.props.count,
    computed: this.props.count * 2
  };

  render() {
    return (
      <div>
        <p>Count: {this.state.count}</p>
        <p>Computed: {this.state.computed}</p>
      </div>
    );
  }
}
```

#### Key Points:
* Must be static and return new state or null
* Runs before every render
* Cannot access component instance (this)
* Consider using useEffect in functional components instead​​​​​​​​​​​​​​​​