---
description: React notes and reference about Node.js.
tags:
  - nodejs
  - javascript
  - web-development
  - glossary
  - backend
  - express
---
## Node.js Fundamentals
### Core Concepts
| **Term**               | **Definition**                                                                 |
|------------------------|-------------------------------------------------------------------------------|
| **Runtime Environment**| Infrastructure supporting code execution (Node.js = backend runtime)          |
| **Event-Driven**       | Program flow determined by events (user input, network requests)             |
| **Asynchronous**       | Processes running independently without blocking execution                    |
| **Non-Blocking**       | Task failures don't affect others; execution continues during I/O operations |
| **Single-Threaded**    | Processes one command at a time (with async I/O handling)                    |
| **Scalability**        | Ability to handle increasing load without performance degradation            |

### Key Benefits
- **Full-stack JavaScript**: Unified language for frontend/backend
- **Reduced context switching**: Shared patterns between client/server
- **High concurrency**: Event loop architecture handles thousands of connections
- **Unified dependency management**: npm ecosystem for 2M+ packages

## Server Architecture
### Component Roles
| **Server Type**       | **Function**                                                                 |
|-----------------------|------------------------------------------------------------------------------|
| **Web Server**        | Responds to client requests (typically HTTP/HTTPS)                          |
| **Application Server**| Executes business logic, transforms data to dynamic content                 |
| **Database Server**   | Provides dedicated database services                                        |
| **HTTP Server**       | Software server handling HTTP protocol and URLs                             |

### Web Service Fundamentals
- **Web Service**: API communicating via HTTP requests
- **Payload**: Data transmitted between client/server
- **Load Metrics**: Concurrent users, transactions, data transfer volume
- **server.js**: Conventional entry point for Node.js server applications

## Module System Deep Dive
### Core Terminology
| **Term**         | **Definition**                                                       |
| ---------------- | -------------------------------------------------------------------- |
| **Module**       | Encapsulated JavaScript files serving specific purposes              |
| **Package**      | Directory containing one/more modules + package.json                 |
| **Dependencies** | External code (libraries/packages) reused in a program               |
| **[[npm]]**      | Node Package Manager - default package manager for Node.js           |
| **package.json** | Manifest file containing project metadata, dependencies, and scripts |
|                  |                                                                      |

### Module Specifications
```javascript
// CommonJS (CJS)
const http = require('http');
module.exports = createServer;

// ES Modules (ESM)
import http from 'http';
export default createServer;

// Dynamic Import
const module = await import('./utils.js');
```

## Express.js Framework
### Fundamental Concepts
| **Term**               | **Definition**                                                                 |
|------------------------|-------------------------------------------------------------------------------|
| **Express.js**         | Configurable web framework for building Node.js applications                  |
| **Framework**          | Code generator for common tasks (Express, Django, Rails)                     |
| **Middleware**         | Functions that execute during request/response cycle                         |
| **Routing**            | Defining endpoints and their response handlers                               |

### Basic Express Server
```javascript
import express from 'express';

const app = express();
const port = 3000;

// Route handling
app.get('/', (req, res) => {
  res.send('Hello Express!');
});

// Anonymous function as callback
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
```

### Key Features
- **Middleware pipeline**: Sequential processing of requests
- **Routing system**: HTTP method handlers (GET, POST, PUT, DELETE)
- **Template engines**: Pug, EJS, Handlebars integration
- **Error handling**: Centralized error management

## Core Modules Reference
### Essential Modules
| **Module**    | **Use Case**                             |
| ------------- | ---------------------------------------- |
| `http`        | Creating HTTP servers and clients        |
| `fs`          | File system operations                   |
| `path`        | File/directory path manipulation         |
| `os`          | Operating system information             |
| `url`         | URL parsing and formatting               |
| `querystring` | Parsing and formatting URL query strings |

### HTTP Server Example
```javascript
import { createServer } from 'http';

// Callback function handling requests
const server = createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/html' });
  res.end('<h1>Hello World</h1>');
});

server.listen(3000);
```

## Asynchronous Patterns
### Key Concepts
| **Term**             | **Definition**                                                                 |
|----------------------|-------------------------------------------------------------------------------|
| **Callback Function**| Function passed as parameter to be invoked later (I/O completion)             |
| **Anonymous Function**| Unnamed function often used as inline callback                              |

### Async Operations
```javascript
// File System operation with callback
import { readFile } from 'fs';

readFile('data.txt', 'utf8', (err, data) => {
  if (err) throw err;
  console.log(data);
});

// Promise-based alternative
import { readFile } from 'fs/promises';

readFile('data.json', 'utf8')
  .then(data => JSON.parse(data))
  .catch(err => console.error(err));
```


## Development Best Practices
1. **Modularization**: Break code into focused modules
2. **Error handling**: Use middleware for centralized errors
3. **Async patterns**: Prefer async/await over callbacks
4. **Security**: Implement helmet, CORS, rate limiting
5. **Configuration**: Use environment variables (.env)

---
### Table of Contents
[[Express Middleware Deep Dive]]  
[[Database Integration Patterns]]  
[[Node.js Security Essentials]]
[[Callback Functions]]
[[Callback Challenges Nesting & Inversion of Control]]
[[Authentication and Authorization in Node.js]]
[[HTTP Methods and REST APIs]]
[[HTTP Methods]]
[[Introduction to Web Frameworks]]
[[MVC Architecture]]
[[REST API Architecture]]