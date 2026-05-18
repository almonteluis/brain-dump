---
description: 3|source: "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/1353547777/Accessibility"
tags: ["marvin", "new-classrooms", "engineering"]
source: "Accessibility - Marvin.md"
created: 2026-05-17
---

# Accessibility - Marvin

1|---
     2|title: "Accessibility - Marvin"
     3|source: "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/1353547777/Accessibility"
     4|author:
     5|published:
     6|created: 2026-04-30
     7|description:
     8|tags:
     9|  - "clippings"
    10|---
    11|## Accessibility
    12|
    13|## Overview
    14|
    15|As a requirement for doing business with federally-funded schools—and of course to help as many students with different abilities as possible—we aim to meet the [WCAG 2.1](https://www.w3.org/TR/WCAG21/ "https://www.w3.org/TR/WCAG21/") AA level of accessibility.
    16|
    17|Work is currently being tracked in this epic: [PP-304: Working Toward WCAG 2.1 AA StandardsIn Progress](https://newclassrooms.atlassian.net/browse/PP-304)
    18|
    19|The current expectation is to just gradually chip away at these issues that Deque’s tooling identified, but we are still in the process of familiarizing ourselves with the tools.
    20|
    21|## Deque tools
    22|
    23|## Licensing and support
    24|
    25|We have a limited number of licenses (costing $1,350/yr), but we should have enough for anyone actively doing front end development plus some to float among QA and other engineers. Currently you can contact Jackie or Steve for licensing issues. Some tools are either entirely or effectively free to use, so you may not even need a license, but perhaps just an API key.
    26|
    27|Licenses for the various sub-products are managed by clicking the icon for a user here: [https://axe.deque.com/user-access](https://axe.deque.com/user-access "https://axe.deque.com/user-access")
    28|
    29|We also have budgeted 50 hours of paid support at $220, and don’t be shy about using it. Jackie or Steve can help you get in touch with the paid support channels.
    30|
    31|## Linter
    32|
    33|### Running from the command line
    34|
    35|Docs here: [https://docs.deque.com/linter/4.0.0/en/axe-linter-connector](https://docs.deque.com/linter/4.0.0/en/axe-linter-connector "https://docs.deque.com/linter/4.0.0/en/axe-linter-connector")
    36|
    37|To run the axe DevTools Linter from the command line, you’ll need an API key (provisioned here: [https://axe.deque.com/settings](https://axe.deque.com/settings "https://axe.deque.com/settings")). Ask an admin for one if you don’t have access. The key should be provisioned with the `axe DevTools Linter` target.
    38|
    39|Download the axe DevTools Connector: [https://docs.deque.com/linter/4.0.0/en/downloads#axe-devtools-linter-connector](https://docs.deque.com/linter/4.0.0/en/downloads#axe-devtools-linter-connector "https://docs.deque.com/linter/4.0.0/en/downloads#axe-devtools-linter-connector")
    40|
    41|Create a config file `.axe.yaml`, for example in `marvin/frontend/`, that looks like:
    42|
    43|```
    44|tags:
    45|
    46|  - wcag2a
    47|```
    48|
    49|**Note:** We should be using the `wcag21aa` tag, but it produces no results.
    50|
    51|Run the linter with a command like:
    52|
    53|```
    54|axe-linter-connector-linux --api-key "$AXE_API_KEY" --config .axe.yaml \
    55|
    56|    -s . -d . --local --url https://axe-linter.deque.com/
    57|```
    58|
    59|You should get a resulting file `axe-linter-report.json` with contents like so:
    60|
    61|```
    62|{
    63|
    64|  "issues": [
    65|
    66|    {
    67|
    68|      "engineId": "axe-linter-tsx",
    69|
    70|      "ruleId": "link-name (https://dequeuniversity.com/rules/axe/4.10/link-name?application=axe-linter)",
    71|
    72|      "severity": "MAJOR",
    73|
    74|      "type": "BUG",
    75|
    76|      "primaryLocation": {
    77|
    78|        "filePath": "/home/sseverin/nc/github/marvin/frontend/src/components/TeacherSingleSkill/TeacherSingleSkill.tsx",
    79|
    80|        "message": "Links must have discernible text",
    81|
    82|        "textRange": {
    83|
    84|          "startLine": 163,
    85|
    86|          "endLine": 163,
    87|
    88|          "startColumn": 24,
    89|
    90|          "endColumn": 26
    91|
    92|        }
    93|
    94|      }
    95|
    96|    },
    97|
    98|    ....
    99|
   100|  ]
   101|
   102|}
   103|```
   104|
   105|You can get a summary of the issues with a command like this:
   106|
   107|```
   108|jq -r '.issues | .[] | .primaryLocation.message' < axe-linter-report_a.json \
   109|
   110|    | sort | uniq -c | sort -n
   111|```
   112|
   113|## SpeechStream
   114|
   115|This third-party JavaScript library provides a bunch of accessibility tools embedded in the front end. See details here: [SpeechStream](https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/1862926337)
   116|
   117|## See also
   118|
   119|- [Incorporating Axe Accessibility DevTools into New Classrooms SDLC](https://newclassrooms.atlassian.net/wiki/spaces/QA/pages/1266843653) in the QA space
   120|
   121|See what's changed since your last visit
