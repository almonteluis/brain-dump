---
description: Full app embedding guide for Metabase using JWT SSO with group synchronization and row-level permissions
tags: [metabase, embedding, jwt, sso, permissions, security]
sources: [Full app embedding quickstart.md]
created: 2026-04-30
updated: 2026-04-30
---

# Metabase Full App Embedding

**Source:** Full app embedding quickstart.md
**Date ingested:** 2026-04-30
**Type:** guide

## Summary

Complete guide for embedding the full Metabase application in a web app using JWT SSO. Covers enabling full app embedding, JWT configuration, backend SSO route implementation (Node.js/Express), iframe embedding, group synchronization, row-level permissions via user attributes, and UI element hiding.

## Key Claims

- Full app embedding requires Pro or Enterprise subscription
- JWT Identity Provider URI points to your app's `/sso/metabase` endpoint
- JWT signing key should be stored as an environment variable
- Metabase auto-creates accounts on first-time SSO sign-ins
- Group synchronization maps JWT `groups` array to Metabase groups
- Row-level security uses JWT payload keys as user attributes mapped to table columns
- UI elements (logo, nav, search, +New button) can be hidden via query parameters

## JWT Token Structure

```javascript
jwt.sign({
  email: user.email,
  first_name: user.firstName,
  last_name: user.lastName,
  groups: ["Customer-Acme"],
  account_id: 28,  // for row-level security
  exp: Math.round(Date.now() / 1000) + 60 * 10, // 10 min
}, METABASE_JWT_SHARED_SECRET);
```

## Backend SSO Route (Express)

```javascript
app.get("/sso/metabase", restrict, (req, res) => {
  const ssoUrl = new URL("/auth/sso", METABASE_INSTANCE_URL);
  ssoUrl.searchParams.set("jwt", signUserToken(req.session.user));
  ssoUrl.searchParams.set("return_to", req.query.return_to?.toString() ?? "/");
  res.redirect(ssoUrl.href);
});
```

## Iframe Embedding

```javascript
app.get("/analytics", restrict, (req, res) => {
  const iframeUrl = `/sso/metabase?return_to=${METABASE_DASHBOARD_PATH}`;
  res.send(`<iframe src="${iframeUrl}" frameborder="0" width="1280" height="600" allowtransparency></iframe>`);
});
```

## Hiding UI Elements

Append query parameters to `return_to`:
```javascript
ssoUrl.searchParams.set("return_to", `${req.query.return_to ?? "/"}?logo=false&top_nav=false`);
```

## Row-Level Security Setup

1. Reset "All Users" group permissions to "Blocked"
2. Set target table's "View data access" to "Row and column security"
3. Associate table column (e.g., "Account ID") with JWT user attribute (e.g., `account_id`)

## Entities Mentioned

- [[Metabase]] — BI platform
- [[JWT]] — authentication token format
- [[jsonwebtoken]] — Node.js JWT library
- [[Express]] — Node.js web framework

## Concepts Covered

- [[full-app-embedding]] — iframe-based complete Metabase embedding
- [[jwt-sso]] — token-based single sign-on
- [[group-synchronization]] — mapping app groups to Metabase groups
- [[row-level-security]] — attribute-based data filtering
- [[subresource-integrity]] — SRI for embedded CDN libraries
