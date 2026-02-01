---
description: Notes about mental model for React.
tags: #react #mental-models #concepts #understanding #frontend
---

# Mental Model for React

## Overview



description: Notes and reference material about mental model for  React.
---

> It’s functions all the way down
> Let’s start by modeling the basic building blocks of JavaScript and React: functions.
> 
> - A React component is just a function
> - Components containing other components are functions calling other functions
> - Props are the function’s arguments
> 
> This is hidden away by JSX, the markup language React uses. Strip away JSX and React is a bunch of functions calling one another. JSX is in itself an applied mental model that makes using React simpler and more intuitive.
> 
> Let’s look at each part individually.

Pretty much saying it’s a function. Which makes senses because a function is used to encapsulate logic that can be reused. Prop is the function’s parameters to make it dynamic. 