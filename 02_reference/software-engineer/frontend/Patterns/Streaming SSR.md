---
description: Notes about Streaming SSR.
tags: ["new-streaming-ssr-architecture", "usage-with-server-rendering"]
---


---
description: 
tags: ["new-streaming-ssr-architecture", "usage-with-server-rendering"]
---

## Definition
> Streaming Server-Side Rendering (Streaming SSR) is a technique in React that allows you to progressively render and send HTML from the server to the client, enabling faster initial page loads and improved user experience through gradual content delivery.

## Key Points
- Progressive HTML streaming
- Faster Time to First Byte (TTFB)
- Works with Suspense boundaries
- Selective hydration
- SEO-friendly rendering
- Improved Core Web Vitals

## How Streaming SSR Works
### 1. Basic Setup
```javascript
// server.js
import { renderToPipeableStream } from 'react-dom/server';

function handler(request, response) {
  const stream = renderToPipeableStream(<App />, {
    bootstrapScripts: ['/client.js'],
    onShellReady() {
      response.setHeader('content-type', 'text/html');
      stream.pipe(response);
    }
  });
}
```

### 2. Component Structure
```javascript
// App.js
function App() {
  return (
    <html>
      <head>
        <title>Streaming SSR App</title>
      </head>
      <body>
        <Suspense fallback={<NavSkeleton />}>
          <Navigation />
        </Suspense>
        <Suspense fallback={<ContentSkeleton />}>
          <MainContent />
        </Suspense>
      </body>
    </html>
  );
}
```

## Best Practices
1. Structure [[Suspense]] boundaries strategically
2. Implement proper loading states
3. Handle errors appropriately
4. Plan component hierarchy
5. Optimize data fetching
6. Consider hydration order

## Common Patterns

### 1. Shell Content
```javascript
function AppShell() {
  return (
    <html>
      <head>
        <Scripts />
      </head>
      <body>
        <nav>
          <NonSuspendingContent />
        </nav>
        <Suspense fallback={<MainLoader />}>
          <MainContent />
        </Suspense>
      </body>
    </html>
  );
}
```

### 2. Nested Streaming
```javascript
function HomePage() {
  return (
    <Layout>
      <Suspense fallback={<HeaderSkeleton />}>
        <Header />
      </Suspense>
      <Suspense fallback={<ContentSkeleton />}>
        <Content />
        <Suspense fallback={<CommentsSkeleton />}>
          <Comments />
        </Suspense>
      </Suspense>
    </Layout>
  );
}
```

## Visual Diagrams

### 1. Streaming Process
```
[Server] → [Shell HTML] → [Content Chunks] → [Hydration]
    ↓           ↓              ↓                ↓
 Request    Basic Layout    Progressive     Interactive
```

### 2. Component Loading Order
```
Shell (Immediate)
  │
  ├─► Navigation (First Chunk)
  │     └─► Nav Items
  │
  └─► Content (Second Chunk)
        └─► Dynamic Data
            └─► Interactive Elements
```

## Performance Impact
| Feature | Benefit | Measurement |
|---------|---------|-------------|
| TTFB | 30-50% faster | Server Response |
| FCP | Improved by ~40% | First Content |
| TTI | Better by ~25% | Interactivity |

## Error Handling
```javascript
// Server-side error boundary
function ServerErrorBoundary({ children }) {
  return (
    <ErrorBoundary
      fallback={<div>Something went wrong</div>}
      onError={(error) => {
        console.error('Server Error:', error);
      }}
    >
      {children}
    </ErrorBoundary>
  );
}
```

## Implementation Guide

### 1. Server Setup (Node.js/Express)
```javascript
import express from 'express';
import { renderToPipeableStream } from 'react-dom/server';

const app = express();

app.get('*', (req, res) => {
  const stream = renderToPipeableStream(
    <App />,
    {
      bootstrapScripts: ['/client.js'],
      onShellReady() {
        res.setHeader('content-type', 'text/html');
        stream.pipe(res);
      },
      onError(error) {
        console.error(error);
        res.status(500).send('Server Error');
      }
    }
  );
});
```

### 2. Client Hydration
```javascript
// client.js
import { hydrateRoot } from 'react-dom/client';

hydrateRoot(
  document,
  <App />
);
```

## Common Pitfalls
```javascript
// ❌ Incorrect: Blocking data fetching
async function BlockingComponent() {
  const data = await fetchData(); // Blocks streaming
  return <div>{data}</div>;
}

// ✅ Correct: Suspense-wrapped data fetching
function NonBlockingComponent() {
  return (
    <Suspense fallback={<Loading />}>
      <AsyncComponent />
    </Suspense>
  );
}
```

## Understanding Checklist
- [ ] I understand streaming SSR flow
- [ ] I can implement basic streaming
- [ ] I know how to handle errors
- [ ] I can structure Suspense boundaries
- [ ] I understand selective hydration

## Summary
- Improves initial page load
- Enables progressive rendering
- Better user experience
- SEO-friendly approach
- Works with React 18+
- Requires proper Suspense usage

## Resources
- [React Docs - Streaming SSR](https://react.dev/reference/react-dom/server/renderToPipeableStream)
- [React 18 - SSR](https://react.dev/blog/2022/03/29/react-v18#new-streaming-ssr-architecture)
- [Using Suspense with SSR](https://react.dev/reference/react/Suspense#usage-with-server-rendering)
