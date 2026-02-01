---
description: Atomic Design in React - Building from Atoms
tags: #atomic-design #react #components #architecture #patterns
---
Atomic Design in React - Building from Atoms

**Key Points:**
* [[Atoms]]: Smallest building blocks
* [[Molecules]]: Groups of [[Atoms]]
* [[Organisms]]: Groups of [[Molecules]]
* [[Templates]]: Page layouts
* [[Pages]]: Specific instances of [[Templates]]

# Folder Structure:

A common way to organize your components is to create a folder structure that mirrors the Atomic Design hierarchy:

```
src/
 components/
     atoms/
           Button.jsx
           Input.jsx
           ...
     molecules/
           SearchBar.jsx
           ...
     organisms/
           Header.jsx
           ...
     templates/
           ProductPageTemplate.jsx
           ...
	 pages/      
		   ProductPage.jsx 
		   ...
```

Benefits of Atomic Design:
# Detailed Components Breakdown

## 1. Atoms (Basic Components)
```tsx
// Button Atom
const Button = ({ children, onClick, variant = 'primary' }) => (
  <button 
    className={`btn btn-${variant}`} 
    onClick={onClick}
  >
    {children}
  </button>
);

// Input Atom
const Input = ({ type = 'text', placeholder, value, onChange }) => (
  <input
    type={type}
    value={value}
    onChange={onChange}
    placeholder={placeholder}
    className="input"
  />
);

// Typography Atoms
const Text = ({ children, size = 'md' }) => (
  <p className={`text-${size}`}>{children}</p>
);

const Heading = ({ level = 1, children }) => {
  const Tag = `h${level}`;
  return <Tag className="heading">{children}</Tag>;
};

// Icon Atom
const Icon = ({ name, size = 'md' }) => (
  <i className={`icon-${name} size-${size}`} />
);
```

## 2. Basic Atomic Components List

### Form Atoms
```jsx
// Label
const Label = ({ htmlFor, children }) => (
  <label htmlFor={htmlFor}>{children}</label>
);

// Checkbox
const Checkbox = ({ checked, onChange, label }) => (
  <input type="checkbox" checked={checked} onChange={onChange} />
);

// Radio
const Radio = ({ value, name, checked, onChange }) => (
  <input type="radio" value={value} name={name} checked={checked} onChange={onChange} />
);
```

### UI Elements
```jsx
// Badge
const Badge = ({ count, variant }) => (
  <span className={`badge badge-${variant}`}>{count}</span>
);

// Avatar
const Avatar = ({ src, alt, size = 'md' }) => (
  <img src={src} alt={alt} className={`avatar size-${size}`} />
);

// Spinner
const Spinner = ({ size = 'md' }) => (
  <div className={`spinner spinner-${size}`} />
);
```

## 3. Layout Atoms
```jsx
// Container
const Container = ({ children, fluid }) => (
  <div className={`container${fluid ? '-fluid' : ''}`}>
    {children}
  </div>
);

// Grid
const Row = ({ children }) => (
  <div className="row">{children}</div>
);

const Col = ({ children, size }) => (
  <div className={`col-${size}`}>{children}</div>
);

// Divider
const Divider = () => <hr className="divider" />;
```

## 4. Interactive Atoms
```jsx
// Toggle
const Toggle = ({ checked, onChange }) => (
  <label className="toggle">
    <input type="checkbox" checked={checked} onChange={onChange} />
    <span className="slider" />
  </label>
);

// Progress
const Progress = ({ value, max = 100 }) => (
  <progress value={value} max={max} className="progress" />
);
```

## Best Practices

### Atom Structure
```jsx
// Component file structure
/atoms
  /Button
    Button.jsx
    Button.test.jsx
    Button.styles.js
    index.js

// Component with Styles
import styled from 'styled-components';

const StyledButton = styled.button`
  // styles
`;

export const Button = ({ children, ...props }) => (
  <StyledButton {...props}>{children}</StyledButton>
);
```

### Props Pattern
```jsx
// Consistent props pattern
const commonProps = {
  className: PropTypes.string,
  style: PropTypes.object,
  onClick: PropTypes.func,
  disabled: PropTypes.bool
};

// Usage
Button.propTypes = {
  ...commonProps,
  variant: PropTypes.oneOf(['primary', 'secondary']),
  size: PropTypes.oneOf(['sm', 'md', 'lg'])
};
```

### Theming
```jsx
// Theme-aware atoms
const Text = styled.p`
  color: ${props => props.theme.colors.text};
  font-size: ${props => props.theme.fontSizes[props.size]};
`;
```

Remember:
* Keep atoms simple and single-purpose
* Maintain consistency in props
* Use meaningful default values
* Document component usage
* Include proper PropTypes
* Consider [[Accessibility]]
* Make components theme-aware
* Test each atom independently
* Create reusable styles
* Follow naming conventions​​​​​​​​​​​​​​​​