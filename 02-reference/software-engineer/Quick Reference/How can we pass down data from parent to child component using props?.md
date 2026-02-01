---
description: Data flows from parent to child components via props, with children receiving data as attributes and parents controlling the state passed down.
tags: ["components", "data-flow", "interview", "props", "react"]
---

# Passing Data via Props

## Overview

#react #props #components #data-flow #interview

> Props (short for properties) are React's way of passing data from parent to child components. They are read-only and help maintain unidirectional data flow, making your application's data flow more predictable and easier to debug.

```javascript
// Parent Component
function ParentComponent() {
  const [user, setUser] = useState({
    name: 'John',
    age: 25
  });

  return (
    <ChildComponent 
      name={user.name}
      age={user.age}
      updateUser={setUser}
    />
  );
}

// Child Component
function ChildComponent({ name, age, updateUser }) {
  return (
    <div>
      <h1>Name: {name}</h1>
      <p>Age: {age}</p>
      <button onClick={() => updateUser(prevUser => ({
        ...prevUser,
        age: prevUser.age + 1
      }))}>
        Increment Age
      </button>
    </div>
  );
}
```

#### Key Points:
* Props are read-only in child components
* Can pass any JavaScript value as props
* Functions can be passed to allow child-to-parent communication
* Use destructuring for cleaner prop access​​​​​​​​​​​​​​​​

#### Reference
- [[What is a prop, and how can you change them?]]
