---
description: A developer's daily journal about the job hunting journey from console.log to interviews, covering coding life, developer humor, and the grind of finding a tech job.
tags: ["codinglife", "developerjokes", "javascript", "jobhunt", "kidding", "notKidding", "pleaseHireMe"]
---


Hey there, tech fam! Luis here, your friendly neighborhood developer who's currently leveling up in JavaScript while navigating the wild west of job hunting. Before we dive into today's adventure, let's connect! Find me on [GitHub](https://github.com/almonteluis) where I'm pushing code like it's hot 🔥, or let's network on [LinkedIn](https://www.linkedin.com/in/almonteluis92/) - because who doesn't love a good professional slide into the DMs? 

(Seriously though, hit that follow button - I promise my commit messages are more entertaining than my bug fixes! 😅)

## The Job Hunt Saga Continues

You know that feeling when you're sending out job applications like you're throwing spaghetti at a wall? Today I went full Italian chef and threw out FIVE applications! We're talking some serious heavy hitters here - Marriott (where a lovely recruiter named Marian slid into my DMs), Datadog (woof woof!), Tasty (because who doesn't want to work for a company that makes you hungry every time you check their website?), and Parsley Health (keeping it healthy, folks!).

But hey, a dev's gotta code while the applications do their thing, right?

## Meanwhile, in JavaScript Land...

So, while my applications were flying through the digital ether, I dove deep into building a Blackjack game on Scrimba. And let me tell you, it was more intense than explaining to my mom why I can't fix her printer remotely.

Here's a taste of what I was cooking up:

```javascript
let hasBlackJack = false
let isAlive = true
let message = ""

function getRandomCard() {
    let randomNumber = Math.floor(Math.random() * 13) + 1
    if (randomNumber === 1) {
        return 11
    } else if (randomNumber > 10) {
        return 10
    } else {
        return randomNumber
    }
}
```

Look at that beautiful random card generator! It's like a slot machine, but instead of losing money, you're losing your sanity trying to debug why your cards keep adding up to 57. 😅

The coolest part? Learning about arrays and loops. Check this bad *boy* out:

```javascript
let cards = []
function renderGame() {
    cardsEl.textContent = "Cards: "
    for (let i = 0; i < cards.length; i++) {
        cardsEl.textContent += cards[i] + " "
    }
}
```

Fun fact: I spent way too long wondering why my cards weren't showing up, only to realize I'd forgotten to call the function. Classic developer moment, am I right? 🤦‍♂️

## The Networking Dance

Between coding sessions, I did what every job seeker dreads - networking. *shudders dramatically* But hey, it wasn't that bad! Reached out to two recruiters, and like a boomerang made of opportunity, one actually came back! That's what I call a successful day in the networking wilderness.

## What's Next?

Tomorrow's agenda: Debug my life choices... just kidding! (kind of). Actually planning to dive deeper into the Blackjack game and maybe add some spicy features. Thinking about adding a "Card Counting for Dummies" feature - just kidding, casino security, if you're reading this! 😉

## The Takeaway

Today taught me that building a Blackjack game is surprisingly similar to job hunting - sometimes you win, sometimes you lose, and sometimes you have to know when to hold 'em and know when to fold 'em. But hey, at least in JavaScript, we can always do a quick refresh() when things go south!

Until next time, keep coding, keep applying, and remember: if your code doesn't work, try turning it off and on again. If that fails, coffee. Always coffee.

P.S. If any recruiters are reading this - yes, I am way more professional in interviews. Unless you like developers with a sense of humor, in which case... *finger guns* 👉👉


#codinglife #jobhunt #javascript #developerjokes #pleaseHireMe #kidding #notKidding