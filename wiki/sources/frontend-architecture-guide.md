---
description: Frontend architecture documentation for a React 18 + TypeScript + Relay application with environment configuration and security practices
tags: [frontend, react, relay, vite, auth0, sentry, hotjar, security]
sources: [FrontEnd.md]
created: 2026-04-30
updated: 2026-04-30
---

# Frontend Architecture Guide

**Source:** FrontEnd.md
**Date ingested:** 2026-04-30
**Type:** guide

## Summary

Documentation of a production React 18 frontend architecture using TypeScript, Relay for GraphQL, Vite for builds, and CloudFront for CDN distribution. Details environment variable configuration for Auth0, Learnosity BFF, GraphQL service, Unleash feature flags, Sentry logging, and Hotjar session recording. Includes subresource integrity (SRI) implementation for third-party CDN libraries.

## Key Claims

- React 18 UI in TypeScript with Relay client for GraphQL communication
- npm toolchain; served via CloudFront CDN in AWS
- Vite handles environment variables via `import.meta.env` (only `VITE_` prefixed vars pass through)
- GitHub secrets/variables defined at org, repo, and environment levels
- Subresource integrity (SRI) required for third-party CDN libraries (e.g., SpeechStream, Lottie)
- Use `openssl dgst -sha384 -binary | base64` to generate SRI hashes
- Google Fonts cannot implement SRI due to user-agent-specific responses

## Environment Variables

**Required:**
- `VITE_DOMAIN` — Auth0 domain
- `VITE_CLIENT_ID` — Auth0 client ID
- `VITE_BFF_URL` — Backend-for-frontend URL
- `VITE_GRAPHQL_SERVICE_URL` — GraphQL endpoint
- `VITE_UNLEASH_URL` — Feature flag service URL
- `VITE_UNLEASH_CLIENT_KEY` — Feature flag API key

**Optional (Sentry):**
- `VITE_SENTRY_ENABLED`, `VITE_SENTRY_DSN`, `VITE_SENTRY_ENVIRONMENT`, `VITE_RELEASE_VERSION`, etc.

**Optional (Hotjar):**
- `VITE_HOTJAR_SITE_ID`, `VITE_HOTJAR_ENABLED`, `VITE_HOTJAR_DEBUG`

## Entities Mentioned

- [[React]] — UI framework (v18)
- [[Relay]] — GraphQL client
- [[Vite]] — build tool and env variable handler
- [[Auth0]] — single sign-on provider
- [[Learnosity]] — assessment platform
- [[BFF]] — backend-for-frontend
- [[GraphQL Service]] — data API
- [[CMS]] — content management system
- [[Sentry]] — frontend logging
- [[Hotjar]] — session recording
- [[CloudFront]] — AWS CDN
- [[Unleash]] — feature flagging service

## Concepts Covered

- [[frontend-env-configuration]] — Vite env vars, GitHub secrets hierarchy
- [[subresource-integrity]] — SRI hash generation for CDN libraries
- [[relay-graphql-client]] — GraphQL data fetching pattern
- [[feature-flags-frontend]] — Unleash integration for feature toggling
