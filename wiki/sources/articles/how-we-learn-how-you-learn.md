---
description: "It’s all about linguistic research, cognitive psychology, and machine learning."
tags: ['research']
source: "https://blog.duolingo.com/how-we-learn-how-you-learn/"
raw_file: "How we learn how you learn.md"
created: 2026-05-17
---

At Duolingo, our goal is to make language learning fun and effective. We think the best education should be full of play, so we're constantly developing new features that make learning new things — and practicing old things — feel like a game! At the same time, we're serious about taking a scientific, data-driven approach to all of our products, and about sharing what we learn with the world. In this post, we'll take a look at the science behind the *Duolingo skill strength meter*, which we published in an [Association of Computational Linguistics](http://aclweb.org/anthology/P/P16/P16-1174.pdf?ref=blog.duolingo.com) article earlier this year....

### Strength meters

Any Duolingo user knows that we organize lessons into thematically or grammatically related *skills*. And any student of a second language knows that you gradually forget what you've learned over time. That's why Duolingo uses *strength meters* to help you keep tabs on how well you remember each skill, so you can go back and practice at just the right time.

**Figure 1.***Left:* A Duolingo skill tree with strength meters. *Right:* A skill detail screen, showing words that most need to be practiced.

![](https://storage.ghost.io/c/7a/33/7a33d0f4-927d-4fe8-a6bf-96131b5e76d4/content/images/2020/02/hlr_skill_tree.png) ![](https://storage.ghost.io/c/7a/33/7a33d0f4-927d-4fe8-a6bf-96131b5e76d4/content/images/2020/02/hlr_weakwords.png)

As soon as you finish a skill, its strength meter is usually at full bars (with a gold icon). Once the meter slips to half-full, though, you know it's time to practice. You can do this by choosing a skill to see your weakest words, and then strengthen them with a custom practice session made just for you.[^1]

So how do these strength meters work? And how do we know which words you should practice at any given time?

### The student model and forgetting curves

At the core of Duolingo is a *student model* that tracks statistics about every word we've ever taught you: for example, how often you've seen a word, remembered it correctly, and so on. (This is a huge database with billions of entries that get updated 3,000 times per second!) We use these stats to predict how likely you are to remember any given word at any time. At first you need to practice pretty often, but as words get established in your long-term memory, you can slow down and focus on new skills.

Our approach is based on [the spacing effect](https://en.wikipedia.org/wiki/Spacing_effect?ref=blog.duolingo.com): the finding that short practices spaced out over time is better for learning than "cramming." A related finding is [the lag effect](https://en.wikipedia.org/wiki/Spacing_effect?ref=blog.duolingo.com#Lag_effect): you can learn *even better* if you gradually increase the spacing between practices. These ideas go back to 1885, when German psychologist [Hermann Ebbinghaus](https://en.wikipedia.org/wiki/Hermann_Ebbinghaus?ref=blog.duolingo.com) pioneered the concept of the *forgetting curve*.

**Figure 2.** A forgetting curve: the probability of remembering goes down as a function of "lag time" (days since the last practice) and "half-life".

![](https://storage.ghost.io/c/7a/33/7a33d0f4-927d-4fe8-a6bf-96131b5e76d4/content/images/2020/02/hlr_forgetting_curve1.svg)

Figure 2 shows an example forgetting curve. The probability $p$ of remembering a word decays exponentially: $p = 2^{- \Delta / h}$, where $\Delta$ is the "lag time" since your last practice and $h$ is the "half-life" of the word in your memory (that is, the time it takes for your memory strength to decrease by half).[^2] To understand this a little better, let's look at three points on the curve above:

- $\Delta=0$ means that you *just practiced*, so you'll almost certainly remember,
- $\Delta=h$ means the lag time and half-life are *equal* (set to one day in the figure), so there's only a 50% chance you'll remember, and
- $\Delta\gg h$ means it's been *too long* since you last practiced, so you'll probably not be able to remember correctly.

The best time to practice is when you are on the verge of forgetting (in other words, when $\Delta$ and $h$ are close). But how can we estimate $h$ for every word in your long-term memory? We can't really measure it directly, can we?

People have tried various tricks over the years. In the 1960s, a linguist named Paul Pimsleur published [a memory schedule](http://files.eric.ed.gov/fulltext/ED012150.pdf?ref=blog.duolingo.com) of half-lifes that he used in his language-learning programs (5 seconds after the first practice, then 25 seconds, then 2 minutes, 10 minutes, and so on). However, it's a fixed, rigid schedule that is the same for all words and can't adapt to you personally. In the 1970s, a pop psychologist named Sebastian Leitner proposed a [more adaptive system](https://en.wikipedia.org/wiki/Leitner_system?ref=blog.duolingo.com) for learning with flashcards. One version of the system doubles the half-life each time you remember correctly, and cuts it in half each time you are incorrect. This seems like a better idea, and in fact it's what Duolingo used to power our strength meters when we first launched in 2012.

But we thought we could do better....

### Half-life regression (HLR)

Duolingo has millions of students who generate billions of statistics about language learning every day. So it didn't take long for us to come up with the idea of combining modern machine learning and data science techniques with the psycholinguistic theory of forgetting curves!

Through our research, we invented a new statistical model we call *half-life regression (HLR)*, inspired by other methods used in "big data" like [logistic regression](https://en.wikipedia.org/wiki/Logistic_regression?ref=blog.duolingo.com), but using an exponential probability function like the one in Figure 2. To get all super-technical, we estimate the half-life of a word in your memory using $h = 2^{\Theta\cdot\mathbf{x}}$, where $\Theta$ denotes the regression model "weights" and $\mathbf{x}$ denotes a bunch of variables that summarize your learning history with the word. HLR involves finding the "best" model weights for $\Theta$ by minimizing the "loss function" $ℓ$ across every practice session for every student:

\\$\\ell(\\langle p,\\Delta,\\mathbf{x}\\rangle; \\Theta) = \\left( p - 2 <sup>{-\frac{\Delta}{2</sup> {\\Theta\\cdot\\mathbf{x}}}} \\right)^2 + \\alpha \\left( \\frac{-\\Delta}{\\log\_2(p)} - 2^{\\Theta\\cdot\\mathbf{x}} \\right)^2 + \\lambda|\\Theta|^2\_2;.\\$

Don't worry if that equation looks scary to you (although you can read more [in our full paper](http://aclweb.org/anthology/P/P16/P16-1174.pdf?ref=blog.duolingo.com) if it looks exciting)! All this means is that we can learn to predict the half-life for each word in your long-term memory, by analyzing the error patterns of millions of language learners just like you.

**Figure 3.** A student's word practice history and HLR-predicted forgetting curve.

![](https://storage.ghost.io/c/7a/33/7a33d0f4-927d-4fe8-a6bf-96131b5e76d4/content/images/2020/02/hlr_forgetting_curve2.svg)

For example, Figure 3 shows what your HLR forgetting curve might look like for a particular word. Each time you remember correctly (green checks), $h$ increases and your memory starts to decay more slowly (dashed line). But each time you make a mistake (red Xs), $h$ decreases and you'll need to practice sooner. We can average these predictions at any time to generate your strength meters (Figure 1, left), or use them to pick your weakest words for practice (Figure 1, right). If you remember correctly a little more than half the time in practice, that means we're doing a good job at predicting your memory!

In addition to your history of remembering correctly or not, HLR can use the words themselves as regression variables, which tells us something about what makes language learning hard. For example, here are some of the easier words (positive $\Theta$ weight) and harder words (negative $\Theta$ weight) for some of our most popular languages, according to the HLR model:

| Language | English | Spanish | French | German |
| --- | --- | --- | --- | --- |
| **Easier Words**   (+ weights) | *camera* (+0.77)   *ends* (+0.38)   *circle* (+0.08) | *liberal* (+0.83)   *como* (+0.40)   *encuentra* (+0.10) | *visite* (+0.94)   *suis* (+0.47)   *trou* (+0.05) | *Baby* (+0.87)   *sprechen* (+0.56)   *sehr* (+0.13) |
| **Harder words**   (- weights) | *rose* (-0.09)   *performed* (-0.48)   *writing* (-0.81) | *está* (-0.05)   *pensando* (-0.33)   *quedado* (-0.73) | *dessous* (-0.06)   *ceci* (-0.45)   *fallait* (-0.91) | *den* (-0.07)   *Ihnen* (-0.55)   *war* (-1.10) |

If you look carefully, you start to see patterns. Easier words (positive weights) tend to be [cognates](https://en.wikipedia.org/wiki/Cognate?ref=blog.duolingo.com) (words that are similar across languages) or short, common words with "regular" forms. Harder words (negative weights) tend to be rare words, "irregular" forms, or use complex grammar like past/present participles and the [imperfective aspect](https://en.wikipedia.org/wiki/Imperfective_aspect?ref=blog.duolingo.com). It makes sense that HLR should pick up on these regularities, and make use of them to help you practice better.

### Experimental results

We conducted several experiments to verify that our new half-life regression model does what it's supposed to do. Figure 4 shows the results of one experiment (on a data set of more than 12 million Duolingo practice sessions), comparing HLR to the Pimsleur and Leitner algorithms plus logistic regression (a more off-the-shelf machine learning method) [^3].

**Figure 4.** Comparison of error rates for half-life regression (HLR) and other spaced repetition models on Duolingo student practice data. Lower error is better

![](https://storage.ghost.io/c/7a/33/7a33d0f4-927d-4fe8-a6bf-96131b5e76d4/content/images/2020/02/hlr_comparison.svg)

Clearly, our half-life regression has the lowest prediction error of any of the methods we tried.[^4] In fact, the HLR error rate is *nearly half* that of the Leitner system method (which is what we used for the first version of Duolingo)!

Then we secretly ran [A/B tests](https://en.wikipedia.org/wiki/A/B_testing?ref=blog.duolingo.com) to see which algorithm Duolingo users actually preferred. Daily retention (the percentage of you who did something one day, and then came back to do it again the next day) improved significantly for the HLR group: we saw a 9.5% increase in retention for practice sessions, a 1.7% increase for lessons, and a whopping 12% increase for overall activity. Once we were convinced HLR was the way to go, we switched everyone to HLR-based strength meters and [you told us how much you loved it](https://www.duolingo.com/comment/878880?ref=blog.duolingo.com)!

### Conclusion

Duolingo is reinventing language learning and assessment, and this is just one of the many ways we combine research in linguistics and cognitive psychology with machine learning and data science to push the state-of-the-art. If you want to dig into all the details, you can read our full research paper here:

> B. Settles and B. Meeder. 2016. [A Trainable Spaced Repetition Model for Language Learning](http://aclweb.org/anthology/P/P16/P16-1174.pdf?ref=blog.duolingo.com). In *Proceedings of the Association for Computational Linguistics (ACL)*, pages 1848-1858.

We've also released the data set and source code for the experiments in our paper (and this blog post) on GitHub here: [https://github.com/duolingo/halflife-regression](https://github.com/duolingo/halflife-regression?ref=blog.duolingo.com).

If you're passionate about innovative applied research like this, you should [join the Duolingo team](https://duolingo.com/careers?ref=blog.duolingo.com)! We're hiring Research Scientists and Data Analysts to help create the next generation of learning technology!

---

[^1]: Or you can hit the "Practice Weak Skills" button, which automagically picks a skill for you!

[^2]: The principle of [half-life decay](https://en.wikipedia.org/wiki/Exponential_decay?ref=blog.duolingo.com#Half-life) occurs everywhere. It's also used for radiocarbon dating of fossils, measuring drug metabolism rates, and even estimating the volume of [beer froth](http://www.emba.uvm.edu/~tlakoba/07_fall/math_022/ExpDecayBeerFroth.pdf?ref=blog.duolingo.com)!

[^3]: Figure 4 compares the [mean absolute error](https://en.wikipedia.org/wiki/Mean_absolute_error?ref=blog.duolingo.com) of each method's predictions. For example, the error for HLR is 0.13. So if HLR predicts a 50% chance that you'll remember a word ($p$ = 0.5), on average you'll *actually* get that word correct between 37-63% of the time (0.5 ± 0.13).

[^4]: There have been other approaches based on the spacing effect, notably the [SuperMemo](https://www.supermemo.com/english/ol/sm2.htm?ref=blog.duolingo.com) algorithm used by the flashcard app [Anki](https://www.ankiapp.com/?ref=blog.duolingo.com). We did not re-implement or compare against these methods for several practical reasons. See the related work section of [our paper](http://aclweb.org/anthology/P/P16/P16-1174.pdf?ref=blog.duolingo.com) for more details.
