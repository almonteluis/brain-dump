---
description: React handles nested components through composition where parent components contain child components, passing data down via props and receiving events back through callback functions.
tags: ["components", "composition", "interview", "nesting", "react"]
---

# Nested Components

## Overview

#react #components #composition #nesting #interview

> React components can be nested inside other components, creating a parent-child relationship known as component composition. This allows for building complex UIs from simple, reusable components while maintaining a clear hierarchy and enabling props to flow down through the component tree.

```javascript
function ParentComponent() {
  const [data, setData] = useState('parent data');

  return (
    <div className="parent">
      <h1>Parent</h1>
      <ChildComponent data={data}>
        <GrandchildComponent />
        <GrandchildComponent />
      </ChildComponent>
    </div>
  );
}

function ChildComponent({ data, children }) {
  return (
    <div className="child">
      <p>Child received: {data}</p>
      {children} {/* Renders grandchild components */}
    </div>
  );
}

function GrandchildComponent() {
  return <div className="grandchild">Grandchild</div>;
}
```

#### Key Points:
* Children props allow component nesting
* Props flow down through component hierarchy
* Each component can be developed and tested independently
* Use composition over inheritance for component reuse​​​​​​​​​​​​​​​​