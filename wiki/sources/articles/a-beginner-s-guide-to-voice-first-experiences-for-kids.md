---
description: "Voice technology offers education publishers, toy and game developers new avenues and approaches to creating immersive learning and play experiences"
tags: ['research']
source: "https://www.mojo-nation.com/beginners-guide-voice-first-experiences-kids/"
raw_file: "A beginner's guide to voice-first experiences for kids.md"
created: 2026-05-17
---

**Voice technology offers education publishers, toy and game developers new avenues and approaches to creating immersive learning and play experiences for kids.**

From working closely with our clients, SoapBox Head of UX Declan Moore and Senior Software Engineer Ronan Tumelty see these voice-driven experiences come to life on a first-hand basis.

In this Beginner’s Guide, Declan and Ronan walk us through a sample use case for speech recognition in a kids’ app and share some of the lessons and best practices they’ve learned working with clients to design and integrate voice experiences into their apps, tools, and games for kids.

Product managers, designers and engineers all aim to create experiences that work seamlessly for kids, and bring them confidence, joy and engagement. But, interactive voice experiences are still brand new and our understanding of what actually works for kids is not a one-size-fits-all exercise. It’s still very much evolving.

**Voice interactions, although intuitive, are still new to a lot of people.**

This Beginner’s Guide is written for those who aspire to create and deliver great voice experiences for kids online, offline and on-device.

**3 Core Concepts:**

**1\. Voice-First Experiences**  
A “voice-first” or “voice-led” experience is when a child uses their voice as the primary means of interacting. This is distinct from a “voice-only” experience – think screenless smart speakers like Siri or Alexa, where there is little or no UI.

**2\. Input and Outputs**  
In a voice-first learning or play experience for kids — be it a tool, toy or game experience — voice is rarely used in isolation. Other interfaces are also leveraged like physical buttons, touch screens and sensors, that offer the designer a wide range of inputs or outputs to work with.

In the voice-first use case detailed below, the child is using a tablet. On an average tablet we can assume we have access to the following:

![SoapBox Labs](https://www.mojo-nation.com/files/2021/06/1..jpg)

**Making all of these inputs and outputs gel together and feel natural is key to the success of any kids’ voice experience.**

**3\. How Visuals Support Voice**  
While voice experiences come in many different shapes and sizes, there are a number of key considerations to take into account when designing for kids. In an interactive play experience on a tablet, for example, visuals provide context, clarity and direction. Visuals help a child to:

• Know when they can speak  
• Know when the system can hear them  
• Know when the system is taking action  
• See the results of the action

**A Sample App Experience**  
Let’s step through a sample App experience, and going forward, let’s refer to the product as the “App” and the user as the “child”. To deliver maximum clarity and immersion in this experience, kid-specific voice technology like the SoapBox voice engine is combined with third party voiceover, visuals and sound effects.

**The aim is to deliver an experience that doesn’t require the child to touch the screen once the game has started.**

In this example, the child is playing a reading game.

![SoapBox Labs](https://www.mojo-nation.com/files/2021/06/2-11.jpg)

**Step by Step:**  
1\. Present the experience  
2\. Starting the voice interaction  
3\. Show the App is listening  
4\. Let the child know they can be heard  
5\. Ending the voice interaction  
6\. The processing/thinking state (optional)  
7\. Providing feedback

---

**01\. Present the Experience**  
This is the default state of the experience. The Voice UI is in its “off” state

![SoapBox Labs](https://www.mojo-nation.com/files/2021/06/3-12.jpg)

---

**02\. Start the Voice Interaction**  
We then instruct the child on what to do. In this case we use an audio prompt.

![SoapBox Labs](https://www.mojo-nation.com/files/2021/06/4-13.jpg)

**Lessons:**  
– Simply asking a child to read may prompt them to read silently in their head. Be clear that they should read out loud by giving them audio or visual instructions, or both.  
– Ensure any audio – instructions, background music or sound effects – are complete before moving to the next step. Loud audio may impact the voice performance.

---

**03\. Show the App is listening**  
Give the child a cue that they can speak, that the App is ready. To communicate this clearly, we’ve scaled the UI, coupled with a color change.

![SoapBox Labs](https://www.mojo-nation.com/files/2021/06/5-9.jpg)

The blue circle with the dots symbol will by now be familiar to the child as we will have introduced it during the App on-boarding.

![SoapBox Labs](https://www.mojo-nation.com/files/2021/06/6-8.jpg)

**Lesson:** Be consistent with any UI element you choose. This use case is no different to a Home or Back button experience in a regular GUI.

---

**04\. Let the child know they can be heard**  
With a touch based UI interaction you can give feedback through physical, visual, auditory or animation cues. A “hands-free” experience doesn’t have those options but the feedback is just as important. In this example we’re using an audio reactive animation.

![SoapBox Labs](https://www.mojo-nation.com/files/2021/06/7-8.jpg)

The size of the white bars will react, in real-time, to the amplitude of the audio coming in from the mic. This signals to the child that the App is listening. Think of it as the digital equivalent of eye contact or nodding during a conversation.

**Lesson:** Strike a balance between input and UI. Make sure the child focuses on the text they are reading and is not distracted by the UI.

---

**05\. Ending the Voice Interaction**

![SoapBox Labs](https://www.mojo-nation.com/files/2021/06/8-5.jpg)

Once the child has finished speaking, we want to stop listening and score their audio. At that point, we need to show another visual cue to let them know the recording is stopping.

![SoapBox Labs](https://www.mojo-nation.com/files/2021/06/9-2.jpg)

**Lessons:**  
– If we do this immediately we’ll inadvertently cut off a child who wants to speak after a pause. To deliver more flexibility and ensure a positive experience, the UI needs to revert back to its “off” state.  
– Remember, we are still listening for speech, so if at any point the child starts to speak again, we need to immediately jump back to listening.

---

**06\. The processing/thinking state (optional)**

![SoapBox Labs](https://www.mojo-nation.com/files/2021/06/10-3.jpg)

Once the App has stopped listening for speech two things need to happen:

1\. Let the child know that they can not interact using their voice at this point.  
2\. If work needs to be done by the App before the child can interact again (processing of data, gamification calculations) we must show this.

To reduce the potential for frustration the child needs to understand that the App is “thinking” and that while thinking, speech isn’t available.

---

**07\. Provide Feedback**

![SoapBox Labs](https://www.mojo-nation.com/files/2021/06/11-1.jpg)

In this example, the SoapBox voice engine has scored the child’s reading attempt. The score set for “correct” is 70% and since the child has exceeded it the App plays celebratory/correct feedback.

**One of the most powerful things you can show a child is meaningful feedback. Showing them that their voice has determined the outcome is magical.**

---

**On Visual Metaphors**

![](https://www.mojo-nation.com/files/2021/06/12-1.jpg)

Voice Interfaces (VUIs) are still evolving. We haven’t yet reached a point of standardization, and different visuals may suit different interactions. So when testing your product give consideration to your visual cues. You and I may know what a microphone icon represents but will every 4, 5 or 8 year old?

**What’s Next?**

From the child’s perspective, they’ve just read a short sentence out loud and the App has reacted and fed back to them. Behind the scenes however, so much more is happening!

As an inventor, designer, or engineer involved in creating these kinds of experiences for kids, there remain so many questions, like:

• How do I know when to start listening?  
• When do I stop listening (or how long do I listen for)?  
• How do I score the child’s reading?

Do not fear! We’ll answer these and more in another piece soon, and following on from there, we’ll be sharing best practices around microphone usage, and how voice data can help with scoring and gamification of voice-first products.

**Get In Touch**  
Voice experiences for kids are as varied as the approaches we take to tackling them. At SoapBox we may be experts when it comes to speech recognition for kids, but we’re still at the beginning of an exciting journey of experimentation and learning when it comes to voice-first experiences for kids, and we’d love to keep learning as we help you with yours.

If you’d like to get in touch just email us: [Hello@SoapBoxLabs.com](mailto:Hello@SoapBoxLabs.com)

—

To stay in the loop with the latest news, interviews and features from the world of toy and game design, sign up to our weekly newsletter [here](https://www.mojo-nation.com)[SoapBox Labs](https://www.mojo-nation.com/tag/soapbox-labs/ "News in SoapBox Labs")

### More Recent Opinion

[

![](https://www.mojo-nation.com/wp-content/themes/mojo-nation/images/placeholders/350x200.png)

![Play-Doh, Hasbro](https://www.mojo-nation.com/files/2026/03/playdoh.jpg)

](https://www.mojo-nation.com/play-doh-at-70/ "Play-Doh at 70")

### [Play-Doh at 70](https://www.mojo-nation.com/play-doh-at-70/ "Play-Doh at 70")

Deej Johnson on the amazing origins of the world’s favourite compound.

[

![](https://www.mojo-nation.com/wp-content/themes/mojo-nation/images/placeholders/350x200.png)

![Nic Jones, SituAction](https://www.mojo-nation.com/files/2026/02/Nic-Jones.jpg)

](https://www.mojo-nation.com/from-creator-to-checkout-situactions-nic-jones-on-how-social-commerce-is-empowering-the-next-generation-of-innovators/ "From Creator to Checkout: SituAction’s Nic Jones on how social commerce is empowering the next generation of innovators")

### [From Creator to Checkout: SituAction’s Nic Jones on how social commerce is empowering the next generation of innovators](https://www.mojo-nation.com/from-creator-to-checkout-situactions-nic-jones-on-how-social-commerce-is-empowering-the-next-generation-of-innovators/ "From Creator to Checkout: SituAction’s Nic Jones on how social commerce is empowering the next generation of innovators")

SituAction’s Nic Jones looks at how the next great toy success story could begin not with a pitch, but with a post.

[

![](https://www.mojo-nation.com/wp-content/themes/mojo-nation/images/placeholders/350x200.png)

![Fi Murray, Making Things Studio](https://www.mojo-nation.com/files/2026/02/Fi-Murray.jpg)

](https://www.mojo-nation.com/making-things-studios-fi-murray-sheds-light-on-how-she-tackles-that-all-important-sizzle-video/ "Making Things Studio’s Fi Murray sheds light on how she tackles that all important sizzle video")

### [Making Things Studio’s Fi Murray sheds light on how she tackles that all important sizzle video](https://www.mojo-nation.com/making-things-studios-fi-murray-sheds-light-on-how-she-tackles-that-all-important-sizzle-video/ "Making Things Studio’s Fi Murray sheds light on how she tackles that all important sizzle video")

Making Things Studio’s Fi Murray on why today’s sizzle reels need to do much more than dazzle…

[

![](https://www.mojo-nation.com/wp-content/themes/mojo-nation/images/placeholders/350x200.png)

![Lee Allentuck](https://www.mojo-nation.com/files/2026/02/4-4-1.jpg)

](https://www.mojo-nation.com/the-plan-a-groups-lee-allentuck-on-how-to-build-your-creative-muscle/ "The Plan A Group’s Lee Allentuck on how to build your creative muscle")

### [The Plan A Group’s Lee Allentuck on how to build your creative muscle](https://www.mojo-nation.com/the-plan-a-groups-lee-allentuck-on-how-to-build-your-creative-muscle/ "The Plan A Group’s Lee Allentuck on how to build your creative muscle")

The Plan A Group’s Lee Allentuck shares his top tips for staying ‘creatively fit’.

[

![](https://www.mojo-nation.com/wp-content/themes/mojo-nation/images/placeholders/350x200.png)

![David Blanchard, Op Games](https://www.mojo-nation.com/files/2026/02/blanchard.jpg)

](https://www.mojo-nation.com/dream-teams/ "Dream Teams")

### [Dream Teams](https://www.mojo-nation.com/dream-teams/ "Dream Teams")

David Blanchard – Director of Party & Family Games at The Op Games – looks at why engaging with inventors beyond the licensing moment can really pay off.

[

![](https://www.mojo-nation.com/wp-content/themes/mojo-nation/images/placeholders/350x200.png)

![Richard C. Levy](https://www.mojo-nation.com/files/2025/12/1-2.jpeg)

](https://www.mojo-nation.com/prolific-inventor-richard-c-levy-offers-new-inventors-advice-on-starting-a-royalty-stream/ "Prolific inventor Richard C. Levy offers new inventors advice on starting a royalty stream")

### [Prolific inventor Richard C. Levy offers new inventors advice on starting a royalty stream](https://www.mojo-nation.com/prolific-inventor-richard-c-levy-offers-new-inventors-advice-on-starting-a-royalty-stream/ "Prolific inventor Richard C. Levy offers new inventors advice on starting a royalty stream")

Calling new inventors! Richard C. Levy gives simple Do’s and Don’t on becoming an inventor.

[![](https://www.mojo-nation.com/files/2026/02/Top-of-the-Game-Recruitment-MPU.jpg)](https://topofthegamerecruitment.com/)### Popular Articles

- [
	![Zuru, Mini Brands, Will Collinson](https://www.mojo-nation.com/files/2026/04/Zuru.jpg)
	#### Mini Brands Really Works Vinyl represents "major step forward for the brand", says Zuru
	](https://www.mojo-nation.com/mini-brands-really-works-vinyl-represents-major-step-forward-for-the-brand-says-zuru/)
- [
	![PhatMojo, Roblox, Think Influence](https://www.mojo-nation.com/files/2026/02/Phat.jpg)
	#### PhatMojo to launch Steal a Brainrot toys later this year
	](https://www.mojo-nation.com/phatmojo-to-launch-steal-a-brainrot-toys-later-this-year/)
- [
	![Bruce Bedlam, The Bedlam Cube](https://www.mojo-nation.com/files/2022/05/1-15.jpg)
	#### The Bedlam Cube’s inventor, Bruce Bedlam, on staying creative – and why questions are key
	](https://www.mojo-nation.com/the-bedlam-cubes-inventor-bruce-bedlam-on-staying-creative-and-why-questions-are-key/)
- [
	![Louise McGettrick](https://www.mojo-nation.com/files/2018/06/Louise-McGettrick.jpg)
	#### Fugglers creator Louise McGettrick on how an eBay listing for a bag of false teeth inspired her line of plush monsters
	](https://www.mojo-nation.com/fugglers-creator-louise-mcgettrick-ebay-listing-bag-false-teeth-inspired-line-plush-monsters/)
- [
	![Dan Klitsner, Kid Group](https://www.mojo-nation.com/files/2020/12/1-2.jpg)
	#### Bop It’s Dan Klitsner on creative techniques, his favourite inventions and more
	](https://www.mojo-nation.com/bop-dan-klitsner-creative-techniques-favourite-inventions/)### Upcoming Events

- [
	![International Game Inventors Convention](https://www.mojo-nation.com/files/2024/12/Spiel-300x300.jpg)
	- 30th January 2026
	- Spielwarenmesse, Nuremberg
	#### International Game Inventors Convention
	](https://www.mojo-nation.com/event/international-game-inventors-convention/ "Link to International Game Inventors Convention")
- [
	![](https://www.mojo-nation.com/files/2024/02/Vegas-300x300.jpg)
	- 19th - 21st May 2026
	- Mandalay Bay Convention Center, Las Vegas
	#### Las Vegas Licensing Expo
	](https://www.mojo-nation.com/event/las-vegas-licensing-expo/ "Link to Las Vegas Licensing Expo")
- [
	![Play Creators Festival](https://www.mojo-nation.com/files/2018/03/Play-Creators-festival-670x380-2.jpg)
	- 23rd - 25th June 2026
	- Stamford Bridge Stadium, Chelsea, London
	#### Play Creators Festival
	](https://www.mojo-nation.com/event/play-creators-festival/ "Link to Play Creators Festival")
- [
	![Play Creators Awards](https://www.mojo-nation.com/files/2018/03/Play-Creators-Awards-670x380-2.jpg)
	- Tuesday, June 23rd, 2026
	- Stamford Bridge Stadium, Chelsea, London
	#### Play Creators Awards
	](https://www.mojo-nation.com/event/play-creators-awards/ "Link to Play Creators Awards")
- [
	![Play Creators Conference](https://www.mojo-nation.com/files/2018/03/Play-Creators-Conference-670x380-2.jpg)
	- Wednesday, June 24th, 2026
	- Stamford Bridge Stadium, Chelsea, London
	#### Play Creators Conference
	](https://www.mojo-nation.com/event/toy-game-design-conference/ "Link to Play Creators Conference")
- [
	![Mojo Pitch](https://www.mojo-nation.com/files/2018/03/Mojo-Pitch-Purple-Background-1-1024x1024.jpg)
	- Thursday, June 25th, 2026
	- Stamford Bridge Stadium, Chelsea, London
	#### Mojo Pitch
	](https://www.mojo-nation.com/event/mojo-pitch/ "Link to Mojo Pitch")
- [
	![](https://www.mojo-nation.com/files/2022/09/BLE-2-300x300.jpg)
	- 6th - 8th October 2026
	- Excel London
	#### Brand Licensing Europe
	](https://www.mojo-nation.com/event/brand-licensing-europe/ "Link to Brand Licensing Europe")

[View all events](https://www.mojo-nation.com/events/ "All events")
