---
description: "This guide walks you through how to set up the modular embedding SDK in your application with your Metabase."
tags: ['research']
source: "https://www.metabase.com/docs/latest/embedding/sdk/quickstart"
raw_file: "Modular embedding SDK - quickstart.md"
created: 2026-05-17
---

[What’s new](https://www.metabase.com/releases)

This guide walks you through how to set up the Modular embedding SDK in your application with your Metabase using API keys.

This setup:

- Is only for evaluation (so you can see how the SDK works).
- Only works on localhost when developing your app (though your Metabase doesn’t need to be running locally).
- Works with both the Enterprise and Open Source editions of Metabase, both self-hosted and on Metabase Cloud.

If you want to use the SDK in production, however, you’ll also need to [set up JWT SSO authentication](https://www.metabase.com/docs/latest/embedding/authentication), which requires a [Pro](https://store.metabase.com/checkout/embedding) or [Enterprise plan](https://www.metabase.com/pricing/). To enable JWT SSO when you’re self-hosting Metabase, you’ll need to run the Enterprise Edition Docker image or JAR, and [activate your license](https://www.metabase.com/docs/latest/installation-and-operation/activating-the-enterprise-edition).

## Prerequisites

- [Metabase](https://github.com/metabase/metabase/releases) version 52 or higher (OSS or EE). See [Installing Metabase](https://www.metabase.com/docs/latest/installation-and-operation/installing-metabase).
- Make sure your [React version is compatible](https://www.metabase.com/docs/latest/embedding/sdk/introduction#modular-embedding-sdk-prerequisites). (You could also use the [sample React app](https://github.com/metabase/metabase-nodejs-react-sdk-embedding-sample/tree/60-stable).)

If you *don’t* have a Metabase up and running, check out the [Quickstart CLI](https://www.metabase.com/docs/latest/embedding/sdk/quickstart-cli).

If you *don’t* want to use your own application code, check out our [quickstart with a sample app](https://www.metabase.com/docs/latest/embedding/sdk/quickstart-with-sample-app).

## Overview

To embed a dashboard in your app using the SDK, you’ll need to:

1. [Enable the SDK in Metabase](https://www.metabase.com/docs/latest/embedding/sdk/quickstart#1-enable-the-sdk-in-metabase)
2. [Create an API key in Metabase](https://www.metabase.com/docs/latest/embedding/sdk/quickstart#2-create-an-api-key-in-metabase)
3. [Install the SDK in your app](https://www.metabase.com/docs/latest/embedding/sdk/quickstart#3-install-the-sdk-in-your-app)
4. [Embed SDK components in your app](https://www.metabase.com/docs/latest/embedding/sdk/quickstart#4-embed-sdk-components-in-your-app)
5. [View your embedded Metabase dashboard](https://www.metabase.com/docs/latest/embedding/sdk/quickstart#5-view-your-embedded-metabase-dashboard)

## 1\. Enable the SDK in Metabase

In Metabase, click the grid icon in the upper right and navigate to **Admin > Embedding > Modular** and enable the **SDK for React**.

## 2\. Create an API key in Metabase

Still in the Admin console, go to **Settings > Authentication** and click on the **API keys** tab. [Create a new API key](https://www.metabase.com/docs/latest/people-and-groups/api-keys).

- Key name: “Modular embedding SDK” (just to make the key easy to identify).
- Group: select “Admin” (since this is only for local testing).

## 3\. Install the SDK in your app

When installing the npm package, it’s critical to use the npm dist-tag that corresponds to the major version of your Metabase. For example, if your Metabase is version 1.56.x, you’d run `56-stable`. See [SDK versioning](https://www.metabase.com/docs/latest/embedding/sdk/version).

Via npm:

```
npm install @metabase/embedding-sdk-react@53-stable
                    Copy                        Copied
```

Via Yarn:

```
yarn add @metabase/embedding-sdk-react@53-stable
                    Copy                        Copied
```

## 4\. Embed SDK components in your app

In your app, import the SDK components, like so:

```jsx
import {
  InteractiveDashboard,
  MetabaseProvider,
  defineMetabaseAuthConfig,
} from "@metabase/embedding-sdk-react";

/**
 * This creates an auth config to pass to the \`MetabaseProvider\` component.
 * You'll need to replace the \`metabaseInstanceUrl\` and the \`apiKey\` values.
 */
const authConfig = defineMetabaseAuthConfig({
  metabaseInstanceUrl: "https://metabase.example.com",
  apiKey: "YOUR_API_KEY",
});

/**
 * Now embed your first dashboard. In this case, we're embedding the dashboard with ID 1.
 * On new Metabases, ID 1 will be the example dashboard, but feel free to use a different dashboard ID.
 */
export default function App() {
  return (
    <MetabaseProvider authConfig={authConfig}>
      <InteractiveDashboard dashboardId={1} />
    </MetabaseProvider>
  );
}
                    Copy                        Copied
```

## 5\. View your embedded Metabase dashboard

Run your app and visit the page with the embedded dashboard.

![Embedded example dashboard](https://www.metabase.com/docs/latest/embedding/images/embedded-example-dashboard.png)

## Next steps

- Explore [theming to change the look and feel](https://www.metabase.com/docs/latest/embedding/appearance).
- Continue by [setting up JWT SSO in Metabase and your app](https://www.metabase.com/docs/latest/embedding/authentication) to sign people in, manage permissions, and deploy your app in production.

Read docs for other [versions of Metabase](https://www.metabase.com/docs/all).
