---
description: Notes about REST API Architecture.
---

# REST API Architecture

## Overview


```mermaid
sequenceDiagram
    Client->>Server: HTTP Request (GET/POST/PUT/DELETE)
    Server->>Client: JSON/XML/Text Response
```

- **Constraints**:
  1. Client-server independence
  2. Stateless communication
  3. Resource-based operations
  4. Uniform interface

**Data Formats**: JSON (most common), HTML, XML, Plain Text