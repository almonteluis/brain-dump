---
description: Handle React form submission by preventing default browser behavior, creating submit handlers, and accessing form data through state or FormData API.
tags: ["events", "forms", "interview", "react", "submission"]
---

# React Form Submission

## Overview

#react #forms #events #submission #interview 

> Form submission in React involves preventing the default form behavior, validating inputs, and handling the submission through a controlled form component. This allows you to manage form data, perform validation, and handle server submission in a controlled manner.

#### Code Example:
```javascript
function SubmitForm() {
  const [formData, setFormData] = useState({
    email: '',
    password: ''
  });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const handleSubmit = async (e) => {
    e.preventDefault(); // Prevent default form submission
    setLoading(true);
    setError(null);

    try {
      // Validation
      if (!formData.email || !formData.password) {
        throw new Error('All fields are required');
      }

      // API call
      const response = await fetch('/api/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(formData)
      });

## Example

      if (!response.ok) {
        throw new Error('Login failed');
      }

      const data = await response.json();
      console.log('Success:', data);
      
      // Reset form
      setFormData({ email: '', password: '' });
      
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  return (
    <form onSubmit={handleSubmit}>
      {error && <div className="error">{error}</div>}
      
      <input
        name="email"
        type="email"
        value={formData.email}
        onChange={handleChange}
        disabled={loading}
      />
      
      <input
        name="password"
        type="password"
        value={formData.password}
        onChange={handleChange}
        disabled={loading}
      />
      
      <button type="submit" disabled={loading}>
        {loading ? 'Submitting...' : 'Submit'}
      </button>
    </form>
  );
}
```

#### Key Points:
* Prevent default form submission with e.preventDefault()
* Handle loading and error states
* Validate inputs before submission
* Reset form after successful submission
* Consider accessibility and user feedback​​​​​​​​​​​​​​​​