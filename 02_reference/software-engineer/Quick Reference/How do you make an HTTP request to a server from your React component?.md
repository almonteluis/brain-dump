---
description: Make HTTP requests in React using fetch API or axios within useEffect for data fetching, handling async responses with proper error management and cleanup.
tags: ["prefer"]
---
Making POST Requests in React:

1. Using [[Fetch]] API (built-in)
```javascript
import React, { useState } from 'react';

function PostComponent() {
  const [status, setStatus] = useState('');

  const handleSubmit = async (event) => {
    event.preventDefault();
    
    try {
      const response = await fetch('https://api.example.com/data', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ key: 'value' })
      });
      const result = await response.json();
      setStatus('Success');
    } catch (error) {
      setStatus('Error: ' + error.message);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <button type="submit">Submit</button>
      <p>{status}</p>
    </form>
  );
}
```

2. Using Axios (library)
```javascript
import React, { useState } from 'react';
import axios from 'axios';

function PostComponent() {
  const [status, setStatus] = useState('');

  const handleSubmit = async (event) => {
    event.preventDefault();
    
    try {
      const response = await axios.post('https://api.example.com/data', {
        key: 'value'
      });
      setStatus('Success');
    } catch (error) {
      setStatus('Error: ' + error.message);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <button type="submit">Submit</button>
      <p>{status}</p>
    </form>
  );
}
```

# Explanation

## Key Components
* **Imports**: Required dependencies from React and HTTP client libraries
* ==**State Management**: Using `useState` hook to track request status==
* **Event Handler**: Async function to process form submission
* **Request Setup**: Configuration of method, headers, and request body
* **Error Handling**: Try/catch blocks for success and error states
* **UI Rendering**: Form display and status feedback

## Differences Between Approaches

### [[Fetch]] API
* Requires manual JSON stringification for request body
* Needs explicit header configuration
* Two-step process for handling JSON responses
* Built into browsers, no additional dependencies

### Axios
#prefer
* Automatic JSON data transformation 
* Simpler API with less boilerplate
* Built-in response handling
* Requires installing additional package

## Best Practices
* Always [[handle loading and error states]]
* Use [[environment variables for API endpoints]]
* Implement proper error boundaries
* Add request cancellation for cleanup
* Consider request caching for optimization​​​​​​​​​​​​​​​​