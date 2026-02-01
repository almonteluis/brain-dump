---
description: React portals provide a way to render children outside the parent component's DOM hierarchy, useful for modals, tooltips, and dropdowns that need to escape container overflow.
tags: ["component-hierarchy", "createPortal", "dom", "interview", "modal", "portals", "react"]
---

# React Portals

## Overview

#react #portals #dom #modal #interview

> React Portals allow rendering child elements outside their parent DOM hierarchy while maintaining the React component hierarchy. They're commonly used for modals, tooltips, or floating elements that need to break out of container boundaries.

```jsx
// Basic Portal Example
function Modal({ children }) {
  return ReactDOM.createPortal(
    <div className="modal">
      {children}
    </div>,
    document.getElementById('modal-root')
  );
}

// Usage
function App() {
  return (
    <div className="app">
      <Modal>
        <h1>I'm rendered outside my parent DOM tree</h1>
      </Modal>
    </div>
  );
}
```

#### Key Points:
* Perfect for modals, popups, and tooltips
* Maintains event bubbling through React tree
* Useful for escaping CSS overflow: hidden or z-index contexts
* Component hierarchy and context remain intact

#### Additional Tags:
 #createPortal #component-hierarchy​​​​​​​​​​​​​​​​