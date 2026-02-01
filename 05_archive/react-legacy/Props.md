---
description: Props in React are read-only inputs passed from parent components to child components, enabling component composition and data flow.
tags: ["flashcards/react/props"]
---

# React Props

#flashcards/react/props

? What is the purpose of props in React components?
?? Props make components ==reusable by allowing them to receive different data== while maintaining the same structure and functionality.
<!--SR:!2025-01-20,3,250-->

Example:
```jsx
// Reusable component
function Button(props) {
  return <button>{props.text}</button>
}

// Different uses
<Button text="Submit" />
<Button text="Cancel" />
```

## Prop Drilling

? How do you pass props to a component?
?? Props are passed as ==attributes== in the JSX:
```jsx
<MyComponent 
  title="Hello"     // String prop
  count={5}         // Number prop
  isActive={true}   // Boolean prop
  data={someObject} // Object prop
/>
```
<!--SR:!2025-01-20,3,250-->

? Can you pass custom props to native DOM elements?
?? No. Native DOM elements can only receive ==valid HTML attributes==.
<!--SR:!2025-01-18,1,230-->

Example:
```jsx
// ❌ Won't work
<div customProp={true} />

// ✅ Works - className is a valid HTML attribute
<div className="header" />
```
This is because React converts JSX to real DOM elements which only accept standard HTML attributes.

? How do you receive and use props in a component?
?? Props are received as a ==single parameter object== in the component function:
```jsx
// Basic props object
function Component(props) {
  return <div>{props.title}</div>
}

## Additional Notes

// Destructured props
function Component({ title, description }) {
  return (
    <div>
      <h1>{title}</h1>
      <p>{description}</p>
    </div>
  )
}
```
<!--SR:!2025-01-21,4,270-->

? What is the data type of props?
?? Props is always an ==object== that contains all the properties passed to the component.
```jsx
function Example(props) {
  console.log(typeof props) // "object"
  console.log(props) // { title: "Hello", count: 5 }
  return <div>{props.title}</div>
}
```
```

