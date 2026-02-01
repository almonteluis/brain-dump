---
description: Implementing Atomic Design in React - atoms, molecules, organisms, templates, and pages methodology.
tags: ["react"]
---

The Atomic Design methodology breaks down design into five distinct levels:

1. **[[Atoms]]**: These are the basic building blocks of your application, like a button, an input field, or a form label. In React, these would be represented as individual components. They serve as foundational elements that are not exactly useful on their own but are fundamental for building more complex components.
3. **[[Molecules]]**: [[Molecules]] are groups of [[Atoms]] that are combined together to form a functional unit. For example, a form might be a molecule that includes [[Atoms]] like labels, input fields, and a submit button.
4. **[[Organisms]]**: [[Organisms]] are relatively complex UI components composed of groups of [[Molecules]] and/or [[Atoms]]. These are larger sections of an interface like a header, footer, or navigation bar and therefore can have their own state and functionality.
5. **[[Templates]]**: [[Templates]] are page-level objects that place components into a layout and articulate the design’s underlying content structure. They usually consist of groups of [[Organisms]], representing a complete layout.
6. **[[Pages]]**: [[Pages]] are specific instances of [[Templates]] that show what a UI looks like with real representative content in place. These [[Pages]] serve as ecosystems that display different template renders. Multiple ecosystems come together to form the entire application.

![[Pasted image 20250111011836.png]]

## React Implementation

# Implementing Atomic Design in React

To implement Atomic Design in a React application, we can consider the following key points:

- **Component Categorization**: Organize the components into [[Atoms]], [[Molecules]], [[Organisms]], [[Templates]], and [[Pages]]. This categorization should be reflected in our project’s file structure.
- **State Management**: We also need to decide how state will be managed across different levels of components. [[Atoms]] and [[Molecules]] might not hold state, while [[Organisms]] and [[Templates]] might need to.
- **Documentation**: It’s uber important to have thorough documentation of each component and its usage. This can be facilitated by tools like Storybook, as this will allow us to create a living style guide.

Let’s see a very simple example of how a React application built on atomic design principle would structurally look like.
  
``` tsx
import React from 'react';  
  
const noop = () => {};  
  
// Atoms
const Button = ({ onClick, children, type }) => <button type={type} onClick={onClick}>{children}</button>;  
const Label = ({ htmlFor, children }) => <label htmlFor={htmlFor}>{children}</label>;  
const Input = ({ id, type, onChange, value = "" }) => <input id={id} type={type} onChange={onChange} value={value} />;  
const Search = ({ onChange }) => <input type="search" onChange={onChange} />;  
const NavMenu = ({ items }) => <ul>{items.map((item) => <li>{item}</li>)}</ul>;  
  
// Molecules  
const Form = ({ onSubmit }) => (  
  <form onSubmit={onSubmit}>  
    <Label htmlFor="email">Email:</Label>  
    <Input id="email" type="email" onChange={noop} />  
    <Button type="submit" onClick={noop}>Submit</Button>  
  </form>  
);  
  
// Organisms  
const Header = () => (  
  <header>  
    <Search onChange={noop} />  
    <NavMenu items={[]} />  
  </header>  
);  
  
## Code Example

const Content = ({ children }) => (  
  <main>  
    {children}  
    <Form onSubmit={noop} />  
  </main>  
);  
  
## Additional Notes

// Templates  
const MainTemplate = ({ children }) => (  
  <>  
    <Header />  
    <Content>{children}</Content>  
  </>  
);

// Pages
const HomePage = () => (  
  <MainTemplate>
    <h2>My Form</h2>
    <p>This is a basic example demonstrating Atomic Design in React.</p> 
  </MainTemplate>
);
```

![[Pasted image 20250112104837.png]]
********
#react 