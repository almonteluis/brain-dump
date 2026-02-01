---
tags: ["api", "best-practices", "coding-fundamentals", "es6", "functions", "generators", "javascript", "react", "this-keyword", "web-development"]description: Notes on Fetch and key concepts for reference.
---

# JavaScript Network Requests with `fetch()`

## Introduction to AJAX
JavaScript can send asynchronous network requests to servers and update content without page reloads. This is commonly called **AJAX** (Asynchronous JavaScript and XML), though modern implementations often use JSON instead of XML.

Common use cases:
- Submitting forms
- Loading user data
- Receiving real-time updates
- API interactions

## The `fetch()` Method
Modern approach for network requests. Supported in all modern browsers (requires polyfill for IE).

### Basic Syntax
```javascript
let promise = fetch(url [, options])
```
- **`url`**: Target endpoint
- **`options`** (optional): Request method, headers, body, etc.

### Handling Responses
A two-stage process:
1. Get initial response (headers + status)
2. Parse response body

**Basic GET example:**
```javascript
try {
  let response = await fetch(url);
  
  if (response.ok) { // Status 200-299
    let data = await response.json();
    // Process data
  } else {
    console.error(`HTTP Error: ${response.status}`);
  }
} catch (error) {
  console.error('Network error:', error);
}
```

## Response Handling Methods
Choose **one** body parsing method per response:
- `response.text()` - Plain text
- `response.json()` - JSON object
- `response.blob()` - Binary data (e.g., images)
- `response.arrayBuffer()` - Low-level binary data
- `response.formData()` - Form data format

**Example with promises:**
```javascript
fetch('https://api.github.com/repos/javascript-tutorial/en.javascript.info/commits')
  .then(response => response.json())
  .then(commits => console.log(commits[0].author.login));
```

## Headers Management
### Response Headers
```javascript
// Get single header
const contentType = response.headers.get('Content-Type');

// Iterate headers
for (const [key, value] of response.headers) {
  console.log(`${key}: ${value}`);
}
```

### Request Headers
```javascript
fetch(url, {
  headers: {
    'Authorization': 'Bearer token123',
    'Custom-Header': 'value'
  }
});
```

**Restricted Headers** (cannot be modified):
- `Accept-Charset`, `Content-Length`, `Cookie`
- `Host`, `Referer`, and security-related headers

## POST Requests
### Sending JSON
```javascript
const user = { name: 'John', surname: 'Smith' };

const response = await fetch('/api/user', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify(user)
});
```

### Sending Binary Data (Image Example)
```javascript
// From canvas element
canvasElem.toBlob(async (blob) => {
  const response = await fetch('/api/upload', {
    method: 'POST',
    body: blob // Auto-sets Content-Type from Blob
  });
  const result = await response.json();
  console.log(result);
}, 'image/png');
```

## Error Handling
```javascript
async function safeFetch(url) {
  try {
    const response = await fetch(url);
    if (!response.ok) throw new Error(`HTTP ${response.status}`);
    return await response.json();
  } catch (error) {
    console.error('Fetch failed:', error);
    return null;
  }
}
```

## Best Practices
1. Always check `response.ok` for 200-299 status codes
2. Use specific Content-Type headers
3. Handle errors with try/catch
4. Clean up unused resources (e.g., `URL.revokeObjectURL()`)

---
description: React notes and reference about Fetch.

## Practical Example: Fetch GitHub Users
```javascript
async function getUsers(names) {
  const requests = names.map(async name => {
    try {
      const response = await fetch(`https://api.github.com/users/${name}`);
      return response.ok ? response.json() : null;
    } catch {
      return null;
    }
  });
  return Promise.all(requests);
}
```

## Personal Notes Section

### My Understanding

[Write your thoughts using these prompts:]

- **How I would explain function patterns to a beginner:**  
  Function patterns are different ways to write functions in JavaScript. Think of them like different tools in a toolbox - each has its own special use case.

- **Mental model/analogy that helps me remember:**  
  - [[Function Declarations]] are like formal definitions (like in a dictionary)  
  - [[Arrow functions]] are like shorthand notes  
  - [[Generator functions]] are like pause-and-play buttons  

- **Key differences between patterns:**  
  1. [[Function Declarations]] are hoisted, function expressions aren't  
  2. [[Arrow functions]] don't have their own 'this', regular functions do  
  3. [[Generator functions]] can pause execution, regular functions run to completion  

- **Visual representation:**
```javascript
// Function Declaration (like a formal definition)
function add(a, b) {
  return a + b;
}

// Arrow Function (like a quick note)
const add = (a, b) => a + b;

// Generator Function (like a pause-play button)
function* counter() {
  yield 1;
  yield 2;
}
```

- **Common pitfalls I want to avoid:**  
  1. Using arrow functions as methods in objects (this binding issues)  
  2. Forgetting to return values in arrow functions with blocks  
  3. Mixing regular and generator functions incorrectly  

- **Real-world example from my code:**
```javascript
const UserProfile = {
  // Method shorthand
  getData() { /* ... */ },

  // Arrow function for preserved this
  fetchDetails: async () => { /* ... */ },

  // Generator for pagination
  *pageItems() { /* ... */ }
};
```

### Practice Area
```javascript
// Test your understanding
const obj = {
  name: "Test",
  sayHi: () => console.log(this.name),
  sayHello() { console.log(this.name); }
};

obj.sayHi();    // Prediction: undefined
obj.sayHello(); // Prediction: "Test"
```

### Key Takeaways
- Function declarations are hoisted and create their own `this` context  
- Arrow functions are great for callbacks but not for methods  
- Generator functions excel at handling sequences and iteration  
- Choose patterns based on use case and context  

### Resources I Found Helpful
- [MDN Functions Guide](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Functions)  
- [JavaScript.info Arrow Functions](https://javascript.info/arrow-functions-basics)  
- [MDN Generator Functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/function*)  

---

**Tag:** #javascript #react #api #functions #es6 #this-keyword #generators #best-practices #web-development #coding-fundamentals