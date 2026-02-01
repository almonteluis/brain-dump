---
description: Handle async data fetching in React using useEffect with cleanup for aborting requests, useState for loading/error states, and proper dependency arrays.
tags: ["async", "data-fetching", "interview", "react", "useEffect"]
---

# Async Data Fetching

## Patterns

#react #async #data-fetching #useEffect #interview

> Asynchronous [[Data fetching]] in React typically involves using [[useEffect]] hook with async/await syntax, managing loading and error states, and properly handling component unmounting to prevent memory leaks. This pattern ensures smooth user experience while waiting for data to load.

#### Code Example:
```javascript
function DataFetchingComponent() {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    // Track mounted state
    let isMounted = true;

## Example

    async function fetchData() {
      try {
        setLoading(true);
        const response = await fetch('https://api.example.com/data');
        const result = await response.json();
        
        if (isMounted) {
          setData(result);
          setError(null);
        }
      } catch (err) {
        if (isMounted) {
          setError(err.message);
          setData(null);
        }
      } finally {
        if (isMounted) {
          setLoading(false);
        }
      }
    }

    fetchData();

    // Cleanup function
    return () => {
      isMounted = false;
    };
  }, []); // Empty dependency array

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;
  if (!data) return <div>No data found</div>;

  return <div>{/* Render data */}</div>;
}
```

#### Key Points:
* Use [[useEffect]] for [[Data fetching]] on component mount
* Handle loading, error, and success states
* Implement cleanup to prevent updates on unmounted components
* Consider using libraries like React Query or SWR for complex cases​​​​​​​​​​​​​​​​