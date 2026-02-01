---
description: Notes about MVC Architecture.
tags: #architecture #mvc #patterns #backend #design
---

# MVC Architecture

## Overview



```mermaid
graph LR
    U[User] --> C[Controller]
    C --> M[Model]
    M --> D[(Database)]
    M --> V[View]
    V --> U
```

- **Model**: Manages data & business logic & interacts with databases
- **View**: Handles data presentation (UI)
- **Controller**: Processes user input & coordinates Model/View

**Frameworks**: Express, Koa, Django, NestJS