---
description: Token-based authentication uses JWTs containing user claims and permissions, passed with each HTTP request for stateless API access.
tags: ["authentication", "authorization", "jwt", "nodejs", "tokens"]
---

# Token-based Authentication in Node.js

Token-based security has two parts: **authentication** and **authorization**.

- **Authentication**: Providing credentials and obtaining a token proving user identity
- **Authorization**: Using that token to access protected resources

## What is a JWT?

A JSON Web Token (JWT) is an encrypted payload in JSON format with three parts:

| Part | Description |
|------|-------------|
| **Header** | Token type and algorithm used |
| **Payload** | User attributes (claims): permissions, groups, expirations |
| **Signature** | Verifies token integrity — ensures it hasn't been tampered with |

## Authentication Flow

1. User's browser calls authentication server
2. Server generates and returns an ID token (stored as encrypted cookie)
3. ID token proves user is authenticated to the web application

## Authorization Flow

```
User → Auth Server → Access Token → Client → API Server → Protected Resource
```

When accessing protected APIs:
1. User authenticates against Authorization server
2. Server creates an **access token** (separate from ID token)
3. Client stores the access token
4. Token passed with every HTTP request to resource server
5. Token contains embedded permissions — no additional server lookup needed

## Code Example

```javascript
const express = require('express');
const jwt = require('jsonwebtoken');
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.json());

const secretKey = 'your-secret-key'; // Replace with strong secret

// POST endpoint for user login and JWT generation
app.post('/login', (req, res) => {
  const { username, password } = req.body;

  // Simulated user authentication
  if (username === 'user' && password === 'password') {
    // Generate JWT with username payload
    const token = jwt.sign({ username }, secretKey, { expiresIn: '1h' });
    res.json({ token });
  } else {
    res.send('Invalid credentials');
  }
});

// GET endpoint to access protected resource
app.get('/dashboard', (req, res) => {
  // Get token from Authorization header
  const token = req.headers['authorization'];

  if (token) {
    // Verify JWT token
    jwt.verify(token, secretKey, (err, decoded) => {
      if (err) {
        res.send('Invalid token');
      } else {
        res.send(`Welcome ${decoded.username}`);
      }
    });
  } else {
    res.send('Token missing');
  }
});

app.listen(3000, () => console.log('Server running on port 3000'));
```

## How It Works

| Component | Responsibility |
|-----------|---------------|
| **Express Setup** | Configures Express with body-parser for JSON |
| **JWT Generation (/login)** | Creates signed token with user payload |
| **JWT Verification (/dashboard)** | Validates token and extracts claims |

## Related

[[Session-based Authentication in Node.js]]
[[Passwordless Authentication in Node.js]]
