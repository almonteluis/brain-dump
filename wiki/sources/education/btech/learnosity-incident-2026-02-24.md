---
description: "- [Overview](https://newclassrooms.atlassian.net/wiki/spaces/DEV/pages/1673625601/Learnosity+incident+2026-02-24#Overview)"
tags: ['research', 'marvin', 'new-classrooms']
raw_file: "Learnosity incident 2026-02-24.md"
created: 2026-05-17
---

- [Overview](https://newclassrooms.atlassian.net/wiki/spaces/DEV/pages/1673625601/Learnosity+incident+2026-02-24#Overview)
- [Status](https://newclassrooms.atlassian.net/wiki/spaces/DEV/pages/1673625601/Learnosity+incident+2026-02-24#Status)
- [Investigation](https://newclassrooms.atlassian.net/wiki/spaces/DEV/pages/1673625601/Learnosity+incident+2026-02-24#Investigation)
    - [Symptoms](https://newclassrooms.atlassian.net/wiki/spaces/DEV/pages/1673625601/Learnosity+incident+2026-02-24#Symptoms)
    - [Potential Paths investigated](https://newclassrooms.atlassian.net/wiki/spaces/DEV/pages/1673625601/Learnosity+incident+2026-02-24#Potential-Paths-investigated)
    - [Additional Info:](https://newclassrooms.atlassian.net/wiki/spaces/DEV/pages/1673625601/Learnosity+incident+2026-02-24#Additional-Info%3A)
        - [Long Term Support (LTS)](https://newclassrooms.atlassian.net/wiki/spaces/DEV/pages/1673625601/Learnosity+incident+2026-02-24#Long-Term-Support-\(LTS\))
    - [Re-cap/Follow-up notes:](https://newclassrooms.atlassian.net/wiki/spaces/DEV/pages/1673625601/Learnosity+incident+2026-02-24#Re-cap%2FFollow-up-notes%3A)

# Overview

Starting around 2026-02-19, the Learnosity Items API library version that our front end uses was removed from the Learnosity CDN. This library is used by all assessment types in _Roadmaps_. Due to the complex nature of CDN-based content delivery, this has only been sporadically affecting users.

We have no customer reports of the issue as of 2026-02-26T14:54 but are seeing the error show up for customers in Sentry in a way that is almost certainly disruptive to the experience.

The investigation has been complex, as we try different versions of the API to find one that works, and new issues seemingly not specific to our code keep coming up.

Learnosity support has been engaged and has started trying to help us with the issue.

Main tracking ticket: [https://newclassrooms.atlassian.net/browse/TEAMF-393](https://newclassrooms.atlassian.net/browse/TEAMF-393)

Learnosity support thread: [https://help.learnosity.com/hc/en-us/requests/29795](https://help.learnosity.com/hc/en-us/requests/29795 "https://help.learnosity.com/hc/en-us/requests/29795")

Sentry logs tracking this in prod: [https://new-classrooms.sentry.io/issues/?environment=plat-prod&groupStatsPeriod=24h&page=1&query="Failed loading Items API%2C can't load required modules"&referrer=issue-list&statsPeriod=30d](https://new-classrooms.sentry.io/issues/?environment=plat-prod&groupStatsPeriod=24h&page=1&query=%22Failed%20loading%20Items%20API%2C%20can%27t%20load%20required%20modules%22&referrer=issue-list&statsPeriod=30d "https://new-classrooms.sentry.io/issues/?environment=plat-prod&groupStatsPeriod=24h&page=1&query=%22Failed%20loading%20Items%20API%2C%20can%27t%20load%20required%20modules%22&referrer=issue-list&statsPeriod=30d")

For reference:

- [https://help.learnosity.com/hc/en-us/articles/17586388376477-Items-API-Release-Logs](https://help.learnosity.com/hc/en-us/articles/17586388376477-Items-API-Release-Logs "https://help.learnosity.com/hc/en-us/articles/17586388376477-Items-API-Release-Logs")
    
- [https://console.learnosity.com/module/management/consumers/0454/edit](https://console.learnosity.com/module/management/consumers/0454/edit "https://console.learnosity.com/module/management/consumers/0454/edit")
    

# Status

Luis pinned our version specifically to **v1.132.3** within the **v2025.1.LTS** release. This matches Learnosity’s verified logs and restores connectivity.

**How this differs from previous attempts (from Luis):**

- **Version Boundary identified:** I've explored a branch from Steve that updated to latest. My debugging confirmed that latest (and even **v2025.2.LTS** and higher) pulls in changes that cause the **inference engine to hang** on the post-diagnostic screen.
    
- **LTS Branch Selection:** **v2025.1.LTS** is currently the only stable version that resolves the 404 errors without triggering the diagnostic loading bug.
    
- **Preventing "Bleeding Edge" Regressions:** By moving away from the latest tag and explicitly targeting the **v2025.1** branch, we ensure we aren't pulling in developer versions or newer LTS branches that haven't been fully vetted for our inference engine compatibility.
    

# Investigation

## Symptoms

1. With the latest release in prod, `release-150`, unable to see any Learnosity content, including skill assessments, practice problems, diagnostics, or exit slips. This is caused by the Items API version we’re using being 404. Learnosity is aware of this and considers our usage of that version unsupported. **We have not yet asked if they could just restore that version** (`https://items.learnosity.com/v1.132.1/dist/api.js`), b==ut it seems unlikely.==
    
2. With the most recent v2025.1.LTS, a diagnostic “hang tight” screen indefinitely. This was traced back to the final item on the diagnostic missing ability_estimate and standard_error fields that the Learnosity Result Fetcher requires in order to save the result and trigger further processing. **We could potentially alter the LRF to ignore bad items**, but it has academic implications that are not good.
    
3. `Invalid domain` sporadically happening. This is the newest issue and seems to be happening on all versions we try. This will cause the Learnosity player to randomly fail. See #4 below. **Learnosity support has been informed** but has not written back yet.
    
4. Allowlist for dev consumer was briefly blank in the Learnosity console. After adding `*.ttoworks.net` to the blank list, the full list we have came back, but only after a page refresh ~10 minutes later. Historically this has been ignored anyway (see [Learnosity Access | Allow list domains](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/43057209/Learnosity+Access#Allow-list-domains)), but it could be an issue now.
    
5. Marcos’s Learnosity API keys seem to not be working. Chris is rotating keys, but Marcos has confirmed his keys are correct.
    

## Potential Paths investigated

- Asking Learnosity to restore the archived `v1.132.1` version.
    
- Using the sort-of-good version we have but updating LRF to ignore bad items.
    
- Trying to upgrade all the way to v2025.3.LTS, either just for the front end or across the stack (preferably).
    
    - Tried to bump the version to v2025.2.LTS+ but ran into an issue where the post diagnostic loading screen hanging indefinitely.
        
- Getting more information from Learnosity about the “Invalid domain” and allowlist issues.
    
- Confirmed working on the **deer** environment. Dan and I (Luis) manually tested Learnosity features end-to-end — successfully submitted a diagnostic and reached the home page, then completed several skill assignments which loaded and submitted without error. Learnosity Item API is currently on **v2025.1.LTS (1.132.3)**.
    

## Additional Info:

### **Long Term Support (LTS)**

Every four months, Learnosity releases a major milestone release, to better match our customers’ development cadence. Every **February**, **June** and **October,** we release production-ready versions of our APIs that will be supported for two years. This applies across all of our [core APIs](https://help.learnosity.com/hc/en-us/articles/360000754578-Recommended-Deployment-Patterns-Golden-Path- "https://help.learnosity.com/hc/en-us/articles/360000754578-Recommended-Deployment-Patterns-Golden-Path-"). [(Learnosity Release Cadence)](https://help.learnosity.com/hc/en-us/articles/360001268538-Release-Cadence-and-Version-Lifecycle#:~:text=Support%20\(LTS\)%20version.-,Long%20Term%20Support%20\(LTS\),two%20years.%20This%20applies%20across%20all%20of%20our%C2%A0core%20APIs.,-Long%20Term%20Support "https://help.learnosity.com/hc/en-us/articles/360001268538-Release-Cadence-and-Version-Lifecycle#:~:text=Support%20(LTS)%20version.-,Long%20Term%20Support%20(LTS),two%20years.%20This%20applies%20across%20all%20of%20our%C2%A0core%20APIs.,-Long%20Term%20Support") Good thing to know when issues arises.

## Re-cap/Follow-up notes:

- Still unclear about what caused the issue
    
    - Result of using a lot of 3rd party code
        
- Learnosity published new versions AND removed old versions
    
    - The issue for us occurred because of the removal of an old version
        
- We’ll need a process for staying actively on top of version updates - specifically when the are ARCHIVING a version (we don’t care about new version)
    
    - Monthly? Sprintly?
        
    - Can learnosity give us notifications about updating versions? Subscription?
        
        - Webpage monitoring -> slack notification?
            
- We are not using their LTS version - we have self-hosted version
    
    - this allows us to NOT get automatic version updates, so it also doesn’t allow and automatic ARCHIVING of versions.
        
    - not using their [FE logging library (rollbar)](https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/872251393/Sentry#Learnosity-%2F-Rollbar-conflict "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/872251393/Sentry#Learnosity-%2F-Rollbar-conflict") - duplicate events
        
        - Already a support ticket for Learnosity to disable this
