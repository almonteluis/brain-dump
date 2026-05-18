---
description: Learnosity platform access guide — consoles, keys, permissions, and security practices
tags: [source, learnosity, access-control, security, work, product]
created: 2026-04-30
updated: 2026-04-30
sources: ["Learnosity Access - PRODUCT.md"]
---

# Learnosity Access

Source: [Confluence — Learnosity Access](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/43057209/Learnosity+Access)

## Overview

Access to Learnosity is organized through three main interfaces: the Author Console, the Learnosity Console, and Support. Programmatic access is managed via consumers and API keys with strict security requirements.

## Author Console

[https://author.learnosity.com/](https://author.learnosity.com/)

Used by the content team to manage Learnosity content: items, questions, activities, tags. Student session data is **not** available here.

- Access managed through Service Desk request
- Users can be restricted to specific item banks
- Coarse-grained permissions (tags, bulk updates)
- Developers should generally **not** have production item bank access

## Learnosity Console

[https://console.learnosity.com/](https://console.learnosity.com/)

Manages users, API keys (consumers), item banks, author site settings. Almost nobody outside IT should need access.

- Weird permissions system with checkboxes corresponding to roles
- No user groups with predefined permissions
- Grant minimum permissions necessary

## Support

[https://help.learnosity.com/hc/en-us](https://help.learnosity.com/hc/en-us)

Separate account from author/console. Only a handful of people have direct access. Contact Service Desk for account creation.

## Programmatic Access

### Key Rules

1. **One key, one purpose** — no sharing, no personal keys in shared environments, no production keys for testing
2. **Keys and secrets are both secret** — load from environment or secret manager; never hardcode or commit
3. **Manage lifecycle** — destroy unused keys; cycle leaked keys
4. **Learnosity keys are bad** — cannot be easily revoked; every key has complete control over associated item banks; no audit trail; readable in console for their entire lifetime

### Consumer Organization

Access is organized by *consumer*. Consumers can only be added/deleted via Learnosity support request and cost thousands annually.

Each consumer has:
- Name, type (Production / Testing), status
- Allowed domains list (wildcard support — avoid right-side wildcards)
- Primary item bank + linked item banks (read-write or read-only)
- API options (CSS, session timeout)
- Authentication keys (label + key + secret)
- Session information database (unique per consumer — **production consumer only in production**)

Current consumers:
- `newclassroom` (Production) — `*.teachtoone.org`, `localhost`
- `newclassroomsdev` (Testing/QA/Staging) — `*.ttoroadmaps.dev`, `localhost`

### Key Naming Conventions

- **Individual users**: NC username (portion before `@newclassrooms.org`)
- **Services**: `service-{environment}-{service-name}` (e.g., `service-demo-bff`)

### AWS Secrets Manager Example

```bash
aws --profile nc_scratch secretsmanager create-secret \
    --tags "Key=nc:Owner,Value=Tech Engineering" "Key=nc:Product,Value=BFF" \
           "Key=nc:Environment,Value=Development" "Key=nc:Unmanaged,Value=true" \
    --name bff-learnosity-key-test-us-east-1-scratch --secret-string "..."
```

### Domain Verification

The domain verification system works mostly on the honor system. The SDK uses `location.hostname`, but the value can be edited. So long as the frontend and backend use matching values, the request is accepted regardless of actual origin. Not considered a security risk but is security theater.

## Related

- [[learnosity]] — Learnosity entity overview
- [[learnosity-swap-out-notes-product]] — Migration planning
- [[bff-learnosity-bridge]] — BFF proxy service
- [[learnosity-result-fetcher]] — Lambda for result retrieval
