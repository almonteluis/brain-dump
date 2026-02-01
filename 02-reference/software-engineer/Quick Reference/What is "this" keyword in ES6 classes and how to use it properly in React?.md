---
description: The this keyword in ES6 classes refers to the instance of the class, and in React it's important for event handlers where this must be bound correctly using arrow functions or bind.
tags: ["classes", "es6", "interview", "react", "this-keyword"]
---

# this Keyword in ES6 Classes

## Overview

#react #es6 #this-keyword #classes #interview

> The "this" keyword in ES6 classes refers to the instance of the class. In React components, "this" refers to the component instance but can lose its context in event handlers. Proper binding is necessary to maintain the correct context of "this" in class components.

#### Code Example:
```javascript
class ExampleComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = { count: 0 };
    
    // Method 1: Binding in constructor
    this.handleClick1 = this.handleClick1.bind(this);
  }

## Common Pitfalls

  // Method 2: Class field with arrow function (recommended)
  handleClick2 = () => {
    this.setState(prev => ({ count: prev.count + 1 }));
  };

  // Method 3: Regular method (needs binding)
  handleClick1() {
    this.setState(prev => ({ count: prev.count + 1 }));
  }

  render() {
    // Method 4: Arrow function in render (not recommended)
    const handleClick3 = () => {
      this.setState(prev => ({ count: prev.count + 1 }));
    };

    return (
      <div>
        <button onClick={this.handleClick1}>
          Bound in Constructor
        </button>
        
        <button onClick={this.handleClick2}>
          Class Field
        </button>
        
        <button onClick={() => this.handleClick1()}>
          Inline Arrow (avoid)
        </button>
      </div>
    );
  }
}
```

#### Key Points:
* Class fields with arrow functions are preferred
* Avoid binding in render method (creates new function each render)
* Constructor binding works but requires more boilerplate
* "this" is automatically handled in functional components
* Use hooks in modern React instead of classes​​​​​​​​​​​​​​​​