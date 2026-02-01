---
description: Practice challenges for React useRef hook - learning objectives and implementation exercises.
tags: ["current"]
---

# useRef Practice Challenges


I'll restructure the projects as challenges with clear instructions like in the image, focusing on the learning objectives and steps while letting you implement the actual [[useRef]] logic.


## Challenge 1: Basic Focus Management

1. Basic Focus Management Challenge:​​​​​​​​​​​​​​​​ #current 
``` jsx
/**
 * Challenge: Create a component that manages input focus
 * 
 * Requirements:
 * 1. Create a ref called 'inputRef' which defaults to null
 *    (Remember to import [[useRef]] from React!)
 * 
 * 2. Attach the ref to an input element using the ref attribute
 * 
 * 3. Create a function called handleFocus that:
 *    - Uses the ref's current property to call focus()
 *    - Don't forget to use optional chaining (?.) for safety!
 * 
 * 4. Add a button that calls handleFocus when clicked
 * 
 * Hint: The component structure is provided below, you just need
 *       to add the ref logic!
 */

const FocusInput = () => {
  // Add your ref here
  
  // Add your focus handler here

  return (
    <div className="p-4 space-y-4">
      <h2 className="text-xl font-bold">Basic Focus Management</h2>
      <div className="space-y-2">
        <input
          // Add your ref here
          type="text"
          className="border p-2 rounded"
          placeholder="Type here..."
        />
        <button
          // Add your click handler here
          className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600"
        >
          Focus Input
        </button>
      </div>
    </div>
  );
};

export default FocusInput;
```

1. Timer Challenge:​​​​​​​​​​​​​​​​ #current
``` jsx
/**
 * Challenge: Create a timer component using [[useRef]] to store the interval
 * 
 * Requirements:
 * 1. Create a ref called 'timerRef' which defaults to null
 *    (This will store our setInterval reference)
 * 
 * 2. Create state for:
 *    - time (number, starting at 0)
 *    - isRunning (boolean, starting as false)
 * 
 * 3. Implement three functions:
 *    - startTimer: 
 *      * Only starts if not already running
 *      * Stores setInterval in timerRef.current
 *      * Updates time every second
 * 
 *    - stopTimer:
 *      * Clears the interval using timerRef.current
 *      * Updates isRunning state
 * 
 *    - resetTimer:
 *      * Stops the timer
 *      * Resets time to 0
 * 
 * 4. Add cleanup in useEffect to clear interval when component unmounts
 * 
 * Hint: The component structure is provided, you need to add the logic!
 */

const Timer = () => {
  // Add your ref here
  
  // Add your state here
  
  // Add your useEffect cleanup here
  
  // Add your timer functions here

  return (
    <div className="p-4 space-y-4">
      <h2 className="text-xl font-bold">Simple Timer</h2>
      <div className="text-4xl font-mono">{time}s</div>
      <div className="space-x-2">
        <button
          onClick={startTimer}
          disabled={isRunning}
          className="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600 disabled:opacity-50"
        >
          Start
        </button>
        <button
          onClick={stopTimer}
          disabled={!isRunning}
          className="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600 disabled:opacity-50"
        >
          Stop
        </button>
        <button
          onClick={resetTimer}
          className="bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600"
        >
          Reset
        </button>
      </div>
    </div>
  );
};

## Challenge 2

export default Timer;
```

2. Previous Value Tracker Challenge:​​​​​​​​​​​​​​​​
``` jsx
/**
 * Challenge: Create a component that tracks previous values using refs
 * 
 * Requirements:
 * 1. Create two refs:
 *    - prevCountRef (to store the previous count value)
 *    - totalUpdatesRef (to track how many times the value has changed)
 *    Both should default to 0
 * 
 * 2. Create state for the current count
 * 
 * 3. Use useEffect to:
 *    - Update prevCountRef.current with the previous count value
 *    - Increment totalUpdatesRef.current
 *    (Think about what dependency this effect needs!)
 * 
 * 4. Create increment/decrement functions that update count state
 * 
 * Hint: Remember that changing a ref value doesn't trigger a re-render,
 *       which is exactly what we want for tracking previous values!
 */

const ValueTracker = () => {
  // Add your refs here
  
  // Add your state here
  
  // Add your effect here
  
  // Add your increment/decrement functions here

  return (
    <div className="p-4 space-y-4">
      <h2 className="text-xl font-bold">Value Tracker</h2>
      <div className="space-y-2">
        <p className="text-lg">Current Value: {count}</p>
        <p className="text-lg">Previous Value: {prevCountRef.current}</p>
        <p className="text-sm text-gray-600">
          Total Updates: {totalUpdatesRef.current}
        </p>
      </div>
      <div className="space-x-2">
        <button
          onClick={decrement}
          className="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600"
        >
          Decrease
        </button>
        <button
          onClick={increment}
          className="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600"
        >
          Increase
        </button>
      </div>
    </div>
  );
};

export default ValueTracker;
```

3. DOM Measurements Challenge:​​​​​​​​​​​​​​​​
```jsx
/**
 * Challenge: Create a component that measures DOM elements
 * 
 * Requirements:
 * 1. Create three refs:
 *    - elementRef (for the main container element)
 *    - resizeObserverRef (for storing the ResizeObserver instance)
 *    All should default to null
 * 
 * 2. Create state for:
 *    - dimensions (object with width and height)
 *    - isResizing (boolean)
 * 
 * 3. Create a measureElement function that:
 *    - Gets the elementRef's current value
 *    - Uses getBoundingClientRect() to measure it
 *    - Updates the dimensions state
 * 
 * 4. In useEffect:
 *    - Call measureElement initially
 *    - Create a ResizeObserver that calls measureElement
 *    - Store the observer in resizeObserverRef
 *    - Observe the elementRef's current value
 *    - Clean up by disconnecting the observer
 * 
 * Hint: ResizeObserver is a browser API that watches for element size changes.
 *       Don't forget to handle cleanup when the component unmounts!
 */

const DOMMeasurements = () => {
  // Add your refs here
  
  // Add your state here
  
  // Add your measureElement function here
  
  // Add your effect here

  return (
    <div className="p-4 space-y-4">
      <h2 className="text-xl font-bold">DOM Measurements</h2>
      <div 
        // Add your elementRef here
        className={`p-4 border-2 border-blue-500 rounded resize overflow-auto min-h-32 transition-colors ${
          isResizing ? 'border-green-500' : ''
        }`}
      >
        <p>Resize this container (drag bottom-right corner)</p>
        <div className="mt-2 space-y-1">
          <p>Width: {Math.round(dimensions.width)}px</p>
          <p>Height: {Math.round(dimensions.height)}px</p>
        </div>
      </div>
      <p className="text-sm text-gray-600">
        {isResizing ? 'Resizing...' : 'Static'}
      </p>
    </div>
  );
};

## Additional Notes

export default DOMMeasurements;
```

4. Multi-Reference Form Challenge:​​​​​​​​​​​​​​​​
``` jsx
/**
 * Challenge: Create a form with multiple refs for advanced input management
 * 
 * Requirements:
 * 1. Create three ref objects:
 *    - formRefs: an object containing refs for each input (username, email, bio)
 *    - errorTimeoutsRef: for storing error message timeouts
 *    - formErrorsRef: for storing current validation errors
 * 
 * 2. Create form state for:
 *    - username, email, and bio fields
 * 
 * 3. Implement these functions:
 *    - validateField(field, value):
 *      * Returns error message or empty string
 *      * Different validation for each field type
 * 
 *    - showError(field, error):
 *      * Uses formRefs to access input element
 *      * Sets custom validity message
 *      * Clears message after timeout
 * 
 *    - focusNextField(currentField):
 *      * Moves focus to next input when Enter is pressed
 *      * Uses formRefs to access elements
 * 
 * 4. Handle form submission:
 *    - Prevent default
 *    - Validate all fields
 *    - Show first error if any
 *    - Focus first invalid field
 * 
 * Hint: This is complex! Break it down into smaller pieces and
 *       test each part as you build it.
 */

const MultiRefForm = () => {
  // Add your refs here
  
  // Add your state here
  
  // Add your validation functions here
  
  // Add your error handling functions here
  
  // Add your focus management functions here
  
  // Add your submit handler here

  return (
    <div className="p-4 space-y-4">
      <h2 className="text-xl font-bold">Multi-Reference Form</h2>
      <form onSubmit={handleSubmit} className="space-y-4">
        {/* Add your form fields here with their refs */}
        {/* Remember to add validation and focus handling! */}
      </form>
    </div>
  );
};

export default MultiRefForm;
```

Each challenge now follows a similar structure to the example in your image:
5. Clear description of the challenge
6. Specific requirements listed as steps
7. Hints for implementation
8. Base component structure provided
9. Comments indicating where to add your code

This approach allows you to:
- Practice importing and using [[useRef]] on your own
- Understand the problem before implementing the solution
- Follow clear steps to build each feature
- Learn from hints without getting the complete solution
- Have a working structure to build upon

Would you like me to explain any of the challenges in more detail or provide additional hints for any specific part?​​​​​​​​​​​​​​​​