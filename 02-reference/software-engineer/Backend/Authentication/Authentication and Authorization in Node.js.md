---
description: Authentication confirms user identity through credentials, while authorization determines resource access permissions using session-based, token-based, or passwordless methods.
tags: ["authentication", "authorization", "nodejs", "jwt", "sessions"]
---

# Authentication and Authorization in Node.js

## What is Authentication?

Authentication confirms a user's identity using credentials — validating who they claim to be. It's the backend's responsibility to secure the application.

## Three Authentication Methods

| Method | Description |
|--------|-------------|
| [[Session-based Authentication in Node.js]] | Session IDs stored in database and browser cookies |
| [[Token-based Authentication in Node.js]] | JWTs passed with each HTTP request |
| [[Passwordless Authentication in Node.js]] | Public/private key encryption with magic links or codes |

## Quick Comparison

| Method | State | Storage | Best For |
|--------|-------|---------|----------|
| Session-based | Stateful | Database + Cookie | Traditional web apps |
| Token-based | Stateless | Client-side | APIs, SPAs |
| Passwordless | Stateless | Public/private keys | Enhanced security |

## Related

[[Node.js Middleware Patterns]]
[[JWT Implementation Guide]]
