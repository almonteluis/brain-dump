---
description: Update React component state using the setState function for classes or useState setter for hooks, with functional updates for state derived from previous state.
tags: ["UseState", "batch-updates", "functional-updates", "hooks", "immutability", "interview", "react", "setState", "state"]
---

# Updating Component States

## Overview

#react #state #hooks #setState #interview #UseState 

> State updates in React can be performed using the setState function from useState hook, with the key understanding that state updates may be asynchronous and state is immutable.

```javascript
// Basic state update
const [count, setCount] = useState(0);
setCount(count + 1);

// Using previous state
const [count, setCount] = useState(0);
setCount(prevCount => prevCount + 1);

// Object state update
const [user, setUser] = useState({ name: '', age: 0 });
setUser(prevUser => ({
  ...prevUser,
  name: 'John'
}));

// Array state update
const [items, setItems] = useState([]);
setItems(prevItems => [...prevItems, newItem]);
```

#### Key Points:
* Always use setState function, never modify state directly
* Use functional updates when new state depends on previous state
* State updates are batched for performance
* State is replaced, not merged (unlike class components)

#### Additional Tags:
#immutability #functional-updates #batch-updates​​​​​​​​​​​​​​​​