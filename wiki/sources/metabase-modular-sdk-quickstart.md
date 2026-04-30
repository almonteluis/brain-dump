---
description: Metabase modular embedding SDK setup using API keys for local evaluation and JWT SSO for production
tags: [metabase, embedding, sdk, react, jwt, api-key]
sources: [metabase-notes.md]
created: 2026-04-30
updated: 2026-04-30
---

# Metabase Modular SDK Quickstart

**Source:** metabase-notes.md
**Date ingested:** 2026-04-30
**Type:** guide

## Summary

Notes on setting up Metabase's modular embedding SDK (`@metabase/embedding-sdk-react`) for local evaluation using API keys. Covers prerequisites, SDK enablement, API key creation, npm installation, and basic React component embedding. Notes that JWT SSO is required for production and that React SDK requires Enterprise/Pro plan.

## Key Claims

- SDK requires Metabase v52+ (OSS or EE)
- npm package version must match Metabase major version via dist-tags (e.g., `53-stable`)
- API key auth is evaluation-only and only works on localhost
- Production requires JWT SSO (Pro or Enterprise plan)
- React SDK and modular embedding require Enterprise/Pro level accounts

## Setup Steps

1. **Enable SDK** in Metabase: Admin > Embedding > Modular → enable SDK for React
2. **Create API key**: Admin > Settings > Authentication > API keys tab → create key with Admin group
3. **Install SDK**: `npm install @metabase/embedding-sdk-react@53-stable`
4. **Embed components**:

```jsx
import {
  InteractiveDashboard,
  MetabaseProvider,
  defineMetabaseAuthConfig,
} from "@metabase/embedding-sdk-react";

const authConfig = defineMetabaseAuthConfig({
  metabaseInstanceUrl: "https://metabase.example.com",
  apiKey: "YOUR_API_KEY",
});

export default function App() {
  return (
    <MetabaseProvider authConfig={authConfig}>
      <InteractiveDashboard dashboardId={1} />
    </MetabaseProvider>
  );
}
```

## Next Steps

- Explore theming for look-and-feel customization
- Set up JWT SSO for production deployment

## Entities Mentioned

- [[Metabase]] — BI/dashboard platform
- [[React]] — frontend framework
- [[InteractiveDashboard]] — SDK component for rendering dashboards
- [[MetabaseProvider]] — SDK auth context wrapper

## Concepts Covered

- [[metabase-modular-embedding]] — SDK-based component embedding
- [[api-key-evaluation]] — local-only auth for testing
- [[jwt-sso-production]] — production authentication requirement
