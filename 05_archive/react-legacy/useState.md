---
description: useState is a React hook that manages component state with functional updates and callback access to previous values, enabling dynamic data flow in functional components.
---

# useState Hook

## Basic Usage

## Patterns


# useState Hook



![[What is the difference between "useState" and "useEffect" hook functions?]]

## Overview


``` jsx
import React from "react"
export default function App() {
const [count, setCount] = React.useState(0)
/**
* Note: if you ever need the old value of state
* to help you determine the new value of state,
* you should pass a callback function to your
* state setter function instead of using
* state directly. This callback function will
* receive the old value of state as its parameter,
* which you can then use to determine your new
* value of state.
*/

function add() {
	setCount(prevCount=> prevCount + 1)
}

function subtract() {
	setCount(count - 1)
}

return (
	<main className="container">
		<h1>How many times will Bob say "state" in this section?</h1>
		<div className="counter">
			<button className="minus" onClick={subtract} aria-label="Decrease count">–</button>
		
		<h2 className="count">{count}</h2>	
		<button className="plus" onClick={add} aria-label="Increase count">+</button>
		</div>
	</main>
)
}
```