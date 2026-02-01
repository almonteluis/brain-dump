---
description: Notes about Can you explain the concept of virtual DOM in React?.
tags: #react #virtual-dom #frontend #performance #concepts
---

# Virtual DOM

## Overview


Virtual DOM is a lightweight copy of the real DOM. 

It’s a JS object that contains all the elements and their properties but it can’t change what’s on the screen. 

When a change in the state occurs in your application. a new copy virtual DOM with the new state change is created. Then it gets compared to the previous copy in a process called diffin and only the difference aka new changes get applied to the real DOM. 

[[What is the virtual DOM, and how does it work?]]