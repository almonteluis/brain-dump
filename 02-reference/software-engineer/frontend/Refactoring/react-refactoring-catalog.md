---
description: This catalog of 69 React refactoring operations from 320 commits provides practitioners with documented patterns for improving maintainability in React applications through component extraction, hook migration, and state management transformations.
tags: [react, refactoring, frontend, patterns, hooks, components, state-management, code-quality, maintainability, best-practices]
---

# Refactoring React-based Web Apps

Catalog of React refactorings from an empirical study of 320 refactoring commits in open source projects.

## Overview

This catalog proposes **69 distinct refactoring operations** classified into four major categories:

| Category | Number of Refactorings | Occurrences |
|----------|------------------------|-------------|
| **React-specific refactorings** | 25 | 134 |
| **React-adapted refactorings** | 17 | 214 |
| **Traditional refactorings** | 22 | 192 |
| **JavaScript-specific refactorings** | 6 | 22 |

---

## React-specific Refactorings (25 operations)

These are novel refactorings that only occur in React code.

### Extract Logic to a Custom Hook (47 occurrences)

**Problem:** Logic dealing with state becomes duplicated across components.

**Solution:** Eliminate duplicated logic by extracting it to a custom hook (function starting with `use`).

**Example:**
```javascript
// Custom hook
function useLoadGeoJson(geoJson) {
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Load geolocation data
    setLoading(false);
  }, [geoJson]);

  return { loading };
}

// Component using hook
function GeneralSettings() {
  const { loading } = useLoadGeoJson(geoJson);
  // ...
}
```

**Benefits:** Custom hooks improve reusability since the same code across multiple components is implemented in a single function.

---

### Migrate Class Component to Function Component (33 occurrences)

**Problem:** Class components are deprecated; React docs recommend function components.

**Solution:** Convert class component to function component using hooks.

**Example:**
```javascript
// Before (Class)
class CreateUserDialog extends React.Component {
  constructor(props) {
    super(props);
    this.state = { name: '' };
  }

  componentDidMount() {
    // Load data
  }

  render() {
    return <div>{this.state.name}</div>;
  }
}

// After (Function)
function CreateUserDialog({ initialName }) {
  const [name, setName] = useState(initialName);

  useEffect(() => {
    // Load data
  }, []);

  return <div>{name}</div>;
}
```

**Steps:**
1. Change class to function
2. Remove render method
3. Remove references to `this`
4. Replace constructor + state with `useState` hook
5. Replace lifecycle methods with `useEffect` hook

**Benefits:** Function components are simpler, less verbose, easier to read, write, reuse, and test.

---

### Other React-specific Refactorings

| Refactoring | Occurrences | Projects |
|-------------|-------------|----------|
| Migrate Angular to React Component | 7 | 2 |
| Replace Third-party Component with Own Component | 5 | 2 |
| Extract Conditional in Render | 4 | 2 |
| Remove Props in Initial State | 4 | 4 |
| Migrate to Styled Component | 4 | 2 |
| Memoize Component | 3 | 3 |
| Extract Higher-Order Component (HOC) | 3 | 2 |
| Remove Direct DOM Manipulation | 3 | 2 |
| Replace Access State in setState with Callbacks | 3 | 2 |
| Replace Direct Mutation of State with setState() | 3 | 1 |
| Replace Logic to Hook | 2 | 1 |
| Remove forceUpdate() | 2 | 1 |

---

## React-adapted Refactorings (17 operations)

Adaptations of traditional refactorings for React context.

### Extract Component (76 occurrences) - Similar to Extract Class

**Problem:** Component elements replicated across multiple components, causing code duplication.

**Solution:** Move duplicated code to a separate component.

**Benefits:** Promotes reusability, enhances readability, simplifies maintenance.

---

### Rename Component (30 occurrences) - Similar to Rename Class

**Problem:** Component name doesn't represent its purpose well.

**Solution:** Rename the component.

**Benefits:** Code readability.

---

### Move Component (24 occurrences) - Similar to Move Class

**Problem:** Component used more in another file than its own file.

**Solution:** Move component where it's most used.

**Benefits:** Centralizes component where predominantly used, enhances organization.

---

### Remove Unused Props (24 occurrences) - Similar to Remove Unused Parameter

**Problem:** Unused props clutter codebase, making it harder to understand.

**Solution:** Eliminate unused props.

**Benefits:** Improved code clarity and maintenance.

---

### Rename Prop (12 occurrences) - Similar to Rename Field

**Problem:** Prop name doesn't represent its purpose well.

**Solution:** Rename the prop.

**Benefits:** Code readability.

---

### Other React-adapted Refactorings

| Refactoring | Similar To | Occurrences | Projects |
|-------------|------------|-------------|----------|
| Split Component | Extract Class | 9 | 4 |
| Move Hook | Move Method | 8 | 2 |
| Extract HTML/JS Code to Component | Extract Class | 7 | 4 |
| Extract JSX Outside Render Method to Component | Extract Class | 6 | 5 |
| Rename Hook | Rename Method | 6 | 3 |
| Combine Components into One | Combine Functions into Class | 3 | 3 |
| Remove Unused State | Remove Unused Field | 3 | 2 |
| Rename State | Rename Variable | 2 | 1 |

---

## JavaScript Refactorings (6 operations)

Refactorings specific to JavaScript/CSS code.

| Refactoring | Type | Occurrences | Projects |
|-------------|------|-------------|----------|
| Convert JS Code to TypeScript | JS | 13 | 5 |
| Migrate Function to Arrow Function Syntax | JS | 4 | 2 |
| Replace Promises with useCallback | JS | 1 | 1 |
| Replace EOL to Semicolon Format | JS | 1 | 1 |
| Rename CSS Class | CSS | 2 | 2 |
| Extract Stylesheet | CSS | 1 | 1 |

---

## Traditional Refactorings (22 operations)

Documented in Fowler's catalog, adapted for React codebases.

| Refactoring | Occurrences | Projects |
|-------------|-------------|----------|
| Dead Code Elimination | 83 | 9 |
| Move Function | 20 | 6 |
| Extract Function | 16 | 5 |
| Rename Function | 13 | 3 |
| Consolidate Conditional Expression | 11 | 5 |
| Duplicated Code Elimination | 7 | 4 |
| Rename Method | 6 | 4 |
| Rename Variable | 6 | 3 |
| Extract Method | 4 | 3 |
| Rename Type | 4 | 2 |
| Rename Parameter | 4 | 2 |
| Move File | 3 | 3 |
| Rename File | 3 | 2 |
| Rename Object Fields | 2 | 2 |
| Move Type Definition | 2 | 1 |
| Replace Magic Literal | 2 | 2 |
| Merge Methods | 1 | 1 |
| Move Method | 1 | 1 |
| Rename Interface | 1 | 1 |
| Encapsulate Fields in Object | 1 | 1 |
| Replace Custom Logic with External Lib | 1 | 1 |
| Use Composition Instead of Inheritance | 1 | 1 |

---

## Key Takeaways

### Most Common Refactorings

1. **Extract Component** (76) - The most common React-specific operation
2. **Rename Component** (30) - Frequent as components evolve
3. **Move Component** (24) - Reorganization as codebase grows
4. **Extract Logic to Custom Hook** (47) - Modernizing to hooks-based architecture
   - **Relay Consideration:** Since Relay requires fragments to be co-located with components, custom hooks that contain GraphQL queries must stay component-bound. However, you can still extract:
     - Pure logic hooks (no queries) — business rules, formatters, validators
     - Hooks that call fragments — wrap `useFragment` calls with additional logic
     - Data transformation hooks — take fragment data as input, return transformed output
   - The fragment itself stays in the component, but the processing around it can be extracted.

5. **Migrate Class to Function Component** (33) - Adopting modern React patterns

### Trends

- **Hook adoption** is accelerating (47 hook extractions, 33 class-to-function migrations)
- **Component extraction** is the dominant pattern for code reuse
- **Renaming and moving** operations indicate organic codebase evolution
- **Dead code elimination** (83) suggests regular cleanup practices

### Practical Value

This catalog supports practitioners when:
- Improving maintainability of React applications
- Modernizing legacy React code (hooks, function components)
- Designing refactoring guidelines for teams
- Planning migration from other frameworks (Angular → React)

---

## About

This catalog was proposed by **Fabio Ferreira** and **Marco Tulio Valente** from ASERG/DCC/UFMG.

Based on empirical study of 320 refactoring commits across open source React projects.

---

## Source

Original repository: [fabiosferreira/refactoring-react-web-apps](https://github.com/fabiosferreira/refactoring-react-web-apps)
