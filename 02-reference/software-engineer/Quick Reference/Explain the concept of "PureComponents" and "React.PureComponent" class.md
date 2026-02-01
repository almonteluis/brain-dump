---
description: React PureComponent implements shallow prop/state comparison automatically to prevent unnecessary re-renders as a performance optimization for class components.
tags: ["interview", "optimization", "performance", "pure-components", "react"]
---

# React.PureComponent

## Overview

#react #pure-components #optimization #performance #interview

> PureComponents are a special type of component that implements shouldComponentUpdate with a shallow prop and state comparison automatically. They help optimize performance by preventing unnecessary re-renders when props or state haven't changed at a shallow level.

#### Code Example:
```javascript
// Regular Component (re-renders every time)
class RegularComponent extends React.Component {
  render() {
    console.log('Regular Component Render');
    return <div>{this.props.value}</div>;
  }
}

// Pure Component (only re-renders if props/state change)
class OptimizedComponent extends React.PureComponent {
  render() {
    console.log('Pure Component Render');
    return <div>{this.props.value}</div>;
  }
}

// Usage example showing difference
class ParentComponent extends React.Component {
  state = {
    value: 1,
    obj: { data: 'test' }
  };

  render() {
    return (
      <div>
        {/* Will re-render on every parent update */}
        <RegularComponent value={this.state.value} />
        
        {/* Will only re-render if value changes */}
        <OptimizedComponent value={this.state.value} />
        
        {/* Warning: Will not detect nested object changes */}
        <OptimizedComponent obj={this.state.obj} />
      </div>
    );
  }
}
```

#### Key Points:
* Only updates if props/state change (shallow comparison)
* Best for simple props (numbers, strings, booleans)
* Be careful with nested objects and arrays
* React.memo is the functional component equivalent
* Don't overuse as comparison itself has a cost​​​​​​​​​​​​​​​​