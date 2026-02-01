---
description: useMemo caches expensive calculations and only recomputes when dependencies change, optimizing performance for costly operations.
tags: ["hooks", "my-calculation-runs-twice-on-every-re-render", "react", "useMemo"]
---

### Troubleshooting
### My calculation runs twice on every re-render [](https://react.dev/reference/react/useMemo#my-calculation-runs-twice-on-every-re-render "Link for My calculation runs twice on every re-render")

In [Strict Mode](https://react.dev/reference/react/StrictMode), React will call some of your functions twice instead of once:

```
function TodoList({ todos, tab }) {  // This component function will run twice for every render.  const visibleTodos = useMemo(() => {    // This calculation will run twice if any of the dependencies change.    return filterTodos(todos, tab);  }, [todos, tab]);  // ...
```

This is expected and shouldn’t break your code.

This **development-only** behavior helps you [keep components pure.](https://react.dev/learn/keeping-components-pure) React uses the result of one of the calls, and ignores the result of the other call. As long as your component and calculation functions are pure, this shouldn’t affect your logic. However, if they are accidentally impure, this helps you notice and fix the mistake.

For example, this impure calculation function mutates an array you received as a prop:

``` jsx
  const visibleTodos = useMemo(() => {
	// 🚩 Mistake: mutating a prop    
	todos.push({ id: 'last', text: 'Go for a walk!' });
	const filtered = filterTodos(todos, tab);
	return filtered;
	}, [todos, tab]);
```

React calls your function twice, so you’d notice the todo is added twice. Your calculation shouldn’t change any existing objects, but it’s okay to change any _new_ objects you created during the calculation. For example, if the `filterTodos` function always returns a _different_ array, you can mutate _that_ array instead:

```
  const visibleTodos = useMemo(() => {    const filtered = filterTodos(todos, tab);    // ✅ Correct: mutating an object you created during the calculation    filtered.push({ id: 'last', text: 'Go for a walk!' });    return filtered;  }, [todos, tab]);
```

Read [keeping components pure](https://react.dev/learn/keeping-components-pure) to learn more about purity.

Also, check out the guides on [updating objects](https://react.dev/learn/updating-objects-in-state) and [updating arrays](https://react.dev/learn/updating-arrays-in-state) without mutation.

### Tag
#useMemo #hooks #react 