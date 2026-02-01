---
description: Notes about environment variables for API endpoints.
---

Environment Variables in React.js:

1. Create Environment Files
```bash
# .env.development
REACT_APP_API_URL=http://localhost:8000/api

# .env.production
REACT_APP_API_URL=https://api.production.com/api
```

2. Using Environment Variables
```javascript
import React, { useState, useEffect } from 'react';

function UserList() {
  const [users, setUsers] = useState([]);
  const apiUrl = process.env.REACT_APP_API_URL;

  useEffect(() => {
    fetch(`${apiUrl}/users`)
      .then(response => response.json())
      .then(data => setUsers(data));
  }, []);

  return (
    <ul>
      {users.map(user => (
        <li key={user.id}>{user.name}</li>
      ))}
    </ul>
  );
}
```

# Explanation

## Key Concepts

* **Naming Convention**: Must start with `REACT_APP_` prefix
* **Access Pattern**: Use `process.env.REACT_APP_*` in code
* **Build Time**: Variables are embedded during build
* **Security**: Frontend env vars are public in browser

## File Structure
* **.env**: Default for all environments
* **.env.local**: Local overrides (ignored by git)
* **.env.development**: Development environment
* **.env.production**: Production environment
* **.env.test**: Testing environment

## Best Practices

### Security
* Never store secrets in frontend env vars
* Avoid sensitive data like API keys
* Use backend for sensitive operations

### Organization
```javascript
// api.config.js
export const API_CONFIG = {
  BASE_URL: process.env.REACT_APP_API_URL,
  TIMEOUT: process.env.REACT_APP_TIMEOUT || 5000,
  VERSION: process.env.REACT_APP_VERSION || 'v1'
};
```

### Usage Example
```javascript
// api.service.js
import { API_CONFIG } from './api.config';

export const fetchUsers = async () => {
  try {
    const response = await fetch(`${API_CONFIG.BASE_URL}/users`);
    return response.json();
  } catch (error) {
    console.error('Error fetching users:', error);
    throw error;
  }
};
```

## Development Flow
* Create `.env` files for each environment
* Add `.env.local` to `.gitignore`
* Restart dev server after env changes
* Rebuild app to reflect new variables

## Common Patterns
```javascript
// Using default values
const apiUrl = process.env.REACT_APP_API_URL || 'http://localhost:3000';

// Environment-specific logic
const isDevelopment = process.env.NODE_ENV === 'development';
const isProduction = process.env.NODE_ENV === 'production';
```​​​​​​​​​​​​​​​​