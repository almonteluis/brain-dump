---
description: "Atomic Design: Templates are page-level layouts"
tags: [software-engineering, atomic-design, react, components]
sources: [Templates.md]
created: 2026-04-09
updated: 2026-04-09
---

# Atomic Design: Templates

**Source:** raw/02_reference/software-engineer/frontend/Patterns/Templates.md
**Date ingested:** 2026-04-09
**Type:** technical reference

## Summary

Templates define page layouts and content structure. They combine multiple organisms into cohesive layouts without real content, establishing spatial relationships and responsive behavior.

## Key Claims

- Templates define layout structure
- Combine multiple [[organisms]]
- Handle page-level state
- Define content placement areas
- Manage responsive layouts
- No real content (placeholder/skeleton)

## Common Template Patterns

### Dashboard Template
- Sidebar + Header + Content area
- Layout state management (sidebar open/closed)

### Admin Panel Template
- Header + Sidebar navigation + Main content
- Section-based navigation

### E-commerce Template
- Shop header + Filter sidebar + Product grid + Footer
- Cart and wishlist integration

### Authentication Template
- Centered auth form with mode switching
- Login/Signup state management

## State Management Approaches

### Context API
```javascript
const DashboardContext = createContext();
function DashboardProvider({ children }) {
  const [state, dispatch] = useReducer(dashboardReducer, {
    sidebarOpen: true,
    currentView: 'grid',
    filters: {}
  });
  return (
    <DashboardContext.Provider value={{ state, dispatch }}>
      {children}
    </DashboardContext.Provider>
  );
}
```

### Redux Toolkit
```javascript
const adminSlice = createSlice({
  name: 'admin',
  initialState: { activeSection: 'users', permissions: [] },
  reducers: { setActiveSection: (state, action) => { ... } }
});
```

### Zustand
```javascript
const useStore = create((set) => ({
  cart: [],
  filters: {},
  addToCart: (item) => set((state) => ({ cart: [...state.cart, item] }))
}));
```

## Best Practices

- Keep templates focused on layout
- Handle responsive behavior
- Implement proper state management
- Handle loading and error states
- Use proper TypeScript types
- Consider [[code-splitting]]
- Optimize for reusability

## Concepts Covered

- [[atomic-design]]
- [[react-components]]
- [[state-management]]
- [[layout-patterns]]
