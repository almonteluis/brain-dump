---
description: Notes about What is a prop, and how can you change them?.
---

> a "prop" stands for "property" and refers to a piece of data passed from a parent component to a child component, essentially acting as a way to customize the child component's behavior based on the information provided; you cannot directly change a prop within a component as they are considered read-only; if you need to modify the data, you must update the state within the parent component which will then re-render the child with updated props.
> 
## Key points about props:
- Read-only: Once a prop is passed to a component, it cannot be directly modified within that component. 
- Data transfer: Props are used to transfer data from a parent component to its child component, creating a unidirectional flow of information.

## How to "change" a prop:
- Update parent component state: If you need to change the value of a prop, you must update the state in the parent component which will trigger a re-render of the child component with the new prop value.
- Pass updated data: When updating the parent component's state, make sure to pass the new data as the prop value to the child component. 

## resources 
[1] [https://veeevek.medium.com/change-props-from-child-component-reactjs-d04c89e98647](https://veeevek.medium.com/change-props-from-child-component-reactjs-d04c89e98647)
[2] [https://builtin.com/articles/react-props](https://builtin.com/articles/react-props#:~:text=Props%20is%20a%20special%20keyword%20in%20React,a%20unidirectional%20flow%20from%20parent%20to%20child.)
[3] [https://react.dev/learn/passing-props-to-a-component](https://react.dev/learn/passing-props-to-a-component#:~:text=Props%20are%20read%2Donly%20snapshots%20in%20time:%20every,need%20interactivity%2C%20you'll%20need%20to%20set%20state.)
[4] [https://www.geeksforgeeks.org/reactjs-state-vs-props/](https://www.geeksforgeeks.org/reactjs-state-vs-props/#:~:text=Props%20are%20read%2Donly.%20The%20state%20is%20both,manage%20the%20data%20inside%20a%20component%20itself.)