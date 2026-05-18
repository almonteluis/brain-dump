---
description: Data Colocation — keep data declarations next to where the data is used. Each component owns its data needs. No more prop-drilling through twelve layers.
tags:
  - relay
  - graphql
  - data-colocation
  - architecture
  - concept
created: 2026-04-08
updated: 2026-05-17
sources:
  - "relay-fragment-composition.md"
  - "relay-uselazyload-to-usefragment-migration.md"
---

# Data Colocation

Data colocation says: put the data declaration right next to the code that uses it. Not in some distant parent component that passes props through twelve layers. Not in a centralized query file. *Right there.* In the Relay world, this means your GraphQL fragments live alongside their components — each component says "I need *this* data" and the parent just includes the fragment.

## The Problem It Solves

**Traditional approach (the haystack hunt):**
- Fetch all data at the top of the app
- Prop-drill through a dozen layers
- To change a component's data, rummage through distant parent queries
- Hope nothing else breaks

**Colocated approach:**
- Each component declares its own data needs
- Parent components compose children's fragments and hand them a reference
- Changes are local — tweak a component and the ripple stops there

## In Practice

```tsx
const fragment = graphql`
  fragment UserAvatar_user on User {
    avatarUrl
    name
  }
`;

function UserAvatar({ $ref }) {
  const user = useFragment(fragment, $ref);
  return <img src={user.avatarUrl} alt={user.name} />;
}
```

Fragment + component in the same file. You look at `UserAvatar` and immediately know what data it needs. No mental gymnastics. No archaeology.

## Why It's Worth It

- **Local reasoning** — look at a component, know its data. Done.
- **Independent evolution** — change `UserAvatar` without breaking `UserProfileHeader`
- **Clear boundaries** — each component owns its data requirements
- **Type safety** — Relay generates types from the fragments that sit next to the code

Data colocation is [[progressive-disclosure]] for code organization — you see only the data surface you need, and the rest stays hidden until you drill down. It's also the same principle behind [[context-engineering]]: put the right information in the right place, not everything everywhere.

The open thread: colocation works great for component trees. What about for non-UI code? Services, utilities, shared logic — the "where does this data query live?" question gets messier when there's no component boundary to anchor to. That's where [[backend-for-frontend|BFF]] patterns and [[design-systems|design system]] composition pick up the same thread.

## Related

[[relay]]
[[fragment-composition]]
[[local-reasoning]]
