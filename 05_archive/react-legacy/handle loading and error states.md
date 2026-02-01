---
description: Axios integration with React for handling loading states, error management, and data fetching patterns including request cancellation and cleanup.
tags: [axios, react, error-handling, loading-states, api-integration]
---

# Handling Loading and Error States with Axios in React


1. Basic Implementation
```javascript
import React, { useState, useEffect } from 'react';
import axios from 'axios';

function UserList() {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axios.get('https://api.example.com/users');
        setData(response.data);
        setError(null);
      } catch (err) {
        setError(err.message);
        setData([]);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;

  return (
    <ul>
      {data.map(item => (
        <li key={item.id}>{item.name}</li>
      ))}
    </ul>
  );
}
```

2. Custom Hook Pattern
```javascript
function useAxios(url) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const source = axios.CancelToken.source();

    const fetchData = async () => {
      try {
        const response = await axios.get(url, {
          cancelToken: source.token
        });
        setData(response.data);
        setError(null);
      } catch (err) {
        if (axios.isCancel(err)) {
          console.log('Request cancelled');
        } else {
          setError(err.message);
          setData(null);
        }
      } finally {
        setLoading(false);
      }
    };

    fetchData();

    return () => {
      source.cancel();
    };
  }, [url]);

  return { data, loading, error };
}
```

# Explanation

## Key States
* **Loading State**: Track if request is in progress
* **Error State**: Store error messages if request fails
* **Data State**: Hold successful response data

## Implementation Details

### State Management
```javascript
const [loading, setLoading] = useState(true);
const [error, setError] = useState(null);
const [data, setData] = useState(null);
```

### Error Handling
```javascript
try {
  // API call
} catch (error) {
  if (axios.isCancel(error)) {
    // Handle cancelled request
  } else if (error.response) {
    // Handle server error (4xx, 5xx)
  } else if (error.request) {
    // Handle network error
  } else {
    // Handle other errors
  }
}
```

### Loading States
```javascript
// Component with loading states
function LoadingStates() {
  if (loading) {
    return <LoadingSpinner />;
  }

  if (error) {
    return <ErrorMessage message={error} />;
  }

  if (!data) {
    return <EmptyState />;
  }

  return <DataDisplay data={data} />;
}
```

## Best Practices

### Component Organization
* Separate loading/error components
* Use meaningful loading states
* Implement retry mechanisms
* Show user-friendly error messages

### Request Cleanup
* Cancel pending requests on unmount
* Handle race conditions
* Clear stale data

### Error Boundaries
```javascript
class ErrorBoundary extends React.Component {
  state = { hasError: false }

  static getDerivedStateFromError(error) {
    return { hasError: true };
  }

  render() {
    if (this.state.hasError) {
      return <h1>Something went wrong.</h1>;
    }

    return this.props.children;
  }
}
```

### Usage Example
```javascript
function App() {
  return (
    <ErrorBoundary>
      <UserList />
    </ErrorBoundary>
  );
}
```
