---
description: "Post Mortem: axios npm supply chain compromise Date: March 31, 2026 Author: Jason Saayman Status: Remediation in progress On March 31, 2026,"
tags: ['research']
source: "https://github.com/axios/axios/issues/10636"
raw_file: "Post Mortem axios npm supply chain compromise · Issue 10636 · axiosaxios.md"
created: 2026-05-17
---

**Date:** March 31, 2026  
**Author:** Jason Saayman  
**Status:** Remediation in progress

On March 31, 2026, two malicious versions of axios (1.14.1 and 0.30.4) were published to the npm registry through my compromised account. Both versions injected a dependency called `plain-crypto-js@4.2.1` that installed a remote access trojan on macOS, Windows, and Linux.

The malicious versions were live for about 3 hours before being removed.

## Are you affected?

Check your lockfile:

```shell
grep -E "axios@(1\.14\.1|0\.30\.4)|plain-crypto-js" package-lock.json yarn.lock 2>/dev/null
```

If anything comes back, treat that machine as compromised:

1. Downgrade to `axios@1.14.0` (or `0.30.3` for 0.x users)
2. Delete `node_modules/plain-crypto-js/`
3. Rotate every secret, token, and credential on that machine
4. Check your network logs for connections to `sfrclak[.]com` or `142.11.206.73` on port 8000
5. If this happened on a CI runner, rotate any secrets that were injected during the affected build

If you were already pinned to a clean version and didn't run a fresh install between 00:21 and 03:15 UTC on March 31, you're fine.

For detailed remediation guidance, including CI/CD-specific steps, see:

- [StepSecurity: full technical analysis and remediation](https://www.stepsecurity.io/blog/axios-compromised-on-npm-malicious-versions-drop-remote-access-trojan)
- [Snyk: advisory and scanning guidance](https://snyk.io/blog/axios-npm-package-compromised-supply-chain-attack-delivers-cross-platform/)
- [Socket: Supply Chain Attack on Axios Pulls Malicious Dependency from npm](https://socket.dev/blog/axios-npm-package-compromised)

## What happened

The attacker gained access to the lead maintainer's PC through a targeted social engineering campaign and RAT malware. This gave them access to the npm account credentials, which they used to publish the malicious versions.

The attack followed patterns documented in similar campaigns targeting open source maintainers.

## Resolution

Complete wipe of all lead maintainer devices as well as resetting of all credentials. This includes all accounts irrespective of platform, both personal and all other capacities.

## What's changing

To prevent this from happening again, these are the changes being made:

| Action | Type |
| --- | --- |
| Reset of all devices and credentials | Prevention |
| Immutable release setup | Prevention |
| Proper adoption of OIDC flow for publishing | Prevention |
| Improvement of overall security posture | Prevention |
| Updating of all GitHub actions to adopt best practices | Prevention |

This list is not the end. We will continue actively working on improving security beyond these items.

## Attack Timeline

I don't have an exact timeline for when the initial compromise occurred, but this is the sequence of events for the package itself:

- About 2 weeks before March 31: social engineering campaign initiated against the lead maintainer
- March 30, 05:57 UTC: `plain-crypto-js@4.2.0` published to npm
- March 31, 00:21 UTC: `axios@1.14.1` published with `plain-crypto-js@4.2.1` injected
- March 31, around 01:00 UTC: `axios@0.30.4` published with the same payload
- March 31, around 01:00 UTC: first external detections
- March 31, around 01:00 UTC: community members file issues reporting the compromise. The attacker deletes them using the compromised account.
- March 31, 01:38 UTC: axios collaborator DigitalBrainJS opens PR [chore(ci): add deprecate action; #10591](https://github.com/axios/axios/pull/10591) to deprecate the compromised versions, flags the deleted issues to the community, and contacts npm directly
- March 31, 03:15 UTC: malicious versions removed from npm
- March 31, 03:29 UTC: `plain-crypto-js` removed from npm

For detailed technical timelines:

- [StepSecurity: forensic timeline](https://www.stepsecurity.io/blog/axios-compromised-on-npm-malicious-versions-drop-remote-access-trojan)
- [Datadog Security Labs: full attack flow and response analysis](https://securitylabs.datadoghq.com/articles/axios-npm-supply-chain-compromise/)

## Lessons learned

We are actively investigating how unauthorized access was obtained and reviewing all aspects of our security posture and access controls. While we do not have confirmed details to share at this time, this incident reinforces the need for continuous monitoring, strong account protections, and vigilance across both project infrastructure and individual maintainer environments.

We will continue to strengthen our practices in alignment with industry best practices and in collaboration with groups such as the OpenJS Security Working Group.

Security posture should be continuously monitored and improved. Specifically from this incident:

- Publishing directly from a personal account was a risk that could have been avoided. The OIDC flow and immutable release setup we are now adopting should have been in place before this happened.
- There was no automated way to detect an unauthorized publish. Detection depended entirely on the community noticing.
- Open source maintainers with high-impact packages are active targets for sophisticated social engineering. Hyper vigilance is needed both on the registry and in a personal capacity.

## Summary for broarder audience

We can confirm that two compromised versions of Axios were briefly made available through a widely used software download system due to unauthorized access to the lead maintainer's account, not a change to the underlying code.

We are working with the companies that operate this system, along with security experts, to investigate and contain the issue. Organizations that installed these versions should remove them immediately and treat affected systems as potentially compromised, including rotating any sensitive credentials.

This was the result of a compromised lead maintainer's account, and we are actively investigating how access was obtained. We do not have confirmed details to share at this time.

## Acknowledgments

Thanks to [@DigitalBrainJS](https://github.com/DigitalBrainJS) for acting fast when the compromised account had higher permissions than his own and for getting npm to take action. Thanks to Open Source Community and the npm security team for their fast response.

The malicious versions have been removed from npm and are no longer infecting users. The immediate incident is resolved. We are actively working on the security improvements listed above to prevent this from happening again.

I'll update this as the investigation progresses. Questions welcome in this thread.

---

## Comments

> **RoseSecurity** · 2026-04-02
> 
> Thanks for your transparency throughout this. It's not fun, but glad to see the security posture improving as a result and I think these are really important lessons that we should take as an open source community.

> **corneliusroemer** · 2026-04-02
> 
> Thanks for the writeup. Most of the stuff you mention here is already public knowledge. Would be great if you could add things that aren't publicly known yet. In particular, could you go into more detail on how they attacked you? This is still quite vague:
> 
> > About 2 weeks before March 31: social engineering campaign initiated against the lead maintainer
> 
> How did they trick you? What were the red flags in retrospect?
> 
> > This gave them access to the npm account credentials, which they used to publish the malicious versions.
> 
> How did they take over npm credentials? Didn't you have mandatory 2FA? Npm claims that all big packages have mandatory 2FA enabled. How did they circumvent that?

> **DanielRuf** · 2026-04-02
> 
> > How did they take over npm credentials? Didn't you have mandatory 2FA? Npm claims that all big packages have mandatory 2FA enabled. How did they circumvent that?
> 
> As far as I read in the original thread, they had an infostealer on their computer. Some company asked to work together and in the end it was one of the attackers posing as some other company trcking the maintainer into installing software.
> 
> Well, even the lastest of my followers seem to be such sock puppet accounts which try to create some fake identity with a huge amount of fake GitHub activity and then probably use that to trick others into beliebing to be some professional developer from some big company.
> 
> Currently there are also many job offers, where they ask you to install specific software as part of the job interview.

> **feross** · 2026-04-02
> 
> Thanks for the thorough post-mortem, Jason. Writing one of these is never easy, and the transparency here is exactly what the ecosystem needs.
> 
> A few things worth highlighting for others reading this:
> 
> The response was fast. ~3 hours from publish to removal is a good outcome given the constraints. [@DigitalBrainJS](https://github.com/DigitalBrainJS) in particular deserves recognition for acting decisively.
> 
> For maintainers of high-download packages, this incident reinforces a few things we'd recommend:
> 
> 1. OIDC-based publishing (provenance attestation) is the single highest-leverage change you can make. It removes long-lived credentials from the equation entirely. Glad to see this is on the roadmap.
> 2. Publish from CI, not from a local machine. If a maintainer's laptop is compromised, the blast radius shouldn't include the ability to push a release.
> 3. Enable npm's mandatory 2FA for publish, and use a hardware key if possible. TOTP on a compromised machine is not 2FA.
> 
> We detected the malicious `axios@1.14.1` and `axios@0.30.4` versions within minutes of publication and blocked it for users with the [AI Detected Potential Malware](https://socket.dev/alerts/gptMalware) alert enabled. Thanks for sharing our [analysis](https://socket.dev/blog/axios-npm-package-compromised).
> 
> This kind of targeted social engineering against individual maintainers is the new normal. It's not a reflection on Jason or the axios team -- these campaigns are sophisticated and persistent. We're seeing them across the ecosystem and they're only accelerating.
> 
> Wishing you and the team the best as you work through the remaining security work here. The npm ecosystem is better for having maintainers who respond like this.

> **browner12** · 2026-04-02
> 
> Remember to include your appropriate lock file in the `grep` command, as the current list is not exhaustive. For example,
> 
> ```shell
> grep -E "axios@(1\.14\.1|0\.30\.4)|plain-crypto-js" package-lock.json yarn.lock bun.lock pnpm-lock.yaml 2>/dev/null
> ```
> 
> or maybe even better, just check all lock files
> 
> ```shell
> grep -E "axios@(1\.14\.1|0\.30\.4)|plain-crypto-js" *.lock 2>/dev/null
> ```

> **jasonsaayman** · 2026-04-02
> 
> to answer the NPM question. i have been told that once the RAT is on your machine they have full unilateral control of everything on your machine (you can google more about this). i therefore presume they could do anything once they have that. and yes i did have 2fa enabled on my account.

> **voxpelli** · 2026-04-02
> 
> I had a similar incident a few weeks back where someone invited me to a podcast a week later and then invited me into a group with others who would be interviewed in the same podcast episode and then got social media images and preparatory interview questions only to then when we were about to record the podcast they faked a connection issue on a fake version of a streaming website to try to get me to install a non-notarized native app on my Mac (which I later identified as having an info stealer).
> 
> Thankfully I was paranoid and didn’t run it, but it’s creepy how they target you, no matter if they are real people or possibly AI. (When it became clear that I wouldn’t run the app and we had chatted back and forth on website and chat app they made one final desperate attempt and tried to get me to run a curl command that would download and run something, then when I refused they went dark and deleted all conversations)
> 
> My guess is that they wanted access to Mocha or such.

> **bcomnes** · 2026-04-02
> 
> [@jasonsaayman](https://github.com/jasonsaayman) It would be helpful if you are willing, to share more of the social engineering playbook that they hit you with. Often its re-used even if its highly targeted at an individual.
> 
> By sharing more of the social engineering details you can help damage any construct infrastructure they used, strategies and tools used, and generally help people in the future with pattern recognition when they are being targeted.

> **ahmadnassri** · 2026-04-02
> 
> thanks for the write up [@jasonsaayman](https://github.com/jasonsaayman) 👏
> 
> beyond the advise listed, worth highlighting for folks:
> 
> - `npx` invocations produce a non-deterministic depedncy resolution at run-time, no package-lock trace. (even if you're not using `@latest`)
> - if your using `npx` in your CI / MCP with a package that directly or indirectly uses axios with semver range that could have resolved to `v1.14.1` / `v.0.30.4` during the ~3 hour window, you have likely downloaded `plain-crypto-js`
> 	- sadly, most CI & MCP tooling setup docs, always advise to simply run: `npx <package>@latest`
> - check the network logs in your CI during those times.
> - `npx` call hardening with pre-install + lock file generation + using `--no --offline`
> 	- full technical details here: [https://socket.dev/blog/hidden-blast-radius-of-the-axios-compromise](https://socket.dev/blog/hidden-blast-radius-of-the-axios-compromise)

> **jasonsaayman** · 2026-04-02
> 
> [@bcomnes](https://github.com/bcomnes) yeah sure. i understand and will share how they do the attack.
> 
> so the attack vector mimics what google has documented here: [https://cloud.google.com/blog/topics/threat-intelligence/unc1069-targets-cryptocurrency-ai-social-engineering](https://cloud.google.com/blog/topics/threat-intelligence/unc1069-targets-cryptocurrency-ai-social-engineering)
> 
> they tailored this process specifically to me by doing the following:
> 
> - they reached out masquerading as the founder of a company they had cloned the companys founders likeness as well as the company itself.
> - they then invited me to a real slack workspace. this workspace was branded to the companies ci and named in a plausible manner. the slack was thought out very well, they had channels where they were sharing linked-in posts, the linked in posts i presume just went to the real companys account but it was super convincing etc. they even had what i presume were fake profiles of the team of the company but also number of other oss maintainers.
> - they scheduled a meeting with me to connect. the meeting was on ms teams. the meeting had what seemed to be a group of people that were involved.
> - the meeting said something on my system was out of date. i installed the missing item as i presumed it was something to do with teams, and this was the RAT.
> - everything was extremely well co-ordinated looked legit and was done in a professional manner.

> **bcomnes** · 2026-04-02
> 
> [@jasonsaayman](https://github.com/jasonsaayman) thank you!
> 
> If there are specific personas/accounts/contacts that are still active that were used in the attack, my suggestion would be to archive as much as possible and then publicly identify the personas/constructs, even if its a construct of a real person (clarify the attacker != the person used) otherwise the attacker can continue to use the account as long as they think they can derive value from it.
> 
> I don't know what kind of constraints you are under though so if you do not I assume you have good reason not to share.

> **jasonsaayman** · 2026-04-18
> 
> Since no comments have been made in about a week, I am going to close this issue. If anyone would like me to reopen this, I am happy to do so. Just reach out to me.

> **MuyembeII** · 2026-04-20
> 
> Thank you Jason! Keep going 💪🏾

> **DigitalBrainJS** · 2026-04-21
> 
> [@asrarmared-ship-it](https://github.com/asrarmared-ship-it) We would greatly appreciate it if you could refrain from posting lengthy messages. If you want to share something related to the topic, use external links.
