---
description: "Adding SSO with JWT or SAML for authenticating modular embeds."
tags: ['research']
source: "https://www.metabase.com/docs/latest/embedding/authentication?utm_source=perplexity"
raw_file: "Modular embedding - authentication.md"
created: 2026-05-17
---

[What’s new](https://www.metabase.com/releases?utm_source=perplexity)

Authenticated embeds are only available on [Pro](https://www.metabase.com/product/pro?utm_source=perplexity) and [Enterprise](https://www.metabase.com/product/enterprise?utm_source=perplexity) plans (both self-hosted and on Metabase Cloud).

For using modular embedding with SSO in production, you’ll need to set up authentication.

If you’re developing locally, you can also set up authentication with [API keys](https://www.metabase.com/docs/latest/embedding/authentication?utm_source=perplexity#authenticating-locally-with-api-keys).

You can set up SSO with JWT or SAML.

## Setting up JWT SSO

To set up JWT SSO, you’ll need [a Metabase Pro or Enterprise license](https://www.metabase.com/pricing/?utm_source=perplexity).

Here’s a high-level overview:

### 1\. Enable JWT SSO in your Metabase

1. Configure JWT by going to **Admin** > **Settings** > **Authentication** and clicking on **JWT**
2. Enter the JWT Identity Provider URI, for example `http://localhost:9090/sso/metabase`. This is a new endpoint you will add in your backend to handle authentication.
3. Generate a key and copy it to your clipboard.

### 2\. Add a new endpoint to your backend to handle authentication

You’ll need to add a library to your backend to sign your JSON Web Tokens.

For Node.js, we recommend jsonwebtoken:

```
npm install jsonwebtoken --save
                    Copy                        Copied
```

Next, set up an endpoint on your backend (e.g., `/sso/metabase`) that uses your Metabase JWT shared secret to generate a JWT for the authenticated user. **This endpoint must return a JSON object with a `jwt` property containing the signed JWT.** For example: `{ "jwt": "your-signed-jwt" }`.

This example code for Node.js sets up an endpoint using Express:

```js
import express from "express";
import cors from "cors";
import session from "express-session";
import jwt from "jsonwebtoken";
import fetch from "node-fetch";

// Replace this with your Metabase URL
const METABASE_INSTANCE_URL = "YOUR_METABASE_URL_HERE";
// Replace this with the JWT signing secret you generated when enabling
// JWT SSO in your Metabase.
const METABASE_JWT_SHARED_SECRET = "YOUR_SECRET_HERE";

const app = express();

app.get("/sso/metabase", async (req, res) => {
  // Usually, you would grab the user from the current session
  // Here it's hardcoded for demonstration purposes
  // Example:
  // const { user } = req.session;
  const user = {
    email: "rene@example.com",
    firstName: "Rene",
    lastName: "Descartes",
    group: "Customer",
  };

  if (!user) {
    console.log("no user");
    res.status(401).json({
      status: "error",
      message: "not authenticated",
    });

    return;
  }

  const token = jwt.sign(
    {
      email: user.email,
      first_name: user.firstName,
      last_name: user.lastName,
      groups: [user.group],
      exp: Math.round(Date.now() / 1000) + 60 * 10, // 10 minutes expiration
    },
    METABASE_JWT_SHARED_SECRET,
  );
  // The user backend should return a JSON object with the JWT.
  res.status(200).json({ jwt: token });
});
                    Copy                        Copied
```

Example using Next.js App Router:

```typescript
import jwt from "jsonwebtoken";

const user = {
  email: "rene@example.com",
  firstName: "Rene",
  lastName: "Descartes",
  group: "Customer",
};

const METABASE_JWT_SHARED_SECRET = process.env.METABASE_JWT_SHARED_SECRET || "";
const METABASE_INSTANCE_URL = process.env.METABASE_INSTANCE_URL || "";

export async function GET() {
  const token = jwt.sign(
    {
      email: user.email,
      first_name: user.firstName,
      last_name: user.lastName,
      groups: [user.group],
      exp: Math.round(Date.now() / 1000) + 60 * 10, // 10 minutes expiration
    },
    // This is the JWT signing secret in your Metabase JWT authentication setting
    METABASE_JWT_SHARED_SECRET,
  );
  // The user backend should return a JSON object with the JWT.
  return Response.json({ jwt: token });
}
                    Copy                        Copied
```

Example using Next.js Pages Router:

```typescript
import type { NextApiRequest, NextApiResponse } from "next";
import jwt from "jsonwebtoken";

const user = {
  email: "rene@example.com",
  firstName: "Rene",
  lastName: "Descartes",
  group: "Customer",
};

const METABASE_JWT_SHARED_SECRET = process.env.METABASE_JWT_SHARED_SECRET || "";
const METABASE_INSTANCE_URL = process.env.METABASE_INSTANCE_URL || "";

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse,
) {
  const token = jwt.sign(
    {
      email: user.email,
      first_name: user.firstName,
      last_name: user.lastName,
      groups: [user.group],
      exp: Math.round(Date.now() / 1000) + 60 * 10, // 10 minutes expiration
    },
    // This is the JWT signing secret in your Metabase JWT authentication setting
    METABASE_JWT_SHARED_SECRET,
  );
  // The user backend should return a JSON object with the JWT.
  res.status(200).json({ jwt: token });
}
                    Copy                        Copied
```

#### Handling full app and SDK embeds with the same endpoint

If you have an existing backend endpoint configured for full app embedding and want to use the same endpoint for SDK embedding, you can differentiate between the requests by checking for the `response=json` query parameter that the SDK adds to its requests.

- For SDK requests, you should return a JSON object with the JWT (`{ jwt: string }`).
- For full app embedding requests, you would proceed with the redirect.

Here’s an example of an Express.js endpoint that handles both:

```typescript
import express from "express";
import jwt from "jsonwebtoken";

// Replace this with your Metabase URL
const METABASE_INSTANCE_URL = "YOUR_METABASE_URL_HERE";
// Replace this with the JWT signing secret you generated when enabling
// JWT SSO in your Metabase.
const METABASE_JWT_SHARED_SECRET = "YOUR_SECRET_HERE";

const app = express();

app.get("/sso/metabase", async (req, res) => {
  // This is an example endpoint that can handle both traditional interactive
  // embedding requests and SDK embedding requests.

  // Detect if the request is coming from the SDK by checking for the
  // 'response=json' query parameter added by the SDK.
  const isSdkRequest = req.query.response === "json";

  // Usually, you would grab the user from the current session
  // Here it's hardcoded for demonstration purposes
  // Example:
  // const { user } = req.session;
  const user = {
    email: "rene@example.com",
    firstName: "Rene",
    lastName: "Descartes",
    group: "Customer",
  };

  // Generate the JWT
  const token = jwt.sign(
    {
      email: user.email,
      first_name: user.firstName,
      last_name: user.lastName,
      groups: [user.group],
      exp: Math.round(Date.now() / 1000) + 60 * 10, // 10 minutes expiration
    },
    METABASE_JWT_SHARED_SECRET,
  );

  if (isSdkRequest) {
    // For SDK requests, return a JSON object with the JWT.
    res.status(200).json({ jwt: token });
  } else {
    // For interactive embedding, construct the Metabase SSO URL
    // and redirect the user's browser to it.
    const ssoUrl = \`${METABASE_INSTANCE_URL}/auth/sso?token=true&jwt=${token}\`;
    res.redirect(ssoUrl);
  }
});
                    Copy                        Copied
```

### 3\. Wire your frontend to your new endpoint

Update the config in your frontend code to point to your backend’s authentication endpoint.

```js
const authConfig = defineMetabaseAuthConfig({
  metabaseInstanceUrl: "https://your-metabase.example.com", // Required: Your Metabase instance URL
});
                    Copy                        Copied
```

(Optional) If you use headers instead of cookies to authenticate calls from your frontend to your backend, you’ll need to use a [custom fetch function](https://www.metabase.com/docs/latest/embedding/authentication?utm_source=perplexity#customizing-jwt-authentication).

You can add some middleware in your backend to handle cross-domain requests.

```js
// Middleware

// If your FE application is on a different domain from your BE, you need to enable CORS
// by setting Access-Control-Allow-Credentials to true and Access-Control-Allow-Origin
// to your FE application URL.
//
// Limitation: We currently only support setting one origin in Authorized Origins in Metabase for CORS.
app.use(
  cors({
    credentials: true,
  }),
);

app.use(
  session({
    secret: SESSION_SECRET,
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false },
  }),
);

app.use(express.json());

// routes
app.get("/sso/metabase", metabaseAuthHandler);
app.listen(PORT, () => {
  console.log(\`API running at http://localhost:${PORT}\`);
});
                    Copy                        Copied
```

## Customizing JWT authentication

You can customize how the SDK fetches the request token by specifying the `fetchRequestToken` function with the `defineMetabaseAuthConfig` function:

```typescript
// Pass this configuration to MetabaseProvider.
// Wrap the fetchRequestToken function in useCallback if it has dependencies to prevent re-renders.
const authConfig = defineMetabaseAuthConfig({
  fetchRequestToken: async () => {
    const response = await fetch(
      "https://{{ YOUR_CLIENT_HOST }}/api/metabase/auth",
      {
        method: "GET",
        headers: { Authorization: \`Bearer ${yourToken}\` },
      },
    );

    // The backend should return a JSON object with the shape { jwt: string }
    return await response.json();
  },
  metabaseInstanceUrl: "http://localhost:3000",
});
                    Copy                        Copied
```

The response should be in the form of `{ jwt: "{JWT_TOKEN}" }`

## Setting up SAML SSO

SAML authentication is only available on [Pro](https://www.metabase.com/product/pro?utm_source=perplexity) and [Enterprise](https://www.metabase.com/product/enterprise?utm_source=perplexity) plans (both self-hosted and on Metabase Cloud).

To use SAML single sign-on with modular embedding, you’ll need to set up SAML in both your Metabase and your Identity Provider (IdP). See the docs on [SAML-based authentication](https://www.metabase.com/docs/latest/people-and-groups/authenticating-with-saml?utm_source=perplexity).

Once SAML is configured in Metabase and your IdP, you can configure the SDK to use SAML by setting the `preferredAuthMethod` in your `MetabaseAuthConfig` to `"saml"`:

```typescript
// Pass this configuration to MetabaseProvider.
const authConfig = defineMetabaseAuthConfig({
  metabaseInstanceUrl: "http://localhost:3000",
  preferredAuthMethod: "saml",
});
                    Copy                        Copied
```

Using SAML authentication with modular embedding will typically involve redirecting people to a popup with your Identity Provider’s login page for authentication. After successful authentication, the person will be redirected back to the embedded content.

Due to the nature of redirects and popups involved in the SAML flow, SAML authentication may not work seamlessly in all embedding contexts, particularly within iframes, depending on browser security policies and your IdP’s configuration. We recommend testing auth flows in your target environments.

Unlike JWT authentication, you won’t be able to implement a custom `fetchRequestToken` function on your backend when pairing SAML with modular embedding.

## If both SAML and JWT are enabled, modular embedding will default to SAML

You can override this default behavior to prefer the JWT authentication method by setting `preferredAuthMethod="jwt"` in your authentication config:

```typescript
authConfig: {
  metabaseInstanceUrl: "...",
  preferredAuthMethod: "jwt",
  // other JWT config...
}
                    Copy                        Copied
```

## Getting Metabase authentication status

You can query the Metabase authentication status using the `useMetabaseAuthStatus` hook. This is useful if you want to completely hide Metabase components when the user is not authenticated.

This hook can only be used within components wrapped by `MetabaseProvider`.

```jsx
const auth = useMetabaseAuthStatus();

if (auth?.status === "error") {
  return <div>Failed to authenticate: {auth.error.message}</div>;
}

if (auth?.status === "success") {
  return <InteractiveQuestion questionId={110} />;
}
                    Copy                        Copied
```

## Authenticating locally with API keys

> Modular embedding only supports JWT authentication in production. Authentication with API keys is only supported for local development and evaluation purposes.

For developing locally to try out modular embedding, you can authenticate using an API key.

First, create an [API key](https://www.metabase.com/docs/latest/people-and-groups/api-keys?utm_source=perplexity).

Then you can then use the API key to authenticate with Metabase in your application. All you need to do is include your API key in the config object using the key: `apiKey`.

```typescript
import {
  MetabaseProvider,
  defineMetabaseAuthConfig,
} from "@metabase/embedding-sdk-react";

const authConfigApiKey = defineMetabaseAuthConfig({
  metabaseInstanceUrl: "https://metabase.example.com",
  apiKey: "YOUR_API_KEY",
});

export default function App() {
  return (
    <MetabaseProvider authConfig={authConfigApiKey} className="optional-class">
      Hello World!
    </MetabaseProvider>
  );
}
                    Copy                        Copied
```

## Security warning: each end-user must have their own Metabase account

Each end-user *must* have their own Metabase account.

The problem with having end-users share a Metabase account is that, even if you filter data on the client side via modular embedding, all end-users will still have access to the session token, which they could use to access Metabase directly via the API to get data they’re not supposed to see.

If each end-user has their own Metabase account, however, you can configure permissions in Metabase and everyone will only have access to the data they should.

In addition to this, we consider shared accounts to be unfair usage. Fair usage of modular embedding involves giving each end-user of the embedded analytics their own Metabase account.

## Upgrade guide for JWT SSO setups on SDK version 54 or below

If you’re upgrading from an SDK version 1.54.x or below and you’re using JWT SSO, you’ll need to make the following changes.

**Frontend changes**:

- [Remove `authProviderUri` from all `defineMetabaseAuthConfig` calls](https://www.metabase.com/docs/latest/embedding/authentication?utm_source=perplexity#remove-authprovideruri-from-your-auth-config)
- **If using custom `fetchRequestToken`:** [Update function signature and hardcode authentication endpoint URLs](https://www.metabase.com/docs/latest/embedding/authentication?utm_source=perplexity#update-the-fetchrequesttoken-function-signature)

**Backend changes**:

- [Update backend endpoint to return `{ jwt: "token" }` JSON response for SDK requests](https://www.metabase.com/docs/latest/embedding/authentication?utm_source=perplexity#update-your-jwt-endpoint-to-handle-sdk-requests).

Additionally, if you have SAML set up, but you’d prefer to use JWT SSO, you’ll need to set a [preferred authentication method](https://www.metabase.com/docs/latest/embedding/authentication?utm_source=perplexity#if-both-saml-and-jwt-are-enabled-modular-embedding-will-default-to-saml).

### Remove authProviderUri from your auth config

`defineMetabaseAuthConfig` no longer accepts an `authProviderUri` parameter, so you’ll need to remove it.

**Admin setting changes in Metabase**:

In **Admin** > **Authentication** > **JWT SSO**, set the `JWT Identity Provider URI` to the URL of your JWT SSO endpoint, e.g., `http://localhost:9090/sso/metabase`.

**Before:**

```jsx
const authConfig = defineMetabaseAuthConfig({
  metabaseInstanceUrl: "https://your-metabase.example.com",
  authProviderUri: "http://localhost:9090/sso/metabase", // Remove this line
});
                    Copy                        Copied
```

**After:**

```jsx
const authConfig = defineMetabaseAuthConfig({
  metabaseInstanceUrl: "https://your-metabase.example.com",
});
                    Copy                        Copied
```

The SDK now uses the JWT Identity Provider URI setting configured in your Metabase Admin (Admin > Settings > Authentication > JWT).

### Update the fetchRequestToken function signature

The `fetchRequestToken` function no longer receives a URL parameter. You must now specify your authentication endpoint directly in the function.

**Before:**

```jsx
const authConfig = defineMetabaseAuthConfig({
  fetchRequestToken: async (url) => {
    // Remove url parameter
    const response = await fetch(url, {
      method: "GET",
      headers: { Authorization: \`Bearer ${yourToken}\` },
    });
    return await response.json();
  },
  metabaseInstanceUrl: "http://localhost:3000",
  authProviderUri: "http://localhost:9090/sso/metabase", // Remove this line
});
                    Copy                        Copied
```

**After:**

```jsx
const authConfig = defineMetabaseAuthConfig({
  fetchRequestToken: async () => {
    // No parameters
    const response = await fetch("http://localhost:9090/sso/metabase", {
      // Hardcode your endpoint URL
      method: "GET",
      headers: { Authorization: \`Bearer ${yourToken}\` },
    });
    return await response.json();
  },
  metabaseInstanceUrl: "http://localhost:3000",
});
                    Copy                        Copied
```

### Update your JWT endpoint to handle SDK requests

Your JWT endpoint must now handle both SDK requests and full app embedding requests. The SDK adds a `response=json` query parameter to distinguish its requests. For SDK requests, return a JSON object with the JWT. For full app embedding, continue redirecting as before.

If you were using a custom `fetchRequestToken`, you’ll need to update the endpoint to detect `req.query.response === "json"` for SDK requests.

```jsx
app.get("/sso/metabase", async (req, res) => {
  // SDK requests include 'response=json' query parameter
  const isSdkRequest = req.query.response === "json";

  const user = getCurrentUser(req);

  const token = jwt.sign(
    {
      email: user.email,
      first_name: user.firstName,
      last_name: user.lastName,
      groups: [user.group],
      exp: Math.round(Date.now() / 1000) + 60 * 10,
    },
    METABASE_JWT_SHARED_SECRET,
  );

  if (isSdkRequest) {
    // For SDK requests, return JSON object with jwt property
    res.status(200).json({ jwt: token });
  } else {
    // For full app embedding, redirect as before
    const ssoUrl = \`${METABASE_INSTANCE_URL}/auth/sso?token=true&jwt=${token}\`;
    res.redirect(ssoUrl);
  }
});
                    Copy                        Copied
```

## Embedding Metabase in a different domain

Authenticated modular embeds are only available on [Pro](https://store.metabase.com/checkout/embedding?utm_source=perplexity) and [Enterprise](https://www.metabase.com/product/enterprise?utm_source=perplexity) plans (both self-hosted and on Metabase Cloud).

This section applies only to **authenticated embeds**. Guest embeds work cross-domain without additional configuration.

If you want to embed Metabase in another domain (say, if Metabase is hosted at `metabase.yourcompany.com`, but you want to embed Metabase at `yourcompany.github.io`), you’ll need to [allow your domain in CORS](https://www.metabase.com/docs/latest/embedding/authentication?utm_source=perplexity#allow-your-domain-in-cors).

### Allow your domain in CORS

Go to **Admin** > **Embedding** > **Modular embedding** and add your embedding domain under **Cross-Origin Resource Sharing (CORS)** (such as `https://*.example.com`).

### Configure session cookies when testing locally

When you use `useExistingUserSession: true` during development on a different domain, the browser must send the existing Metabase session cookie cross-origin into the iframe. To allow this, you’ll need to set the session cookie’s SameSite value to “none”.

You can set session cookie’s SameSite value in **Admin** > **Embedding** > **Security** > **SameSite cookie setting**.

SameSite values include:

- **Lax** (default): Allows Metabase session cookies to be shared on the same domain. Used for production instances on the same domain.
- **None (requires HTTPS)**: Use “None” when your app and Metabase are hosted on different domains. Incompatible with Safari and iOS-based browsers.
- **Strict** (not recommended): Does not allow Metabase session cookies to be shared with embedded instances. Use this if you do not want to enable session sharing with embedding.

You can also set the [`MB_SESSION_COOKIE_SAMESITE` environment variable](https://www.metabase.com/docs/latest/configuring-metabase/environment-variables?utm_source=perplexity#mb_session_cookie_samesite).

If you’re using Safari, you’ll need to [allow cross-site tracking](https://support.apple.com/en-tj/guide/safari/sfri40732/mac?utm_source=perplexity). Depending on the browser, you may also run into issues when viewing embedded items in private/incognito tabs.

Learn more about [SameSite cookies](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie/SameSite?utm_source=perplexity).

Read docs for other [versions of Metabase](https://www.metabase.com/docs/all?utm_source=perplexity).
