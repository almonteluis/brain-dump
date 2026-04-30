---
tags: [bff, dotnet, learnosity, aws-lambda, auth0, work]
sources: ["CLAUDE-backend-for-frontend.md"]
created: 2026-04-29
updated: 2026-04-29
---

# CLAUDE Backend-for-Frontend (BFF) Guide

**Source:** CLAUDE-backend-for-frontend.md
**Date ingested:** 2026-04-29
**Type:** Work documentation

## Summary

Architecture guide for the .NET 6 BFF service bridging the frontend to Learnosity APIs. Deployable to AWS Lambda.

## Architecture

```
Nc.Bff/
├── Controllers/         # REST endpoints (Learnosity auth, events)
├── Helpers/             # Constants, utility functions
├── Models/              # Request/response DTOs
└── Views/               # Razor templates (if any)
```

## Key Patterns

### Learnosity Integration
- `LearnosityApiClient` handles signing, session management
- `ILearnosityService` for business logic layer
- Session security via signature hashing with secret

### Authentication
- JWT Bearer auth via Auth0
- Claims-based authorization (`ClaimTypes.NameIdentifier` required)
- Fallback policy requires authenticated user

### AWS Lambda Support
- `AddAWSLambdaHosting(LambdaEventSource.ApplicationLoadBalancer)`
- Environment via `LambdaApplication.GetEnvironment()`
- Kinesis event streaming for analytics

### CORS
- `BFF_ALLOWED_ORIGIN` env var for production
- Localhost allowed in Development mode

## Environment Variables

```bash
BFF_ACCESS_TOKEN_VALID_AUTHORITY    # Auth0 domain
BFF_ACCESS_TOKEN_VALID_AUDIENCE     # Auth0 API identifier
BFF_ALLOWED_ORIGIN                  # CORS origin
KinesisEventStreamArn               # AWS Kinesis for events
```

## Workflow

```bash
dotnet run                    # Local dev (port varies)
dotnet test ../Nc.Bff.Tests   # Run tests
```

## Concepts Covered

- [[backend-for-frontend]] — API layer tailored to frontend needs
- [[learnosity-integration]] — Assessment platform API signing and sessions
- [[aws-lambda-hosting]] — .NET application deployed to serverless
- [[auth0-jwt]] — JWT bearer authentication with claims
