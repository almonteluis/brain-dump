---
description: Metabase modular embedding SDK quickstart for embedding dashboards in React applications via API keys and JWT SSO
tags: ["metabase", "embedding", "sdk", "react"]
sources: ["Modular embedding SDK - quickstart.md"]
created: 2026-04-16
updated: 2026-04-16
---

# Metabase Embedding SDK

**Source:** [[Modular embedding SDK - quickstart]]
**Date ingested:** 2026-04-16
**Type:** guide

## Summary

Metabase provides a modular embedding SDK (`@metabase/embedding-sdk-react`) for embedding interactive dashboards directly into React applications. The quickstart covers evaluation setup using API keys (localhost only), with JWT SSO required for production deployments. The SDK requires Metabase v52+ and a compatible React version, with npm dist-tags matching your Metabase major version (e.g., `53-stable` for v1.56.x).

## Key Claims

- SDK supports both Enterprise and Open Source editions (self-hosted or Metabase Cloud)
- API key setup is for evaluation only; production requires JWT SSO (Pro or Enterprise plan)
- npm package version must match Metabase major version via dist-tags
- Core components: `MetabaseProvider` (auth config) and `InteractiveDashboard` (dashboard rendering)
- JWT SSO requires Enterprise Edition Docker image or JAR with an active license

## Concepts Covered

- [[metabase-embedding]] — Embedding dashboards in React via SDK components
- [[api-key-auth]] — Evaluation-only authentication via Metabase API keys
- [[jwt-sso]] — Production authentication for embedded Metabase instances
- [[interactive-dashboard]] — SDK component for rendering Metabase dashboards

## Setup Pattern

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

## Resources

- Original: https://www.metabase.com/docs/latest/embedding/sdk/quickstart
- JWT SSO setup: https://www.metabase.com/docs/latest/embedding/authentication
- Sample app: https://github.com/metabase/metabase-nodejs-react-sdk-embedding-sample/tree/59-stable
