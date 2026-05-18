---
description: "Accessibility - Marvin"
tags: ["marvin", "new-classrooms", "engineering"]
source: "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/1353547777/Accessibility"
raw_file: "Accessibility - Marvin.md"
created: 2026-05-17
---

## Accessibility

## Overview

As a requirement for doing business with federally-funded schools—and of course to help as many students with different abilities as possible—we aim to meet the [WCAG 2.1](https://www.w3.org/TR/WCAG21/ "https://www.w3.org/TR/WCAG21/") AA level of accessibility.

Work is currently being tracked in this epic: [PP-304: Working Toward WCAG 2.1 AA StandardsIn Progress](https://newclassrooms.atlassian.net/browse/PP-304)

The current expectation is to just gradually chip away at these issues that Deque’s tooling identified, but we are still in the process of familiarizing ourselves with the tools.

## Deque tools

## Licensing and support

We have a limited number of licenses (costing $1,350/yr), but we should have enough for anyone actively doing front end development plus some to float among QA and other engineers. Currently you can contact Jackie or Steve for licensing issues. Some tools are either entirely or effectively free to use, so you may not even need a license, but perhaps just an API key.

Licenses for the various sub-products are managed by clicking the icon for a user here: [https://axe.deque.com/user-access](https://axe.deque.com/user-access "https://axe.deque.com/user-access")

We also have budgeted 50 hours of paid support at $220, and don’t be shy about using it. Jackie or Steve can help you get in touch with the paid support channels.

## Linter

### Running from the command line

Docs here: [https://docs.deque.com/linter/4.0.0/en/axe-linter-connector](https://docs.deque.com/linter/4.0.0/en/axe-linter-connector "https://docs.deque.com/linter/4.0.0/en/axe-linter-connector")

To run the axe DevTools Linter from the command line, you’ll need an API key (provisioned here: [https://axe.deque.com/settings](https://axe.deque.com/settings "https://axe.deque.com/settings")). Ask an admin for one if you don’t have access. The key should be provisioned with the `axe DevTools Linter` target.

Download the axe DevTools Connector: [https://docs.deque.com/linter/4.0.0/en/downloads#axe-devtools-linter-connector](https://docs.deque.com/linter/4.0.0/en/downloads#axe-devtools-linter-connector "https://docs.deque.com/linter/4.0.0/en/downloads#axe-devtools-linter-connector")

Create a config file `.axe.yaml`, for example in `marvin/frontend/`, that looks like:

```
tags:

  - wcag2a
```

**Note:** We should be using the `wcag21aa` tag, but it produces no results.

Run the linter with a command like:

```
axe-linter-connector-linux --api-key "$AXE_API_KEY" --config .axe.yaml \

    -s . -d . --local --url https://axe-linter.deque.com/
```

You should get a resulting file `axe-linter-report.json` with contents like so:

```
{

  "issues": [

    {

      "engineId": "axe-linter-tsx",

      "ruleId": "link-name (https://dequeuniversity.com/rules/axe/4.10/link-name?application=axe-linter)",

      "severity": "MAJOR",

      "type": "BUG",

      "primaryLocation": {

        "filePath": "/home/sseverin/nc/github/marvin/frontend/src/components/TeacherSingleSkill/TeacherSingleSkill.tsx",

        "message": "Links must have discernible text",

        "textRange": {

          "startLine": 163,

          "endLine": 163,

          "startColumn": 24,

          "endColumn": 26

        }

      }

    },

    ....

  ]

}
```

You can get a summary of the issues with a command like this:

```
jq -r '.issues | .[] | .primaryLocation.message' < axe-linter-report_a.json \

    | sort | uniq -c | sort -n
```

## SpeechStream

This third-party JavaScript library provides a bunch of accessibility tools embedded in the front end. See details here: [SpeechStream](https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/1862926337)

## See also

- [Incorporating Axe Accessibility DevTools into New Classrooms SDLC](https://newclassrooms.atlassian.net/wiki/spaces/QA/pages/1266843653) in the QA space

See what's changed since your last visit
