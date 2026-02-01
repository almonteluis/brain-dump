---
description: Handle multiple form inputs in React using controlled components with individual state for each input or a single object state with name attributes for dynamic updates.
tags: ["controlled-components", "forms", "interview", "react", "state-management"]
---

# Multiple Form Inputs

## Overview

#react #forms #state-management #controlled-components #interview

> Multiple form inputs in React are typically handled using a single state object with controlled components. Each input's value is controlled by state, and updates are managed through a dynamic event handler that uses the input's 'name' attribute to update the corresponding state property.

#### Code Example:
```javascript
function MultipleInputForm() {
  const [formData, setFormData] = useState({
    username: '',
    email: '',
    password: ''
  });
  const [errors, setErrors] = useState({});

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prevState => ({
      ...prevState,
      [name]: value
    }));
  };

## Example

  const handleSubmit = (e) => {
    e.preventDefault();
    // Form validation
    const validationErrors = validateForm(formData);
    if (Object.keys(validationErrors).length === 0) {
      // Submit form
      console.log('Form submitted:', formData);
    } else {
      setErrors(validationErrors);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <div>
        <input
          name="username"
          value={formData.username}
          onChange={handleChange}
          placeholder="Username"
        />
        {errors.username && <span>{errors.username}</span>}
      </div>

      <div>
        <input
          name="email"
          type="email"
          value={formData.email}
          onChange={handleChange}
          placeholder="Email"
        />
        {errors.email && <span>{errors.email}</span>}
      </div>

      <div>
        <input
          name="password"
          type="password"
          value={formData.password}
          onChange={handleChange}
          placeholder="Password"
        />
        {errors.password && <span>{errors.password}</span>}
      </div>

      <button type="submit">Submit</button>
    </form>
  );
}
```

#### Key Points:
* Use a single state object for all form inputs
* Utilize input 'name' attribute for dynamic updates
* Implement form validation before submission
* Consider using form libraries for complex forms (Formik, React Hook Form)​​​​​​​​​​​​​​​​