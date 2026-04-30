---
description: JSON Web Tokens for compact, self-contained authentication claims transmission
tags: [jwt, auth, security, token, sso, concept]
created: 2026-04-30
updated: 2026-04-30
---

# JWT (JSON Web Token)

Compact, URL-safe means of representing claims between two parties. Widely used for authentication and information exchange.

## Structure

```
header.payload.signature
```

- **Header**: algorithm and token type
- **Payload**: claims (iss, sub, aud, exp, iat, custom claims)
- **Signature**: HMAC or RSA signature

## Common Claims

| Claim | Meaning |
|-------|---------|
| `exp` | Expiration time |
| `iat` | Issued at |
| `sub` | Subject (user ID) |
| `email` | User email |
| `groups` | User group memberships |

## Security Considerations

- Always verify signature
- Check expiration
- Use HTTPS in transit
- Store secrets securely (not in code)
- Short expiration for sensitive operations

## Related

- [[metabase-full-app-embedding]] — JWT SSO implementation
- [[metabase-modular-authentication]] — JWT for SDK auth
- [[Auth0]] — identity platform using JWT
