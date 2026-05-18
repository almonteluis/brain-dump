---
description: JWT — JSON Web Tokens. Compact, self-contained auth tokens. Three parts: header.payload.signature. Everywhere in modern auth.
tags:
  - jwt
  - authentication
  - security
  - token
  - sso
  - concept
created: 2026-04-30
updated: 2026-05-17
---

# JWT (JSON Web Token)

JWTs are the parking tickets of web auth. The server hands you one, you carry it around, and every service you hit checks it without calling back to the front desk. Three dot-separated parts — header, payload, signature — all base64-encoded. The payload carries claims (who you are, when the token expires, what groups you belong to). The signature proves nobody tampered with it.

## Structure

```
header.payload.signature
```

- **Header**: algorithm and token type
- **Payload**: claims — iss, sub, aud, exp, iat, plus whatever custom ones your app needs
- **Signature**: HMAC or RSA — this is what makes it trustworthy

## Common Claims

| Claim | Meaning |
|-------|---------|
| `exp` | Expiration time |
| `iat` | Issued at |
| `sub` | Subject (user ID) |
| `email` | User email |
| `groups` | User group memberships |

## Security Rules

- Always verify the signature (obviously)
- Check expiration
- Use HTTPS in transit
- Store secrets securely (not in code, not in localStorage)
- Short expiration for sensitive operations — refresh tokens for longer sessions

JWTs are stateless by design — the server doesn't need to look up the token in a database. That's the strength and the weakness. You can't revoke one without building a blacklist, and once issued, it's valid until it expires. [[auth0]] handles all of this so you don't have to think about it.

## Related

- [[metabase-full-app-embedding]] — JWT SSO implementation
- [[metabase-modular-authentication]] — JWT for SDK auth
- [[Auth0]] — identity platform using JWT
