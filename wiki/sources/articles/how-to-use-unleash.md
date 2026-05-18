---
description: "Introduction to Unleash feature flag hierarchy, naming conventions, and lifecycle management"
tags: ['research', 'marvin', 'new-classrooms']
raw_file: "How to Use Unleash.md"
created: 2026-05-17
---

You should watch this great [introductory video](https://www.youtube.com/watch?v=slBX470IiaI) put out by unleash. It's about 45 minutes long and covers how Unleash is architected and it's nomenclature and organization.

I’m going to assume you’ve watched the video now, because it really is worth a watch.

By now, you should understand that Unleash organizes feature flags using the following hierarchy:

- Projects (we only have one project for Roadmaps)
    
    - Environments (development, QA, production)
        
        - Flags - the thing you enable or disable. Disabled should always deliver the standard LTS Roadmaps version of the feature.
            
            - Constraints - a way to target your flag to users who meet particular criteria
                
            - Variants - flavors of the altered experience (new icon with border, new icon without border)
                

# The Feature Flag Life-Cycle

We use Unleash Enterprise, which means we don’t have to host our own feature flag servers!

## How Feature Flags are Born

A feature flag is created when we need the flexibility to turn a feature on and off without redeploying code. Most commonly this will be driven by a design effort led by a Project Manager. The Project Manager will identify wither their team which experiment(s) they want to run and decide what feature flags need to be set up through the [Unleash admin interface](https://app.unleash-hosted.com/sign-in).

![[Pasted image 20260304111029.png]]
## Naming Convention

Flags should have unique names that are highly unlikely to repeat. We recommend, like branches, using the ticket name associated with the experiment and a plain, short descriptor for the feature being tested.

examples:

TEAME-124-square-icon

TEAMX-####-short-description

Flags for long-term support features are inverted (LTS feature is the default state, old experience is the flagged state) and should have “LTS-shutoff” in the name after the ticket number. E.g.

TEAME-123456-LTS-shutoff-new-skill-challenges

## The Life of a Feature Flag

Since the feature flag is generally meant to run an experiment, during the course of its life it will be turned on, data will be collected, and then it will be turned off and decommissioned. It may also have it’s rollout adjusted so that a different proportion of the user base will see it.

## Feature Flag Retirement

At a certain point, the feature flag has served its purpose. Perhaps it successfully invalidated a hypothesis or it gradually rolled out a trial feature. Whatever the case, every feature flag comes to an age where it can retire. This means that we have to go into the code and remove the feature flag. Typically, this means that we’re either:

- Removing the code for an experiment altogether.
    
- Converting an LTS rollout to a permanent feature.
    

In our avatar icon example, maybe we find out that changing to a square results in a 2x increase in clicks. Maybe that’s desirable for some reason. So we’ve determined we want to switch from circle icon to square. That will require tickets for each of the following pieces of work:

- Removing the experimental code (and corresponding references to the flag it sat behind).
    
- Engineering the feature properly for Long Term Support (in most cases, we suggest starting from scratch, since experimental code will tend to be built for the purpose of quickly getting answers, not for being maintainable). This will be released under an LTS flag.
    
- After several months of stable performance (say, 3, but it’s not a strict requirement), the LTS flag can be removed and the feature becomes unflagged and permanent.
    

Unleash recommends archiving old feature flags, and I don’t have a strong reason to disagree with them at this point, so I think that’s what we should do.
