When I [started blogging again][ib], I picked Textpattern as the CMS that would run Stoneship. Looking back, this has proven to be a big mistake&mdash;simply put, <a rev="vote-against" href="http://textpattern.com/">Textpattern</a> sucks. Its interface is far from intuitive, it's buggy, it's slow, and doesn't work well with [lighttpd][] (which is one reason why I never had comments enabled).

I ditched Textpattern and replaced it with _nanoc_, a tiny homegrown CMS written in [Ruby][ruby]. One extremely cool property of nanoc is that it doesn't run on the server, but rather on a local computer. I write Stoneship's pages and articles on my Mac, and then tell nanoc to process the local content and upload it to my server.

nanoc's advantages, in a nutshell:

* I can now put my site in a [Subversion][svn] repository.
* I can now preview all changes before I upload them.
* I can now write my posts in [Markdown][md] instead of Textile or HTML.
* I can now properly use [TextMate][tm] to manage my entire site.
* Stoneship is now served _lightning fast_.

nanoc doesn't just output static HTML. It can output _anything_&mdash;including Ruby or PHP code. Therefore, the probability of having comments enabled has actually _increased_. :)

I'm still unsure whether to release nanoc or not. It's a sweet little tool, and I think other people will want to use it, but I simply don't want to deal with documentation, bug reports, feature requests, testing, etc.

Kudos to [Wim Vanderschelden][wvds], whose idea I totally stole.

[ib]:       http://stoneship.org/journal/im-back
[lighttpd]: http://lighttpd.net
[ruby]:     http://ruby-lang.org/
[md]:       http://daringfireball.net/projects/markdown/
[tm]:       http://macromates.com/
[svn]:      http://subversion.tigris.org/
[wvds]:     http://fixnum.org/
