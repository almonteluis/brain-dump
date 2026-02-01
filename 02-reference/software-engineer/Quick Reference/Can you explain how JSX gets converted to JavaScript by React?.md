---
description: JSX is a syntax extension that Babel transpiles into React.createElement() calls, creating plain JavaScript objects that describe the UI.
tags: ["babel", "compilation", "createElement", "flashcards/react/jsx", "interview", "jsx", "react", "react-elements", "transpilation"]
---

# JSX to JavaScript Conversion

## Overview

#react #jsx #babel #transpilation #interview

> JSX is a syntax extension for JavaScript that gets transformed into regular JavaScript objects through a process called transpilation. Babel converts JSX into React.createElement() calls.

```javascript
// JSX
const element = (
  <div className="container">
    <h1>Hello, {name}</h1>
  </div>
);

// Transpiled JavaScript
const element = React.createElement(
  'div',
  { className: 'container' },
  React.createElement('h1', null, 'Hello, ', name)
);
```

#### Key Points:
#flashcards/react/jsx

? What is JSX and how does it get transformed?
?? JSX is a syntax extension for JavaScript that gets transformed into regular JavaScript objects through transpilation. Babel converts JSX into React.createElement() calls.

Example Transformation:
```javascript
// JSX
const element = (
  <div className="container">
    <h1>Hello, {name}</h1>
  </div>
);

// Becomes
const element = React.createElement(
  'div',
  { className: 'container' },
  React.createElement('h1', null, 'Hello, ', name)
);
```

? What are the key aspects of JSX transpilation?
?? - ==Babel== handles the ==JSX transformation== during build process
   - Each ==JSX element== becomes a ==React.createElement()== call
   - React.createElement() creates ==plain JavaScript objects== (React elements)
   - These objects ==describe the UI== you want to render
<!--SR:!2025-01-20,3,250!2025-01-18,1,230!2025-01-18,1,230!2025-01-18,1,230!2025-01-18,1,230!2025-01-18,1,230-->

? How does JSX handle expressions and attributes?
?? JSX can include JavaScript expressions and converts HTML attributes:

1. Expressions: ==Use curly braces {}==^[expression container]
2. Attributes: ==className instead of class==^[HTML attribute conversion]
3. Children: ==Can be nested like HTML==^[element nesting]
<!--SR:!2025-01-18,1,230!2025-01-18,1,230!2025-01-18,1,230-->

Example:
```javascript
const greeting = <h1>Hello, {user.name}!</h1>;
const button = <button className="btn" onClick={handleClick}>;
```

? What is the relationship between JSX and React.createElement()?
?? JSX is syntactic sugar for ==React.createElement()==^[transformation target].
<!--SR:!2025-01-18,1,230-->

The function takes three arguments:
1. ==Element type==^[tag name or component]
2. ==Properties object==^[props and attributes]
3. ==Children==^[nested content]
<!--SR:!2025-01-18,1,230!2025-01-18,1,230!2025-03-25,1,210-->

![[What is JSX, and how does it work with JavaScript?]]

#### Additional Tags:
#compilation #react-elements #babel  #createElement​​​​​​​​​​​​​​​​
