---
description: Marvin frontend architecture — React 18, TypeScript, Relay, Vite, environment configuration, and security patterns
tags: ["marvin", "frontend", "react", "relay", "vite", "auth0", "sentry"]
created: 2026-04-30
updated: 2026-04-30
sources: ["Front End - Marvin.md"]
---

## Marvin Frontend

Primary interface for teachers, students, and administrators.

### Technology Stack

- **Framework:** [[react-patterns|React]] 18 with TypeScript
- **GraphQL Client:** [[relay]]
- **Build Tool:** [[vite]] (via `npm run` locally, CloudFront CDN in AWS)
- **Package Manager:** npm

### Connections

- [[graphql-service]] — reads and writes data via Relay
- [[learnosity]] — assessments and diagnostics via the BFF
- [[bff-learnosity-bridge|BFF]] — Learnosity data funnel
- [[auth0]] — single sign-on
- [[strapi-cms|CMS]] — UI content
- [[sentry]] — frontend error logging
- Hotjar — user session recording

### Environment Configuration

Vite handles environment variables via `import.meta.env`. Only variables prefixed with `VITE_` are passed through.

**Required variables:**

| Variable | Purpose |
|----------|---------|
| `VITE_DOMAIN` | Auth0 tenant domain |
| `VITE_CLIENT_ID` | Auth0 application client ID |
| `VITE_BFF_URL` | Backend-for-Frontend endpoint |
| `VITE_GRAPHQL_SERVICE_URL` | GraphQL service endpoint |
| `VITE_UNLEASH_URL` | Feature flag service URL |
| `VITE_UNLEASH_CLIENT_KEY` | Feature flag API key |

**Optional (Sentry):** `VITE_SENTRY_ENABLED`, `VITE_SENTRY_DSN`, `VITE_SENTRY_ENVIRONMENT`, `VITE_RELEASE_VERSION`, etc.

**Optional (Hotjar):** `VITE_HOTJAR_SITE_ID`, `VITE_HOTJAR_ENABLED`, `VITE_HOTJAR_DEBUG`

### Security

#### Subresource Integrity (SRI)

Third-party CDN libraries include an integrity hash so the browser can verify the loaded library matches expectations.

Generate a hash with openssl:

```bash
wget -q 'https://unpkg.com/@lottiefiles/lottie-player@2.0.8/dist/lottie-player.js' -O - | openssl dgst -sha384 -binary | base64
```

Prefix the hash with the algorithm in the `integrity` attribute:

```html
<script src="https://unpkg.com/@lottiefiles..."
  integrity="sha384-<hash>"
  crossorigin />
```

Note: Google Fonts cannot use SRI (returns different fonts per user agent).

### See Also

- [[marvin-architecture]] — System-wide architecture overview
- [[relay]] — Relay GraphQL client patterns
- [[vite]] — Vite build tool
- [[auth0]] — Authentication platform
- [[unleash-feature-flags]] — Feature flag management
