---
description: Session-based authentication stores session IDs in browser cookies and server databases, destroying them on logout or expiration.
tags: ["authentication", "nodejs", "sessions", "express-session"]
---

# Session-based Authentication in Node.js

Session-based authentication is the oldest form of authentication technology. The flow follows these steps:

1. The user uses their credentials to log in.
2. The login credentials are verified against the credentials in a database.
3. The server creates a session with a session ID (unique encrypted string) stored in the database.
4. The session ID is also stored in the browser as a cookie.
5. When the user logs out or the session expires, the session ID is destroyed on both browser and database.

## Code Example

```javascript
const express = require('express');
const session = require('express-session');

const app = express();

// Middleware to set up session management
app.use(session({
  secret: 'secret-key',      // Replace with a strong secret key
  resave: false,             // Whether to save session data if unmodified
  saveUninitialized: true,   // Whether to save new but unmodified sessions
  cookie: { secure: false }  // Set to true in production with HTTPS
}));

// POST endpoint for handling login
app.post('/login', (req, res) => {
  const { username, password } = req.body;

  // Simulated user authentication (replace with actual logic)
  if (username === 'user' && password === 'password') {
    req.session.user = username;  // Store user information in session
    res.send('Logged in successfully');
  } else {
    res.send('Invalid credentials');
  }
});

// GET endpoint for accessing dashboard
app.get('/dashboard', (req, res) => {
  if (req.session.user) {
    res.send(`Welcome ${req.session.user}`);
  } else {
    res.send('Please log in first');
  }
});

app.listen(3000, () => console.log('Server running on port 3000'));
```

## How It Works

| Component | Responsibility |
|-----------|---------------|
| **Express Setup** | Configures Express with express-session middleware |
| **Session Configuration** | Secret key encrypts session data; options control session behavior |
| **Login Endpoint** | Validates credentials and stores user in session |
| **Dashboard Endpoint** | Checks if user is authenticated via session |

## Related

[[Token-based Authentication in Node.js]]
[[Passwordless Authentication in Node.js]]
