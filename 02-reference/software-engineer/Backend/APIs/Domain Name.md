---
description: Domain names explained including TLDs, labels, subdomains, WHOIS lookup, and the relationship to DNS and IP addresses.
tags: ["label_or_component"]
---

# Domain Names

## Overview

## DNS

>A domain name is a human-readable address used to identify and access websites on the internet. It serves as a more memorable alternative to the numerical IP addresses that computers use to locate web servers. Domain names consist of two main parts: the second-level domain (usually the website or organization name) and the top-level domain (such as .com, .org, or .net). They are registered through domain registrars and must be unique within their top-level domain. Domain names are crucial for branding, marketing, and establishing an online presence. The Domain Name System (DNS) translates domain names into IP addresses, allowing users to access websites by typing in familiar names rather than complex number sequences. Domain names can be customized, transferred, and renewed, playing a vital role in the structure and [[Accessibility]] of the World Wide Web.

[TLD](https://developer.mozilla.org/en-US/docs/Glossary/TLD) (Top-Level Domain).

TLDs tell users the general purpose of the service behind the domain name. The most generic TLDs (`.com`, `.org`, `.net`) don't require web services to meet any particular criteria, but some TLDs enforce stricter policies so it is clearer what their purpose is. For example:

- Local TLDs such as `.us`, `.fr`, or `.se` can require the service to be provided in a given language or hosted in a certain country — they are supposed to indicate a resource in a particular language or country.
- TLDs containing `.gov` are only allowed to be used by government departments.
- The `.edu` TLD is only for use by educational and academic institutions.

TLDs can contain special as well as latin characters. A TLD's maximum length is 63 characters, although most are around 2–3.

The full list of TLDs is [maintained by ICANN](https://www.icann.org/resources/pages/tlds-2012-02-25-en).

[Label (or component)](https://developer.mozilla.org/en-US/docs/Learn_web_development/Howto/Web_mechanics/What_is_a_domain_name#label_or_component)

The labels are what follow the TLD. A label is a case-insensitive character sequence anywhere from one to sixty-three characters in length, containing only the letters `A` through `Z`, digits `0` through `9`, and the '-' character (which may not be the first or last character in the label). `a`, `97`, and `hello-strange-person-16-how-are-you` are all examples of valid labels.

The label located right before the TLD is also called a _Secondary Level Domain_ (SLD).

A domain name can have many labels (or components). It is not mandatory nor necessary to have 3 labels to form a domain name. For instance, [informatics.ed.ac.uk](https://informatics.ed.ac.uk/) is a valid domain name. For any domain you control (e.g. [mozilla.org](https://www.mozilla.org/en-US/)), you can create "subdomains" with different content located at each, like [developer.mozilla.org](https://developer.mozilla.org/), [support.mozilla.org](https://support.mozilla.org/), or [bugzilla.mozilla.org](https://bugzilla.mozilla.org/).

#### Finding an available domain name

To find out whether a given domain name is available,

- Go to a domain name registrar's website. Most of them provide a "whois" service that tells you whether a domain name is available.
    
- Alternatively, if you use a system with a built-in shell, type a `whois` command into it, as shown here for `mozilla.org`:
    
    bashCopy to Clipboard
    
    ```
    whois mozilla.org
    ```
    
    This will output the following:
    
    Domain Name:MOZILLA.ORG
    Domain ID: D1409563-LROR
    Creation Date: 1998-01-24T05:00:00Z
    Updated Date: 2013-12-08T01:16:57Z
    Registry Expiry Date: 2015-01-23T05:00:00Z
    Sponsoring Registrar:MarkMonitor Inc. (R37-LROR)
    Sponsoring Registrar IANA ID: 292
    WHOIS Server:
    Referral URL:
    Domain Status: clientDeleteProhibited
    Domain Status: clientTransferProhibited
    Domain Status: clientUpdateProhibited
    Registrant ID:mmr-33684
    Registrant Name:DNS Admin
    Registrant Organization:Mozilla Foundation
    Registrant Street: 650 Castro St Ste 300
    Registrant City:Mountain View
    Registrant State/Province:CA
    Registrant Postal Code:94041
    Registrant Country:US
    Registrant Phone:+1.6509030800
    

As you can see, I can't register `mozilla.org` because the Mozilla Foundation has already registered it.