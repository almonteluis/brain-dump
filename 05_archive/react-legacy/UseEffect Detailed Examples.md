---
description: React useEffect hook detailed examples and patterns for side effects in React components.
tags: ["myInput", "useEffect"]
---

# useEffect Examples

## Basic Usage

## Patterns


#useEffect 
## Detailed Examples:

1. [[Data fetching]]
```javascript
function UserProfile({ userId }) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchUser = async () => {
      try {
        const response = await fetch(`/api/users/${userId}`);
        const data = await response.json();
        setUser(data);
      } catch (error) {
        console.error(error);
      } finally {
        setLoading(false);
      }
    };

    fetchUser();
  }, [userId]); // Re-fetch when userId changes
}
```

2. Event Listeners
```javascript
function ScrollComponent() {
  const [scrollY, setScrollY] = useState(0);

  useEffect(() => {
    const handleScroll = () => {
      setScrollY(window.scrollY);
    };

    window.addEventListener('scroll', handleScroll);

    // Cleanup
    return () => {
      window.removeEventListener('scroll', handleScroll);
    };
  }, []); // Empty array = only run once
}
```

3. Subscriptions
```javascript
function DataSubscriber() {
  useEffect(() => {
    const subscription = dataSource.subscribe(data => {
      // Handle data
    });

    // Cleanup subscription
    return () => {
      subscription.unsubscribe();
    };
  }, [dataSource]); // Resubscribe if source changes
}
```

4. DOM Mutations
```javascript
function AutoFocus() {
  useEffect(() => {
    const input = document.querySelector('#myInput');
    input.focus();
  }, []); // Run once after mount

  return <input id="myInput" />;
}
```
