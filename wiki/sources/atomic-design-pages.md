---
description: "Atomic Design: Pages are template instances with content"
tags: [software-engineering, atomic-design, react, components]
sources: [Pages.md]
created: 2026-04-09
updated: 2026-04-09
---

# Atomic Design: Pages

**Source:** raw/02_reference/software-engineer/frontend/Patterns/Pages.md
**Date ingested:** 2026-04-09
**Type:** technical reference

## Summary

Pages are specific instances of templates populated with real content. They represent what users actually see and interact with, handling data fetching, routing, and business logic.

## Key Claims

- Pages are specific instances of [[templates]]
- Contain real content
- Handle data fetching
- Manage route-level state
- Implement business logic
- Multiple pages can use the same template

## Common Page Patterns

### Dashboard Page
- User-specific data fetching
- React Query for server state
- Refresh and cache invalidation

### Product List Page
- URL-based filters and sorting
- Redux for filter state
- Pagination with query params

### User Profile Page
- Route parameters for user ID
- Form handling with react-hook-form
- Tabbed content sections

### Authentication Page
- Login/Signup mode switching
- Form validation with Yup
- Social authentication

## Data Fetching Patterns

### React Query
```javascript
const { data, isLoading } = useQuery(
  ['dashboard', user.id],
  () => fetchDashboardData(user.id),
  { staleTime: 5 * 60 * 1000, refetchOnWindowFocus: true }
);
```

### Custom Hooks
```javascript
function usePageData(pageId) {
  const queryClient = useQueryClient();
  const { data, isLoading } = useQuery(
    ['page', pageId],
    () => fetchPageData(pageId),
    { staleTime: 60000, retry: 3 }
  );
  return { data, isLoading };
}
```

## SEO Management

```javascript
function SEO({ title, description, image }) {
  return (
    <Head>
      <title>{title}</title>
      <meta name="description" content={description} />
      <meta property="og:title" content={title} />
      <meta property="og:description" content={description} />
      {image && <meta property="og:image" content={image} />}
    </Head>
  );
}
```

## Best Practices

- Implement proper error boundaries
- Handle loading states
- Manage SEO metadata
- Implement analytics
- Handle permissions/authentication
- Optimize performance
- Implement proper routing
- Handle form validation
- Cache data appropriately
- Handle offline functionality

## Concepts Covered

- [[atomic-design]]
- [[react-components]]
- [[data-fetching]]
- [[routing]]
- [[seo]]
