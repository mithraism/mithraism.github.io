A week ago, I had the idea of creating a game in Ruby. After evaluating a few gaming frameworks, I settled on [Gosu](gosu). Gosu is a simple and  minimalistic library, and I like minimalism a lot, so we started a loving relationship.

I wrote a small library named _Monet_ on top of Gosu, providing functionality such as better event handling, views and subviews, buttons, and more. _Monet_ is named after Claude Monet, an impressionist painter. This library also does a bit of painting, but that's where the similarity ends---Claude Monet has nothing to do with event handling, really.

The Gosu romance unfortunately didn't last long. For real-time games, Ruby is simply _way_ too slow (Gosu isn't slow; Ruby makes it slow). Gosu and I broke up, and now I've moved on to a much faster language.

Monet is now [available on github](monet) under a liberal MIT licence. It is very small and not feature-complete, but it should be fairly easy to extend it. I won't be developing Monet any longer, but I believe anyone who has used Gosu or is still using Gosu should check it out anyway. Fork and enjoy.

[gosu]:  http://code.google.com/p/gosu/
[monet]: http://github.com/ddfreyne/monet/tree/master
