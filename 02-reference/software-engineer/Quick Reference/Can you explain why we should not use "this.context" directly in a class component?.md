---
description: Direct this.context usage is legacy and unstable; use Context.Consumer or static contextType for classes, or useContext hook for functional components.
tags: ["best-practices", "class-components", "context", "interview", "react"]
---

# Why Not Use this.context Directly

## Explanation

#react #context #class-components #best-practices #interview

> Directly using this.context in class components is considered legacy API and unstable. It makes components less predictable and harder to test. Instead, use the modern Context.Consumer or static contextType for class components, or useContext hook for functional components.

#### Code Example:
```javascript
// Bad Practice
class BadComponent extends React.Component {
  render() {
    return <div>{this.context.theme}</div>; // Don't do this
  }
}

// Good Practice - Using Context.Consumer
const ThemeContext = React.createContext('light');

class GoodComponent extends React.Component {
  static contextType = ThemeContext; // Modern approach

  render() {
    return (
      <ThemeContext.Consumer>
        {theme => <div>{theme}</div>}
      </ThemeContext.Consumer>
    );
  }
}

// Better - Using Functional Component with useContext
function BestComponent() {
  const theme = useContext(ThemeContext);
  return <div>{theme}</div>;
}
```

#### Key Points:
* this.context doesn't support context updates reliably
* Use Context.Consumer for multiple contexts
* static contextType is cleaner but limited to one context
* Functional components with useContext are preferred​​​​​​​​​​​​​​​​