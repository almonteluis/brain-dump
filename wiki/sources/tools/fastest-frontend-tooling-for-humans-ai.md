---
description: "Frontend tooling in 2026+, with and without AI."
tags: ['research']
source: "https://cpojer.net/posts/fastest-frontend-tooling"
raw_file: "Fastest Frontend Tooling for Humans & AI.md"
created: 2026-05-17
---

2026 is the year JavaScript tooling gets faster. [TypeScript is being rewritten in Go](https://github.com/microsoft/typescript-go), and tools like [Oxlint](https://oxc.rs/docs/guide/usage/linter.html) and [Oxfmt](https://oxc.rs/docs/guide/usage/formatter.html) are getting ready for mass adoption. Humans and LLMs both perform much better in codebases that have a fast feedback loop, strict guardrails, and strong local reasoning. This post aims to help everyone go faster with sensible and strict defaults.<sup><a>1</a></sup>

If you are bored of reading blog posts, you can also watch my [Building Scalable Applications](https://www.youtube.com/watch?v=rxPTEko8J7c&t=36s) talk, [send this post directly to your LLM](https://cpojer.net/posts/fastest-frontend-tooling.md), or get started with one of these templates:

- [Mobile App Template](https://github.com/nkzw-tech/expo-app-template)
- [Web App Template](https://github.com/nkzw-tech/web-app-template)
- [Library Template](https://github.com/nkzw-tech/library-template)
- [Server Template](https://github.com/nkzw-tech/server-template)
- [*fate* Template](https://github.com/nkzw-tech/fate-template)

---

*Here is how you can speed up your stack:*

## tsgo: TypeScript Go

I’ve been using TypeScript’s Go rewrite for the past six months for ~10x faster type checking. There were a few hiccups along the way, but it’s now mostly stable and feature-complete, including editor support.

The main concern I had about switching to an experimental version of TypeScript was regressions to the type checking behavior. However, the opposite was true: `tsgo` caught type errors that the JavaScript implementation didn’t catch! I adopted `tsgo` in 20+ projects ranging from 1,000 to 1,000,000 lines of code, and it has improved iteration speed quite a bit.

If you want to migrate to `tsgo` and currently use TypeScript to compile your code, I recommend first switching to [`tsdown`](https://tsdown.dev/) for libraries or Vite for web apps. tsdown is a fast bundler for libraries based on [Rolldown](https://rolldown.rs/) that optimizes your JavaScript bundles.

Then, the migration to `tsgo` is quick:

- `npm install @typescript/native-preview`
- Remove any legacy TypeScript config flags
- Replace every call to `tsc` with `tsgo`
- Add `"typescript.experimental.useTsgo": true` to your VS Code settings

## Prettier → Oxfmt

I’ve been using Prettier since it was in alpha. Many formatters have been built since then, but none had the feature coverage and plugin system of Prettier. Oxfmt is a great alternative because it has many of Prettier’s plugins built in, such as [import and Tailwind CSS class sorting](https://github.com/nkzw-tech/fate-template/blob/main/.oxfmtrc.jsonc#L4-L12), and it falls back to Prettier for formatting the long tail of languages other than JavaScript/TypeScript.

**Migration Prompt:**

> Migrate this project from Prettier to Oxfmt. Read [https://oxc.rs/docs/guide/usage/formatter/migrate-from-prettier.md](https://oxc.rs/docs/guide/usage/formatter/migrate-from-prettier.md). Update all scripts, tools, and hooks to use Oxfmt. Remove all Prettier configuration files and reformat the code using Oxfmt.

I recommend installing the [Oxc VS Code extension](https://oxc.rs/) via `code --install-extension oxc.oxc-vscode`.

## ESLint → Oxlint

Similar to Prettier, there have been many attempts to build new linters. However, the plugin ecosystem around ESLint is hard to beat. Even after I adopted a Rust-based linter, I had to keep using ESLint for lint rules such as the [React Compiler](https://react.dev/learn/react-compiler) plugin.

Oxlint is the first new linter that can run ESLint plugins directly via an ESLint plugin shim and [NAPI-RS](https://napi.rs/). Oxlint also supports TypeScript configuration files and you can use `extends` to compose your configuration:

```markdown
import nkzw from '@nkzw/oxlint-config';
import { defineConfig } from 'oxlint';

export default defineConfig({
  extends: [nkzw],
});
```

**Migration Prompt:**

> Migrate this project from ESLint to Oxlint. Read [https://oxc.rs/docs/guide/usage/linter/migrate-from-eslint.md](https://oxc.rs/docs/guide/usage/linter/migrate-from-eslint.md). Update all scripts, tools, and hooks to use Oxlint. Remove all ESLint configuration files. Lint the code and fix any lint errors.

Oxlint also supports type-aware lint rules. Install `oxlint-tsgolint` alongside Oxlint and run `oxlint --type-aware`. You can even check types directly via `oxlint --type-aware --type-check`, powered by TypeScript Go!

### @nkzw/oxlint-config

A few weeks ago I asked GPT 5.2 Codex to convert a codebase from one UI framework to another in an empty Git repository. Then I gave it this [Web App Template](https://github.com/nkzw-tech/web-app-template) and asked it to do the same conversion in a fresh session. Through the strict guardrails, it did a significantly better job with fewer bugs.

If you aren’t starting a project from scratch with the above template, you can use [`@nkzw/oxlint-config`](https://github.com/nkzw-tech/oxlint-config) to get a fast, strict, and comprehensive linting experience out of the box that guides LLMs to write better code with these principles:

- **Error, Never Warn:** Warnings are noise and tend to get ignored. Either it’s an issue, or it isn’t. This config forces developers to fix problems or explicitly disable the rule with a comment.
- **Strict, Consistent Code Style:** When multiple approaches exist, this configuration enforces the strictest, most consistent code style, preferring modern language features and best practices.
- **Prevent Bugs:** Problematic patterns such as `instanceof` are not allowed, forcing developers to choose more robust patterns. Debug-only code such as `console.log` or `test.only` is disallowed to avoid unintended logging in production or accidental CI failures.
- **Fast:** Slow rules are avoided. For example, TypeScript’s `noUnusedLocals` check is preferred over `no-unused-vars`.
- **Don’t get in the way:** [Subjective or overly opinionated rules](https://github.com/airbnb/javascript) (e.g. style preferences) are disabled. Autofixable rules are preferred to reduce friction and to save time.

I believe `@nkzw/oxlint-config` is the first package that brings together a comprehensive set of strict built-in and JS plugins for Oxlint. *Give it a try!*

**Migration Prompt:**

> Migrate this project from ESLint to Oxlint using `@nkzw/oxlint-config`. Read [https://raw.githubusercontent.com/nkzw-tech/oxlint-config/refs/heads/main/README.md](https://raw.githubusercontent.com/nkzw-tech/oxlint-config/refs/heads/main/README.md) and [https://oxc.rs/docs/guide/usage/linter/migrate-from-eslint.md](https://oxc.rs/docs/guide/usage/linter/migrate-from-eslint.md). Update all scripts, tools and hooks to use Oxlint. Remove all ESLint configuration files.

## Smaller DevX Optimizations

### npm-run-all2

I still like `npm-run-all2` <sup><a>2</a></sup> to parallelize scripts for fast local runs:

```markdown
"scripts": {
  "lint:format": "oxfmt --check",
  "lint": "oxlint",
  "check": "npm-run-all --parallel tsc lint lint:format",
  "tsc": "tsgo"
}
```

There are many complex tools and some package managers have parallelization built-in, but for small things this package works surprisingly well:

- It doesn’t add its own logging overhead.
- It doesn’t tear and interleave output from different jobs. It only prints the output of one job at a time.
- It exits as soon as one job fails.
- When you type `ctrl+c`, it actually shuts everything down immediately.

### ts-node

While there are many solutions now to run TypeScript during development, I still haven’t found one that supports all of TypeScript (JSX, enums, etc.) and is faster than `nodemon`, `ts-node`, and `swc` combined for running Node.js servers that instantly restart on file changes:

```markdown
pnpm nodemon -q -I --exec node --no-warnings --experimental-specifier-resolution=node --loader ts-node/esm --env-file .env index.ts
```

And in your `tsconfig.json`:

```markdown
"ts-node": {
  "transpileOnly": true,
  "transpiler": "ts-node/transpilers/swc",
  "files": true,
  "compilerOptions": {
    "module": "esnext",
    "isolatedModules": false
  }
}
```

I auto-save as I type (on the days I’m still coding by hand). When the changes affect a Node.js service, I want it to restart instantly on every keypress. I feel like I have tried everything under the sun and nothing comes close to being as fast as this combination. If you know of one that doesn’t have any trade-offs, *[please DM me](https://x.com/cnakazawa)*.

## Still great

It’s worth mentioning the tools that I still use every day [since the last time I wrote about this topic](https://cpojer.net/posts/posts/fastest-frontend-tooling-in-2022).

### pnpm

[pnpm](https://pnpm.io/) is the best package manager for JavaScript. It’s fast and full-featured.

### Vite

I can’t imagine starting a web project with a bundler and dev server other than Vite. It’s the fastest, most stable, and most extensible platform to build for the web. Soon it’ll be even faster with Rolldown under the hood.

### React

I’ve tried various UI frameworks but I keep coming back to React. The [React Compiler](https://react.dev/learn/react-compiler) keeps it fast, and [Async React](https://www.youtube.com/watch?v=B_2E96URooA) keeps it modern. I recently built [*fate*, a modern data client for React & tRPC](https://fate.technology/posts/introducing-fate) – *Try it!*

---

JavaScript tools need to be fast, stable, and feature-complete. There have been many attempts in recent years to build new tools, but they all required compromises. With the new tools above, you won’t have to compromise.<sup><a>3</a></sup>

Thanks for reading.
