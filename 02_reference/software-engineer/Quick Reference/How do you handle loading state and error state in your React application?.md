---
description: Handle loading and error states in React using useState to track async operations, conditional rendering for loading/error UI, and useEffect for triggering side effects.
tags: ["error-handling", "interview", "loading-states", "react", "user-experience"]
---

# Loading and Error States

## Patterns

#react #error-handling #loading-states #user-experience #interview

> Loading and error states are crucial for user experience in React applications. They involve managing state variables for loading and error conditions, showing appropriate UI feedback during [[Data fetching]], and handling errors gracefully with informative messages to users.

#### Code Example:
```javascript
function UserDashboard() {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        // Set loading state
        setLoading(true);
        setError(null);
        
## Patterns

        const response = await fetch('/api/user-data');
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        const result = await response.json();
        setData(result);
      } catch (error) {
        setError(error.message);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  // Handle different states
  if (loading) {
    return (
      <div className="loading-state">
        <Spinner />
        <p>Loading user data...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="error-state">
        <ErrorIcon />
        <p>Error: {error}</p>
        <button onClick={() => window.location.reload()}>
          Try Again
        </button>
      </div>
    );
  }

  return (
    <div className="dashboard">
      {/* Render actual content */}
    </div>
  );
}
```

#### Key Points:
* Initialize loading and error states at component mount
* Show user-friendly loading indicators
* Display clear error messages with recovery options
* Consider using error boundaries for app-wide error handling​​​​​​​​​​​​​​​​