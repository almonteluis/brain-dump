---
description: React Context API provides a way to pass data through the component tree without prop drilling using createContext, Provider, and useContext or contextType.
tags: ["context-api"]
---
#context-api 
The React [[Context]] API - Condensed Answer:

**Key Points:**
* Shares data across components without prop drilling.
* Used for global state like themes, auth, or language
* Three main parts: Create, Provide, Consume
* Only components using context re-render on changes

# Detailed Implementation

1. Creating [[Context]]
```javascript
import { createContext } from 'react';

// Create context with optional default value
const ThemeContext = createContext('light');
```

2. Providing Context
```javascript
function ThemeProvider({ children }) {
  const [theme, setTheme] = useState('light');
  
  return (
    <ThemeContext.Provider value={{ theme, setTheme }}>
      {children}
    </ThemeContext.Provider>
  );
}

// Wrap your app
function App() {
  return (
    <ThemeProvider>
      <MainContent />
    </ThemeProvider>
  );
}
```

3. Consuming Context
```javascript
function ThemedButton() {
  const { theme, setTheme } = useContext(ThemeContext);
  
  return (
    <button onClick={() => setTheme(theme === 'light' ? 'dark' : 'light')}>
      Current theme: {theme}
    </button>
  );
}
```

## Common Patterns

### Multiple Contexts
```javascript
function App() {
  return (
    <AuthProvider>
      <ThemeProvider>
        <LanguageProvider>
          <MainContent />
        </LanguageProvider>
      </ThemeProvider>
    </AuthProvider>
  );
}
```

### Custom Hook Pattern
```javascript
function useTheme() {
  const context = useContext(ThemeContext);
  if (context === undefined) {
    throw new Error('useTheme must be used within ThemeProvider');
  }
  return context;
}

// Usage
function Button() {
  const { theme } = useTheme();
  return <button className={theme}>Click me</button>;
}
```

## Best Practices

### State Organization
```javascript
function AppProvider({ children }) {
  const [state, dispatch] = useReducer(reducer, initialState);
  const value = {
    user: state.user,
    theme: state.theme,
    dispatch
  };
  
  return (
    <AppContext.Provider value={value}>
      {children}
    </AppContext.Provider>
  );
}
```

### Performance Optimization
```javascript
// Split contexts for better performance
function AppProviders({ children }) {
  return (
    <ThemeProvider>
      <AuthProvider>
        {children}
      </AuthProvider>
    </ThemeProvider>
  );
}
```

Remember:
* Use context for truly global state
* Split contexts to avoid unnecessary re-renders
* Consider alternatives for complex state
* Provide meaningful default values
* Handle missing providers
* Document context usage
* Test components with different context values​​​​​​​​​​​​​​​​