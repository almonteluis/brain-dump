---
description: React handles form input changes through controlled components using onChange handlers to update state, with the input value derived from state making it the single source of truth.
tags: ["events", "forms", "interview", "react", "state"]
---

# React Form Input Handling

## Overview

#react #forms #events #state #interview

> React handles form inputs through controlled components, where form data is controlled by React state. Every state change triggers a re-render, allowing React to be the "single source of truth" for input values and enabling features like instant validation, conditional rendering, and dynamic form behavior.

```javascript
function FormExample() {
  const [formData, setFormData] = useState({
    username: '',
    email: ''
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log(formData);
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        name="username"
## Example

        value={formData.username}
        onChange={handleChange}
      />
      <input
        name="email"
        value={formData.email}
        onChange={handleChange}
      />
      <button type="submit">Submit</button>
    </form>
  );
}
```

#### Key Points:
* Use onChange event to capture input changes
* Update state with new values using setState
* Prevent default form submission behavior
* Form values are always synced with component state​​​​​​​​​​​​​​​​