---
description: Notes about Can you explain the difference between functional components and class components in React?.
---

Types of Components: 
- Function Components: The simpler and more modern approach, function components are JavaScript functions that take props as input and return JSX elements. 
	- Think of the input output in week 0 CS50. Props are input and the JSX elements that’s return is output. Whatever in the middle is the algorithm so react is the algo in this case. 
- Class Components: The older style, class components are ES6 classes that extend from React.Component and have a render() method that returns JSX. (NOT RECOMMEND)

## Example (Function Component): 

|                                                                                                               |
| ------------------------------------------------------------------------------------------------------------- |
| ``` jsx<br>import React from 'react';function Greeting(props) {  return <h1>Hello, {props.name}!</h1>}<br>``` |
|                                                                                                               |

  

## Example (Class Component): 

|                                                                                                                                           |
| ----------------------------------------------------------------------------------------------------------------------------------------- |
| ```<br>import React from 'react';class Greeting extends React.Component {  render() { return <h1>Hello, {this.props.name}!</h1>;}}<br>``` |

