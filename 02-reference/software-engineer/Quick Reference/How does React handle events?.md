---
description: Notes about How does React handle events?.
---

React Event Handling:
- event handlers are functions that you define within your components.
- they are attached to JSX elements using camelCase naming conventions.
- when an event occur

4. Basic Event Handling
```javascript
import React, { useState } from 'react';

function Button() {
  const [count, setCount] = useState(0);

  const handleClick = (event) => {
    event.preventDefault();
    setCount(count + 1);
  };

  return (
    <button onClick={handleClick}>
      Clicked {count} times
    </button>
  );
}
```

2. Passing Arguments to Event Handlers
```javascript
function ItemList() {
  const handleItemClick = (id, event) => {
    console.log('Item clicked:', id);
  };

  return (
    <ul>
      <li onClick={(e) => handleItemClick(1, e)}>Item 1</li>
      <li onClick={(e) => handleItemClick(2, e)}>Item 2</li>
    </ul>
  );
}
```

# Explanation

## Key Concepts

### Synthetic Events
* React wraps native browser events
* Cross-browser compatible
* Contains same interface as native events
* Pooled for performance

### Event Names
* Use camelCase instead of lowercase
* `onClick` instead of `onclick`
* `onSubmit` instead of `onsubmit`
* `onChange` instead of `onchange`

### Common Events
```javascript
// Mouse Events
onClick
onMouseDown
onMouseUp
onMouseMove

// Form Events
onChange
onSubmit
onFocus
onBlur

// Keyboard Events
onKeyDown
onKeyPress
onKeyUp
```

## Event Handling Patterns

### Method Binding
```javascript
class Component extends React.Component {
  // Automatically bound with class fields
  handleClick = (e) => {
    console.log('clicked');
  }

  // Needs binding in constructor
  handleHover(e) {
    console.log('hovered');
  }

  constructor(props) {
    super(props);
    this.handleHover = this.handleHover.bind(this);
  }
}
```

### Event Delegation
```javascript
function TodoList() {
  const handleClick = (e) => {
    if (e.target.matches('.todo-item')) {
      console.log('Todo clicked:', e.target.dataset.id);
    }
  };

  return (
    <ul onClick={handleClick}>
      <li className="todo-item" data-id="1">Todo 1</li>
      <li className="todo-item" data-id="2">Todo 2</li>
    </ul>
  );
}
```

![[Best Practices for handling events]]