---
description: "Primary React/TypeScript interface for teachers, students, and administrators"
tags: ['research']
raw_file: "FrontEnd.md"
created: 2026-05-17
---

---

# Front End

- [Purpose](#purpose)
- [Technology](#technology)
- [Connections](#connections)
- [Details](#details)
- [See also](#see-also)

## Purpose

Primary interface to the product for teachers, students, and administrators both external and internal. (Other relevant interfaces include the CMS, Learnosity, and Auth0, though these are all purely internally-facing.)

## Technology

[React](https://react.dev/) 18 UI written in TypeScript; [Relay](https://relay.dev/) client to talk to GraphQL; other libraries as documented in the [README](https://gitlab.com/new-classrooms/marvin/-/tree/main/frontend?ref_type=heads#installed-libraries); npm toolchain. Runs via the usual npm run in the Docker Compose stack but is served via a CloudFront CDN in AWS.

## Connections

- **GraphQL Service** - reads and writes data via Relay
- **Learnosity** - gets assessments, diagnostics, and other activities and saves results via the BFF
- **BFF** - funnels Learnosity data to and from the front end
- **Auth0** - provides single sign-on for users
- **CMS** - provides various types of content for the UI
- **Sentry** - provides logging for the front end independent of our hosting
- **Hotjar** - records user sessions and other events sent by the front end

## Details

### Configuration

The front end requires a few environment variables to be set properly in order for connections to Auth0, Learnosity (BFF), and the GraphQL service to work correctly. [Vite is responsible](https://vite.dev/guide/env-and-mode#env-variables) for getting the environment variable values into the code (via the import.meta.env data structure), and only variables prefixed with VITE_ will be passed through.

Node (i.e. npm run) expects these variables to be set up in frontend/.env, as does the [Docker Compose stack](https://github.com/NewClassrooms/marvin/blob/main/docker-compose.yml#L76). The full list of variables is in [frontend/.env.example](https://github.com/NewClassrooms/marvin/blob/main/frontend/.env.example), which can be used as a template.

In the GitHub context, Vite gets the values directly from the environment variables defined in the workflows. GitHub divides them into *secrets* and *variables*, though functionally they are the same in terms of the build process. These values are defined in three places, with presumably the natural precedence:

- At the GitHub organization level: [https://github.com/organizations/NewClassrooms/settings/secrets/actions](https://github.com/organizations/NewClassrooms/settings/secrets/actions)
- At the repository settings level: [https://github.com/NewClassrooms/marvin/settings/secrets/actions](https://github.com/NewClassrooms/marvin/settings/secrets/actions)
- At the per-environment level: [https://github.com/NewClassrooms/marvin/settings/environments](https://github.com/NewClassrooms/marvin/settings/environments)

#### Usable values

These values can be used to get yourself up and running locally. They are not sensitive but should probably not live in the git repo.

```bash
VITE_DOMAIN=dev-3m5gu3or26o2pflc.us.auth0.com
VITE_CLIENT_ID=dyrLInRcEXyYmKws1EaizExvBbStOHfV
VITE_GRAPHQL_SERVICE_URL=http://localhost:5172/v1/graphql/
VITE_BFF_URL=http://localhost:8080
VITE_UNLEASH_URL=https://us.app.unleash-hosted.com/usnn0030/api/frontend/
VITE_UNLEASH_CLIENT_KEY=default:development.9b0c137f6fc2290baf954d95f528b43bd22f0d370958bb9fcee9d831
```

#### More or less required

**VITE_DOMAIN**

This is the Auth0 domain used to initialize Auth0Provider. The value can be found in the Auth0 management console, under the [settings for the TTO Roadmaps Dev application](https://manage.auth0.com/dashboard/us/dev-3m5gu3or26o2pflc/applications/dyrLInRcEXyYmKws1EaizExvBbStOHfV/settings) (though the value is a property of the Auth0 tenant and not unique to this specific application).

**VITE_CLIENT_ID**

This is the Auth0 client ID used to initialize Auth0Provider. The value comes from the Auth0 management console, under the [settings for the TTO Roadmaps Dev application](https://manage.auth0.com/dashboard/us/dev-3m5gu3or26o2pflc/applications/dyrLInRcEXyYmKws1EaizExvBbStOHfV/settings); it uniquely identifies this application.

**VITE_BFF_URL**

Tells the front end how to connect to the BFF. If you're using the Docker Compose stack, it should [match the host port](https://github.com/NewClassrooms/marvin/blob/main/docker-compose.yml#L63). If you're running the BFF manually on some other port, make sure to point this there.

**VITE_GRAPHQL_SERVICE_URL**

Tells the front end how to connect to the GraphQL service. If you're using the Docker Compose stack, it should [match the host port](https://github.com/NewClassrooms/marvin/blob/main/docker-compose.yml#L39). If you're running the GraphQL service manually on some other port, make sure to point this there.

**VITE_UNLEASH_URL**

Tells the front end where to query for feature flags. The frontend smoothly falls back if it can't access the URL in question, but it will log a warning if a valid URL isn't supplied at all. See this page for instructions on configuring for local development: [Local Development with Unleash](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/1317044240/Local+Development+with+Unleash)

**VITE_UNLEASH_CLIENT_KEY**

This is the API key for the feature flagging service. See [this page](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/1317044240/Local+Development+with+Unleash) for instructions on setup for local development.

#### More or less optional

These all relate to Sentry. Refer to [our Sentry documentation about these variables](https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/872251393/Sentry#Should-set).

- VITE_SENTRY_ENABLED
- VITE_SENTRY_DSN
- VITE_SENTRY_ENVIRONMENT
- VITE_RELEASE_VERSION
- VITE_SENTRY_AUTH_TOKEN
- VITE_SENTRY_ORG
- VITE_SENTRY_PROJECT
- VITE_SENTRY_IGNORE_PATTERNS

These all relate to Hotjar. Refer to our [Hotjar documentation](https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/924155919/Hotjar#Front-end-configuration) about these variables.

- VITE_HOTJAR_SITE_ID
- VITE_HOTJAR_ENABLED
- VITE_HOTJAR_DEBUG

### Security

#### Subresource integrity & updating embedded libraries

Third-party libraries that we reference in the front end (i.e. libraries hosted by other CDNs, like the SpeechStream library) could potentially be compromised by an attacker. Subresource integrity (SRI) prevents this attack by including a hash along with the link to the library so that the browser itself can confirm that the library it loads is what we expect it to load. Read more here: [https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity](https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity)

When updating these libraries, you will need to compute a new hash for the library and include that in the integrity="…" attribute for the tag (e.g. a `<link>` or `<script>` tag). You can use the openssl command line tool to generate the hash. For example:

```bash
wget -q 'https://unpkg.com/@lottiefiles/lottie-player@2.0.8/dist/lottie-player.js' -O - | openssl dgst -sha384 -binary | base64
```

This will give you a raw hash like `IntiqSJhM3wc...3K0CfsWwOscMCu`, and you need to prefix the hash with the sha384 algorithm indicator in the integrity attribute:

```
integrity="sha384-IntiqSJhM3wc...3K0CfsWwOscMCu"
```

Note that the Google fonts we use do not have a version, and Google may return different fonts optimized for different user agents, so we can't implement this for that resource. We'll accept that risk.

## See also

- [Learnosity Access](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/43057209/Learnosity+Access)
