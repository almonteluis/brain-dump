---
description: React hooks allow functional components to use state through useState for local state management and useEffect for side effects like data fetching and subscriptions.
tags: ["hooks", "interview", "react", "useEffect", "useState"]
---

# React Hooks: useState and useEffect

## Overview

#react #hooks #useState #useEffect #interview

> React [[Hooks]] allow functional components to use state, lifecycle methods, and other React features. [[useState]] manages local state in components, while [[useEffect]] handles side effects like [[Data fetching]], subscriptions, or DOM manipulations. They replace the need for class components and provide a more direct way to use React features.

#### Code Example:
```javascript
function UserProfile() {
  // State hook
  const [user, setUser] = useState({
    name: '',
    isLoading: true
  });

  // Effect hook - runs on mount and when userId changes
  useEffect(() => {
    async function fetchUser() {
      const data = await getUser();
      setUser({
        name: data.name,
        isLoading: false
      });
    }
    fetchUser();

    // Cleanup function - runs before next effect or unmount
    return () => {
      // cleanup code (e.g., cancel subscriptions)
    };
  }, [userId]); // Dependency array

  if (user.isLoading) return <div>Loading...</div>;
  return <div>Welcome, {user.name}</div>;
}
```

#### Key Points:
* [[useState]] returns current state and setter function
* [[useEffect]] runs after render and handles side effects
* Empty dependency array means effect runs only on mount
* Cleanup function prevents memory leaks​​​​​​​​​​​​​​​​