---
description: CSS Modules provide locally scoped CSS classes in React, preventing naming conflicts and enabling modular styling with automatic class name generation at build time.
tags: ["css-modules", "interview", "react", "scoping", "styling"]
---

# CSS Modules in React

## Benefits

#react #css-modules #styling #scoping #interview

> CSS Modules are CSS files that are locally scoped by default, ensuring class names are unique through automatic namespacing. This solves the problem of naming conflicts and global scope issues in CSS, making styles truly modular and maintainable in React applications.

#### Code example:
```javascript
// styles.module.css
.button {
  background: blue;
  padding: 10px;
}

// Component.js
import styles from './styles.module.css';

function Button() {
  return (
    <button className={styles.button}>
      Click me
    </button>
  );
  
  // Compiles to something like:
  // <button class="Button_button_1kx2d">
}

// Multiple classes
function Card() {
  return (
    <div className={`${styles.card} ${styles.dark}`}>
      Content
    </div>
  );
}
```

#### Key Points:
* Local scope prevents naming conflicts
* Enables better organization of component-specific styles
* Automatically generates unique class names
* Works well with standard CSS features and preprocessors​​​​​​​​​​​​​​​​