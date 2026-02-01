---
description: React Server Components (RSC) - Server-side rendering with component-level granular control, Server Actions for mutations, and modern patterns for Next.js 14+
tags: [react, rsc, nextjs, server-components, server-actions, rendering, performance]
---

# React Server Components (RSC)

React Server Components allow you to render components on the server and stream HTML to the client, reducing bundle size and improving performance by keeping heavy logic server-side.

## Core Concepts

### What are Server Components?

Server Components:
- Render **only on the server** - no JavaScript sent to client
- Can directly access backend resources (databases, APIs, file system)
- Zero bundle size impact on client
- Cannot use hooks, event handlers, or browser APIs
- Default in Next.js App Router (`.js`/`.ts` files)

Client Components:
- Render in the browser (can also pre-render on server)
- Use `use client` directive
- Can use hooks, event handlers, browser APIs
- Include JavaScript in bundle
- Use `.client.js`/`.client.ts` in App Router for clarity

### The `use client` Directive

```tsx
// ✅ Server Component (default)
import { Button } from './button.client';

export default async function PostList() {
  // Direct database access - only in Server Components!
  const posts = await db.post.findMany();

  return (
    <div>
      {posts.map(post => (
        <article key={post.id}>
          <h2>{post.title}</h2>
          <p>{post.content}</p>
          <Button onClick={() => alert('Hi!')}>
            Like Post
          </Button>
        </article>
      ))}
    </div>
  );
}

// ✅ Client Component
'use client';

import { useState } from 'react';

export function Button({ children, onClick }: ButtonProps) {
  const [count, setCount] = useState(0);

  return (
    <button
      onClick={() => {
        onClick();
        setCount(c => c + 1);
      }}
    >
      {children} ({count} likes)
    </button>
  );
}
```

## Server Actions

Server Actions allow you to run server-side code from client-side events without creating API routes.

### Basic Server Action

```tsx
// app/actions.ts
'use server';

import { revalidatePath } from 'next/cache';
import { db } from '@/lib/db';
import { redirect } from 'next/navigation';

export async function createPost(formData: FormData) {
  // Server-side validation
  const title = formData.get('title') as string;
  const content = formData.get('content') as string;

  if (!title || title.length > 100) {
    throw new Error('Invalid title');
  }

  // Direct database mutation
  const post = await db.post.create({
    data: { title, content }
  });

  // Revalidate cache
  revalidatePath('/posts');
  redirect(`/posts/${post.id}`);
}
```

### Using Server Actions in Forms

```tsx
// app/posts/new/page.tsx
import { createPost } from '../actions';

export default function NewPostPage() {
  return (
    <form action={createPost}>
      <input
        name="title"
        placeholder="Post title"
        required
        maxLength={100}
      />
      <textarea
        name="content"
        placeholder="Write your post..."
        required
      />
      <button type="submit">Create Post</button>
    </form>
  );
}
```

### Server Actions with Progressively Enhanced Forms

```tsx
// app/components/post-form.tsx
'use client';

import { useFormState, useFormStatus } from 'react-dom';
import { createPost } from '../actions';

function SubmitButton() {
  const { pending } = useFormStatus();

  return (
    <button disabled={pending} type="submit">
      {pending ? 'Creating...' : 'Create Post'}
    </button>
  );
}

const initialState = {
  message: '',
  success: false
};

export function PostForm() {
  const [state, formAction] = useFormState(createPost, initialState);

  return (
    <form action={formAction}>
      {state.message && (
        <div className={state.success ? 'success' : 'error'}>
          {state.message}
        </div>
      )}

      <input name="title" placeholder="Title" required />
      <textarea name="content" required />
      <SubmitButton />
    </form>
  );
}
```

## Patterns

### Composition Pattern: Server + Client Components

```tsx
// app/dashboard/posts/page.tsx (Server Component)
import { PostList } from './post-list';
import { PostFilters } from './post-filters.client';

export default async function PostsPage({
  searchParams
}: {
  searchParams: { q?: string; tag?: string };
}) {
  const posts = await db.post.findMany({
    where: {
      title: { contains: searchParams.q },
      tags: searchParams.tag ? { has: searchParams.tag } : undefined
    }
  });

  return (
    <div>
      <PostFilters /> {/* Client Component for interactivity */}
      <PostList posts={posts} /> {/* Server Component for rendering */}
    </div>
  );
}
```

### Server Components as Data Providers

```tsx
// app/components/post-provider.tsx
export async function PostProvider({
  postId,
  children
}: {
  postId: string;
  children: (data: Post) => React.ReactNode;
}) {
  const post = await db.post.findUnique({
    where: { id: postId },
    include: { author: true, comments: true }
  });

  if (!post) return <PostNotFound />;

  return <>{children(post)}</>;
}

// Usage
<PostProvider postId="123">
  {(post) => (
    <PostDetail post={post} />
  )}
</PostProvider>
```

### Streaming Suspense Boundaries

```tsx
// app/dashboard/page.tsx
import { Suspense } from 'react';

export default async function Dashboard() {
  return (
    <div className="dashboard">
      <header>
        <UserNav /> {/* Fast - renders immediately */}
      </header>

      <main>
        <Suspense fallback={<StatsSkeleton />}>
          <DashboardStats /> {/* Slower - shows loading */}
        </Suspense>

        <Suspense fallback={<PostsSkeleton />}>
          <RecentPosts /> {/* Can load independently */}
        </Suspense>

        <Suspense fallback={<ChartSkeleton />}>
          <AnalyticsChart /> {/* Heaviest - loads last */}
        </Suspense>
      </main>
    </div>
  );
}
```

### Parallel Data Fetching with Server Components

```tsx
// ✅ GOOD: Parallel fetching with Promise.all
export default async function Page({ params }: { params: { id: string } }) {
  const [post, comments, author] = await Promise.all([
    db.post.findUnique({ where: { id: params.id } }),
    db.comment.findMany({ where: { postId: params.id } }),
    db.user.findUnique({ where: { id: post?.authorId } })
  ]);

  return <PostView post={post} comments={comments} author={author} />;
}

// ❌ BAD: Sequential fetching (slower)
export default async function Page({ params }: { params: { id: string } }) {
  const post = await db.post.findUnique({ where: { id: params.id } });
  const comments = await db.comment.findMany({ where: { postId: params.id } });
  const author = await db.user.findUnique({ where: { id: post?.authorId } });

  return <PostView post={post} comments={comments} author={author} />;
}
```

## Server Actions Best Practices

### Type-Safe Server Actions

```tsx
// app/actions/create-post.action.ts
'use server';

import { z } from 'zod';
import { db } from '@/lib/db';
import { auth } from '@/lib/auth';

const CreatePostSchema = z.object({
  title: z.string().min(1).max(100),
  content: z.string().min(10).max(10000),
  tags: z.array(z.string()).optional()
});

type CreatePostInput = z.infer<typeof CreatePostSchema>;

export async function createPostAction(input: CreatePostInput) {
  // Validate input
  const validated = CreatePostSchema.parse(input);

  // Check authentication
  const user = await auth();
  if (!user) throw new Error('Unauthorized');

  // Create post
  const post = await db.post.create({
    data: {
      ...validated,
      authorId: user.id
    }
  });

  // Revalidate relevant paths
  revalidatePath('/');
  revalidatePath('/posts');

  return { success: true, postId: post.id };
}
```

### Optimistic Updates with Server Actions

```tsx
// app/components/post-list.client.tsx
'use client';

import { useOptimistic, startTransition } from 'react';
import { deletePost } from '../actions';

export function PostList({ posts }: { posts: Post[] }) {
  const [optimisticPosts, addOptimisticPost] = useOptimistic(
    posts,
    (state, postIdToDelete) =>
      state.filter(post => post.id !== postIdToDelete)
  );

  async function handleDelete(postId: string) {
    startTransition(async () => {
      addOptimisticPost(postId);
      await deletePost(postId);
    });
  }

  return (
    <ul>
      {optimisticPosts.map(post => (
        <li key={post.id}>
          {post.title}
          <button onClick={() => handleDelete(post.id)}>
            Delete
          </button>
        </li>
      ))}
    </ul>
  );
}
```

## Performance Tips

### Keep Client Components Small

```tsx
// ✅ GOOD: Minimal client component for interactivity
'use client';

export function InteractiveButton() {
  return <button onClick={() => alert('Clicked!')}>Click me</button>;
}

// ❌ BAD: Large client component with unnecessary code
'use client';

import { Header, Footer, Sidebar, MainContent } from './components';

export function AppLayout() {
  return (
    <div>
      <Header />
      <div className="content">
        <Sidebar />
        <MainContent />
      </div>
      <Footer />
    </div>
  );
}
```

### Third-Party Libraries Strategy

```tsx
// ✅ GOOD: Wrap only interactive parts in client components
import { ClientChart } from './chart.client'; // Chart library wrapper

export default async function DashboardPage() {
  const data = await db.analytics.getDailyStats();

  return (
    <div>
      <h1>Analytics Dashboard</h1>
      <ClientChart data={data} /> {/* Only chart is client-side */}
    </div>
  );
}

// chart.client.tsx
'use client';

import { Line } from 'react-chartjs-2';

export function ClientChart({ data }: { data: ChartData }) {
  return <Line data={data} />;
}
```

## Common Patterns

### 1. Server Components for Data, Client for Interaction

```tsx
// app/posts/[id]/page.tsx
import { PostActions } from './post-actions.client';

export default async function PostPage({ params }: { params: { id: string } }) {
  const post = await db.post.findUnique({
    where: { id: params.id }
  });

  if (!post) notFound();

  return (
    <article>
      <h1>{post.title}</h1>
      <p>{post.content}</p>

      {/* Interactive actions in client component */}
      <PostActions postId={post.id} />
    </article>
  );
}
```

### 2. Loading and Error States

```tsx
// app/posts/loading.tsx
export default function Loading() {
  return (
    <div className="posts-container">
      {[1, 2, 3].map(i => (
        <div key={i} className="post-skeleton" />
      ))}
    </div>
  );
}

// app/posts/error.tsx
'use client';

export default function Error({ error, reset }: ErrorProps) {
  return (
    <div className="error">
      <h2>Failed to load posts</h2>
      <p>{error.message}</p>
      <button onClick={() => reset()}>Try again</button>
    </div>
  );
}
```

### 3. Server Components with Route Handlers

```tsx
// app/api/posts/route.ts
import { NextResponse } from 'next/server';
import { db } from '@/lib/db';

export async function GET() {
  const posts = await db.post.findMany();
  return NextResponse.json(posts);
}

// Use in Server Component
export default async function Page() {
  const posts = await db.post.findMany(); // Direct access - faster!
  // OR
  // const res = await fetch('/api/posts'); // If needed for cache control
  // const posts = await res.json();

  return <PostList posts={posts} />;
}
```

## Use Cases

1. **Content-heavy pages** - Blogs, documentation, marketing pages
2. **Data dashboards** - Analytics with server-side aggregation
3. **E-commerce** - Product catalogs, filtering (server), cart (client)
4. **Admin panels** - Table views with server-side pagination/sorting
5. **Search pages** - Server-side search with client-side filters

## When NOT to Use Server Components

- Interactive UI components (modals, dropdowns, accordions)
- Browser API access (localStorage, geolocation, Web Speech API)
- Third-party UI libraries with hooks
- Custom hooks that manage state
- Event handlers (onClick, onChange, etc.)

## See Also

- [[react-concurrent-mode]] - Concurrent features and Suspense
- [[modern-react-hooks]] - useTransition, useOptimistic, useDeferredValue
- [[suspense-deep-dive]] - Suspense boundaries and streaming
- [[error-boundary-patterns]] - Error handling strategies
- [[testing-frameworks-deep-dive]] - Testing Server Components

## Resources

- [Next.js App Router Documentation](https://nextjs.org/docs/app)
- [React Server Components RFC](https://github.com/reactjs/rfcs/blob/main/text/0188-server-components.md)
- [Server Actions Documentation](https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations)
