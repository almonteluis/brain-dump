---
description: Metabase modular embedding authentication with JWT SSO, SAML SSO, and API keys for the React SDK
tags: [metabase, embedding, jwt, saml, sso, authentication, react]
sources: [Modular embedding - authentication.md]
created: 2026-04-30
updated: 2026-04-30
---

# Metabase Modular Embedding Authentication

**Source:** Modular embedding - authentication.md
**Date ingested:** 2026-04-30
**Type:** guide

## Summary

Comprehensive authentication guide for Metabase's modular embedding SDK. Covers JWT SSO setup (Express and Next.js), SAML SSO configuration, API key evaluation auth, custom `fetchRequestToken`, cross-domain CORS configuration, SameSite cookie settings, and SDK v54+ upgrade changes.

## Key Claims

- Authenticated embeds require Pro or Enterprise plan
- API keys are evaluation-only for local development
- Backend must return `{ jwt: string }` JSON for SDK requests
- SDK adds `response=json` query param to distinguish from full app embedding
- SAML defaults over JWT if both are enabled; override with `preferredAuthMethod: "jwt"`
- Each end-user must have their own Metabase account (shared accounts expose session tokens)
- SDK v54+ removed `authProviderUri` from `defineMetabaseAuthConfig`

## JWT SSO Backend (Dual-Mode Endpoint)

```typescript
app.get("/sso/metabase", async (req, res) => {
  const isSdkRequest = req.query.response === "json";
  const token = jwt.sign({
    email: user.email,
    first_name: user.firstName,
    last_name: user.lastName,
    groups: [user.group],
    exp: Math.round(Date.now() / 1000) + 60 * 10,
  }, METABASE_JWT_SHARED_SECRET);

  if (isSdkRequest) {
    res.status(200).json({ jwt: token });
  } else {
    const ssoUrl = `${METABASE_INSTANCE_URL}/auth/sso?token=true&jwt=${token}`;
    res.redirect(ssoUrl);
  }
});
```

## Next.js App Router Example

```typescript
export async function GET() {
  const token = jwt.sign({ /* user claims */ }, METABASE_JWT_SHARED_SECRET);
  return Response.json({ jwt: token });
}
```

## Custom fetchRequestToken

```typescript
const authConfig = defineMetabaseAuthConfig({
  fetchRequestToken: async () => {
    const response = await fetch("/api/metabase/auth", {
      method: "GET",
      headers: { Authorization: `Bearer ${yourToken}` },
    });
    return await response.json(); // { jwt: string }
  },
  metabaseInstanceUrl: "http://localhost:3000",
});
```

## SAML Configuration

```typescript
const authConfig = defineMetabaseAuthConfig({
  metabaseInstanceUrl: "http://localhost:3000",
  preferredAuthMethod: "saml", // or "jwt" to override default
});
```

## Cross-Domain CORS

1. Add embedding domain in Metabase: Admin > Embedding > Modular > CORS
2. Set SameSite cookie: Admin > Embedding > Security > SameSite
   - `Lax` (default): same domain
   - `None` (requires HTTPS): cross-domain
   - `Strict`: no session sharing with embeds

## SDK v54+ Breaking Changes

- Remove `authProviderUri` from `defineMetabaseAuthConfig`
- `fetchRequestToken` no longer receives URL parameter; hardcode endpoint
- Backend must detect `response=json` and return JSON for SDK, redirect for full app

## Security Warning

Shared Metabase accounts expose session tokens. Every end-user must have their own account for proper permission enforcement.

## Entities Mentioned

- [[Metabase]] — BI platform
- [[JWT]] — JSON Web Tokens
- [[SAML]] — alternative SSO protocol
- [[Next.js]] — React framework
- [[Express]] — Node.js framework
- [[CORS]] — cross-origin resource sharing

## Concepts Covered

- [[jwt-sso]] — token-based authentication flow
- [[sdk-vs-full-app-embedding]] — dual-mode backend endpoint
- [[saml-sso]] — enterprise identity provider integration
- [[cross-domain-embedding]] — CORS and cookie configuration
- [[user-provisioning]] — per-user account requirement
