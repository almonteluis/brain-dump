---
description: 3|source: "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/385810497/Front+End"
tags: ["marvin", "new-classrooms", "engineering"]
source: "Front End - Marvin.md"
created: 2026-05-17
---

# Front End - Marvin

1|---
     2|title: "Front End - Marvin"
     3|source: "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/385810497/Front+End"
     4|author:
     5|published:
     6|created: 2026-04-30
     7|description:
     8|tags:
     9|  - "clippings"
    10|---
    11|## Front End
    12|
    13|## Purpose
    14|
    15|Primary interface to the product for teachers, students, and administrators both external and internal. (Other relevant interfaces include the CMS, Learnosity, and Auth0, though these are all purely internally-facing.)
    16|
    17|## Technology
    18|
    19|[React](https://react.dev/ "https://react.dev/") 18 UI written in TypeScript; [Relay](https://relay.dev/ "https://relay.dev/") client to talk to GraphQL; other libraries as documented in the [README](https://gitlab.com/new-classrooms/marvin/-/tree/main/frontend?ref_type=heads#installed-libraries "https://gitlab.com/new-classrooms/marvin/-/tree/main/frontend?ref_type=heads#installed-libraries"); npm toolchain. Runs via the usual `npm run` in the Docker Compose stack but is served via a CloudFront CDN in AWS.
    20|
    21|## Connections
    22|
    23|- GraphQL Service — reads and writes data via Relay
    24|- Learnosity — gets assessments, diagnostics, and other activities and saves results via the BFF
    25|- BFF — funnels Learnosity data to and from the front end
    26|- Auth0 — provides single sign-on for users
    27|- CMS — provides various types of content for the UI
    28|- Sentry — provides logging for the front end independent of our hosting
    29|- Hotar — records user sessions and other events sent by the front end
    30|
    31|## Details
    32|
    33|## Configuration
    34|
    35|The front end requires a few environment variables to be set properly in order for connections to Auth0, Learnosity (BFF), and the GraphQL service to work correctly. [Vite is responsible](https://vite.dev/guide/env-and-mode#env-variables "https://vite.dev/guide/env-and-mode#env-variables") for getting the environment variable values into the code (via the `import.meta.env` data structure), and only variables prefixed with `VITE_` will be passed through.
    36|
    37|Node (i.e. `npm run …`) expects these variables to be set up in `frontend/.env`, as does the [Docker Compose stack](https://github.com/NewClassrooms/marvin/blob/main/docker-compose.yml#L76 "https://github.com/NewClassrooms/marvin/blob/main/docker-compose.yml#L76"). The full list of variables is in [frontend/.env.example](https://github.com/NewClassrooms/marvin/blob/main/frontend/.env.example "https://github.com/NewClassrooms/marvin/blob/main/frontend/.env.example"), which can be used as a template.
    38|
    39|In the GitHub context, Vite gets the values directly from the environment variables defined in the workflows. GitHub divides them into *secrets* and *variables*, though functionally they are the same in terms of the build process. These values are defined in three places, with presumably the natural precedence:
    40|
    41|1. At the GitHub organization level: [https://github.com/organizations/NewClassrooms/settings/secrets/actions](https://github.com/organizations/NewClassrooms/settings/secrets/actions "https://github.com/organizations/NewClassrooms/settings/secrets/actions")
    42|2. At the repository settings level: [https://github.com/NewClassrooms/marvin/settings/secrets/actions](https://github.com/NewClassrooms/marvin/settings/secrets/actions "https://github.com/NewClassrooms/marvin/settings/secrets/actions")
    43|3. At the per-environment level: [https://github.com/NewClassrooms/marvin/settings/environments](https://github.com/NewClassrooms/marvin/settings/environments "https://github.com/NewClassrooms/marvin/settings/environments")
    44|
    45|### Usable values
    46|
    47|These values can be used to get yourself up and running locally. They are not sensitive but should probably not live in the git repo.
    48|
    49|```
    50|VITE_DOMAIN=dev-3m5gu3or26o2pflc.us.auth0.com
    51|
    52|VITE_CLIENT_ID=dyrLInRcEXyYmKws1EaizExvBbStOHfV
    53|
    54|VITE_GRAPHQL_SERVICE_URL=http://localhost:5172/v1/graphql/
    55|
    56|VITE_BFF_URL=http://localhost:8080
    57|
    58|VITE_UNLEASH_URL=https://us.app.unleash-hosted.com/usnn0030/api/frontend/
    59|
    60|VITE_UNLEASH_CLIENT_KEY=default:development.9b0c137f6fc2290baf954d95f528b43bd22f0d370958bb9fcee9d831
    61|```
    62|
    63|### More or less required
    64|
    65|`VITE_DOMAIN`
    66|
    67|This is the Auth0 domain used to initialize `Auth0Provider`. The value can be found in the Auth0 management console, under the [settings for the TTO Roadmaps Dev application](https://manage.auth0.com/dashboard/us/dev-3m5gu3or26o2pflc/applications/dyrLInRcEXyYmKws1EaizExvBbStOHfV/settings "https://manage.auth0.com/dashboard/us/dev-3m5gu3or26o2pflc/applications/dyrLInRcEXyYmKws1EaizExvBbStOHfV/settings") (though the value is a property of the Auth0 tenant and not unique to this specific application).
    68|
    69|`VITE_CLIENT_ID`
    70|
    71|This is the Auth0 client ID used to initialize `Auth0Provider`. The value comes from the Auth0 management console, under the [settings for the TTO Roadmaps Dev application](https://manage.auth0.com/dashboard/us/dev-3m5gu3or26o2pflc/applications/dyrLInRcEXyYmKws1EaizExvBbStOHfV/settings "https://manage.auth0.com/dashboard/us/dev-3m5gu3or26o2pflc/applications/dyrLInRcEXyYmKws1EaizExvBbStOHfV/settings"); it uniquely identifies this application.
    72|
    73|`VITE_BFF_URL`
    74|
    75|Tells the front end how to connect to the BFF. If you’re using the Docker Compose stack, it should [match the host port](https://github.com/NewClassrooms/marvin/blob/main/docker-compose.yml#L63 "https://github.com/NewClassrooms/marvin/blob/main/docker-compose.yml#L63"). If you’re running the BFF manually on some other port, make sure to point this there.
    76|
    77|`VITE_GRAPHQL_SERVICE_URL`
    78|
    79|Tells the front end how to connect to the GraphQL service. If you’re using the Docker Compose stack, it should [match the host port](https://github.com/NewClassrooms/marvin/blob/main/docker-compose.yml#L39 "https://github.com/NewClassrooms/marvin/blob/main/docker-compose.yml#L39"). If you’re running the GraphQL service manually on some other port, make sure to point this there.
    80|
    81|`VITE_UNLEASH_URL`
    82|
    83|Tells the front end where to query for feature flags. The frontend smoothly falls back if it can’t access the URL in question, but it will log a warning if a valid URL isn’t supplied at all. See this page for instructions on configuring for local development: [Local Development with Unleash](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/1317044240)
    84|
    85|`VITE_UNLEASH_CLIENT_KEY`
    86|
    87|This is the API key for the feature flagging service. See [this page](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/1317044240 "https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/1317044240") for instructions on setup for local development.
    88|
    89|### More or less optional
    90|
    91|These all relate to Sentry. Refer to [our Sentry documentation about these variables](https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/872251393/Sentry#Should-set "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/872251393/Sentry#Should-set").
    92|
    93|```
    94|VITE_SENTRY_ENABLED
    95|
    96|VITE_SENTRY_DSN
    97|
    98|VITE_SENTRY_ENVIRONMENT
    99|
   100|VITE_RELEASE_VERSION
   101|
   102|VITE_SENTRY_AUTH_TOKEN
   103|
   104|VITE_SENTRY_ORG
   105|
   106|VITE_SENTRY_PROJECT
   107|
   108|VITE_SENTRY_IGNORE_PATTERNS
   109|```
   110|
   111|These all relate to Hotjar. Refer to our [Hotjar documentation](https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/924155919/Hotjar#Front-end-configuration "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/924155919/Hotjar#Front-end-configuration") about these variables.
   112|
   113|```
   114|VITE_HOTJAR_SITE_ID
   115|
   116|VITE_HOTJAR_ENABLED
   117|
   118|VITE_HOTJAR_DEBUG
   119|```
   120|
   121|## Security
   122|
   123|### Subresource integrity & updating embedded libraries
   124|
   125|Third-party libraries that we reference in the front end (i.e. libraries hosted by other CDNs, like the SpeechStream library) could potentially be compromised by an attacker. Subresource integrity (SRI) prevents this attack by including a hash along with the link to the library so that the browser itself can confirm that the library it loads is what we expect it to load. Read more here: [https://developer.mozilla.org/en-US/docs/Web/Security/Subresource\_Integrity](https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity "https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity")
   126|
   127|When updating these libraries, you will need to compute a new hash for the library and include that in the `integrity=”…”` attribute for the tag (e.g. a `<script>` or `<link>` tag). You can use the `openssl` command line tool to generate the hash. For example:
   128|
   129|```
   130|wget -q 'https://unpkg.com/@lottiefiles/lottie-player@2.0.8/dist/lottie-player.js' -O - | openssl dgst -sha384 -binary | base64
   131|```
   132|
   133|This will give you a raw hash `IntiqSJhM3wc...3K0CfsWwOscMCu`, and you need to prefix the hash with the `sha384` algorithm indicator in the `integrity` attribute:
   134|
   135|```
   136|<script src="https://unpkg.com/@lottiefiles..."
   137|
   138|  integrity="sha384-IntiqSJhM3wc...3K0CfsWwOscMCu"
   139|
   140|  crossorigin
   141|
   142|/>
   143|```
   144|
   145|Note that the Google fonts we use do not have a version, and Google may return different fonts optimized for different user agents, so we can’t implement this for that resource. We’ll accept that risk.
   146|
   147|## See also
   148|
   149|- [Learnosity Access](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/43057209)
