---
description: Passwordless authentication uses public/private key encryption with magic links, biometrics, or one-time codes sent via email or SMS.
tags: ["authentication", "nodejs", "passwordless", "biometrics", "magic-link"]
---

# Passwordless Authentication in Node.js

Passwordless authentication allows users to gain access without credentials by proving identity through:
- Biometrics (fingerprint, Face ID)
- Magic links sent to email
- One-time passcodes via SMS

## How It Works

Passwordless authentication uses **Public Key and Private Key Encryption**:

1. User registers → device generates private/public key pair
2. Public key stored with application; private key stays on user's device
3. App generates login challenge (biometric prompt, magic link, SMS code)
4. Challenge encrypted with public key
5. Private key decrypts the message
6. App verifies the challenge and authorizes user

```
Registration:                     Authentication:
User Device → Public Key         App → Challenge (encrypted with public key)
Server → Private Key             User Device → Decrypt with private key
                               → Response → App verifies → Access granted
```

## Code Example

```javascript
const express = require('express');
const bodyParser = require('body-parser');
const nodemailer = require('nodemailer');

const app = express();
app.use(bodyParser.json());

const users = {}; // In-memory storage for demo purposes

// Endpoint to request access and send verification code
app.post('/request-access', (req, res) => {
  const { email } = req.body;

  // Generate a 6-digit verification code
  const code = Math.floor(100000 + Math.random() * 900000).toString();

  // Store the code in memory
  users[email] = code;

  // Send code via email (simulated here)
  console.log(`Sending code ${code} to ${email}`);

  res.send('Code sent to your email');
});

// Endpoint to verify the received code
app.post('/verify-code', (req, res) => {
  const { email, code } = req.body;

  // Compare received code with stored code
  if (users[email] === code) {
    res.send('Access granted');
  } else {
    res.send('Invalid code');
  }
});

app.listen(3000, () => console.log('Server running on port 3000'));
```

## How It Works

| Component | Responsibility |
|-----------|---------------|
| **Express Setup** | Configures Express with body-parser for JSON |
| **Request Access** | Generates verification code and stores it |
| **Verify Code** | Compares submitted code against stored code |

## Related

[[Session-based Authentication in Node.js]]
[[Token-based Authentication in Node.js]]
