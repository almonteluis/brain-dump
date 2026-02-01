---
description: React fundamentals flashcards for core concepts review.
tags: ["flashcards", "react"]
---

#flashcards #react

## Related Concepts
- [[Performance Optimization]] - React rendering optimization
- [[Memory Management]] - Component lifecycle and cleanup
- [[Code splitting]] - Lazy loading components
- [[Suspense]] - Loading states and boundaries

Basic Concepts::
<!--SR:!2025-02-04,3,252-->

What is JSX?::A syntax extension for JavaScript that allows you to write HTML-like code in JavaScript.
<!--SR:!2025-02-06,5,250-->

Explain the difference between props and state in React
?? Props:
   - Passed down from parent components
   - Read-only
   - Used for component configuration

   State:
   - Managed within the component
   - Can be modified using setState/useState
   - Used for internal component data
<!--SR:!2024-01-18,4,270-->

The ==useEffect==^[lifecycle hook][^1] hook is used to handle ==side effects==^[external operations][^2] in React components, such as ==data fetching==^[API calls][^3] or ==DOM manipulation==^[browser updates][^4].
<!--SR:!2025-02-08,7,270!2025-01-17,1,232!2025-02-03,2,232!2025-02-03,2,232-->

```markdown
React uses a ==virtual DOM== to optimize rendering performance.

The ==useState== hook returns an array with ==two elements==: the current state value and a setter function.

In React, we use ==props== to pass data ==down== through the component tree, while ==state== is managed ==within== a component.
```

When you review these cards, Obsidian will show the sentence with blanks where the highlighted text was, and you'll need to recall what goes in those blanks.

If you want to create multiple separate cloze deletions that will become different cards, you can use numeric markers. Here's how:

```markdown
The ==useState|1== hook in React returns an ==array|2== containing the ==state value|3== and ==setter function|3==.
```

## Practice

The numbers after the pipe character (`|1`, `|2`, `|3`) tell Obsidian to create separate cards for each group of cloze deletions. In this example, you'll get three cards:
1. One testing "useState"
2. One testing "array"
3. One testing both "state value" and "setter function" together
```

## Component Lifecycle
```javascript
// Mount
useEffect(() => {
  // Setup
  return () => {
    // Cleanup
  };
}, []); // Empty deps = mount/unmount only

// Update
useEffect(() => {
  // Handle updates
}, [dependency]); // Run when dependency changes
```
