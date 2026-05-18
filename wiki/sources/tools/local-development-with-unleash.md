---
description: "Guide to setting up local Unleash server with Docker, importing/exporting flags, and connecting frontend"
tags: ['research', 'marvin', 'new-classrooms']
raw_file: "Local Development with Unleash.md"
created: 2026-05-17
---

# Clone Unleash Locally and Run the Server

To develop feature-flagged code, the best way to start is by using a local Unleash Server running in a docker container. This way you can get the flag details from the Product Owner who created the ticket(s) for the work and then have a local version of the flag that you can force on and off or force particular variants of on and off. Setting up the Unleash Server locally is very simple. Here’s the instructions from the Unleash README. Do what it says and you’ll have your very own Unleash Server up and running in no time! (Remember that docker has to be running in the background, I somehow forget this more often than I should)

```
To set up Unleash locally, you'll need [`git`](https://git-scm.com/)  and [`docker`](https://www.docker.com/) installed on your machine.  Execute the following commands:  ```bash git clone git@github.com:Unleash/unleash.git cd unleash docker compose up -d 

```  Then point your browser to `localhost:4242` and log in using:  - username: `admin` - password: `unleash4all`
```

Now you have a local Unleash Server running! Next, you’ll want to make or import a flag configuration

# Setting Up the Flag for Local Development

If you’re working on a feature flagged feature, then it’s very likely that the Product Owner who created the ticket for it has already set up a flag in the Unleash Enterprise server. You can ask them--politely--to export the flag they have set up. If they don’t know how to do that, you can point them here!

## Exporting feature flags from Unleash
![[Pasted image 20260304111458.png]]

1. Go to the default project page where all the flags live
    
2. Select the checkbox(es) next to the flag(s) you want to export (a little modal should pop up, see picture)
    
3. Click the export button in the modal. This should bring up the following dialog
    ![[Pasted image 20260304111507.png]]

4. Pick the environment where you set up the strategy for the experiment
    
5. Hit export
    

This will download the flag configuration as a JSON so you can share it!

## Importing Flags

Alright, now you’ve got Unleash running locally and you’ve got a flag configuration that someone--probably a Product Owner--sent to you, what now? All you have to do is import the flag.
![[Pasted image 20260304111517.png]]

1. Go to the Projects page (select default project)
    
2. Hit the import button (see image above)
    
3. Select an environment to import it into. On your local Unleash instance, pick “development” or “production” it doesn’t really matter when working locally.![[Pasted image 20260304111536.png]]
    
4. Hit Validate.
    
5. Assuming you imported a valid flag configuration, you’ll get a final page where you can hit “Import Configuration”
    

Voila! The flag is now in your local unleash server and ready for you to use in feature development.
![[Pasted image 20260304111546.png]]

## Connecting the Frontend to the Local Unleash Server

Great! You’ve got the flag imported, but how do you actually use it. You’ll need to set up your Marvin .env file with the environment variables to connect with your local Unleash Server through the API.

You should already have a .env file in the frontend folder in the marvin project: _marvin\frontend\.env_

If not, you should go check out the documentation on setting up localhost here: [https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/2130223](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/2130223)

Assuming you do have the .env file in the frontend. you’ll want to add these two lines to it:  

`VITE_UNLEASH_URL = http://localhost:4242/api/ VITE_UNLEASH_CLIENT_KEY = YOUR_KEY` 

“But wait!” you say, “I don’t have a key!”

Don’t worry, I’ve got you.

1. Make sure the Unleash docker container is running locally.
    
2. Go to [http://localhost:4242](http://localhost:4242) in your browser
    
3. click Admin Settings ![[Pasted image 20260304111634.png]]
    
4. Click Access control > API access ![[Pasted image 20260304111641.png]]
    
5. copy the frontend api token to your clipboard ![[Pasted image 20260304111657.png]]
    
6. paste that into _marvin\frontend\.env_
    

And Presto! You’ve got environment variables you can use in the frontend that will connect you to the local unleash server.
