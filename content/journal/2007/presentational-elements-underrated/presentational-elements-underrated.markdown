Web designers are slowly starting to realise that using semantic markup is making their job easier. Perhaps surprisingly, putting meaningful markup aside and using presentational markup (sparingly) can have the same effect.

### BBCode versus HTML

Like many forums, the [Myst Online forums](http://www.mystonline.com/forums/) have support for BBCode tags, e.g. [B] and [I]. Putting [B] and [/B] around a piece of text makes the text bold, while [I] makes it italic.

Internally, the [B] and [I] BBCode tags are converted into HTML. Somewhat to my surprise, I discovered that the forum software used the following markup for [B] and [I]:

<pre><code>&lt;<span class="element">span</span> <span class="attribute">style</span>=<span class="value">"font-weight:bold"</span>>Lorem&lt;/<span class="element">span></span>>
&lt;<span class="element">span</span> <span class="attribute">style</span>=<span class="value">"font-weight:italic"</span>>Ipsum&lt;/<span class="element">span</span>></code></pre>

`b` and `i` are presentational elements, and using a span with an inline style is one way of not using such elements. Another possibility would be to use `span class="bold"` or `span class="italic"`.

When Jane, a user on the forums, pushes the [I] button, she does so because she wants to make a run of text italic. The reason why that run of text should be italic can vary: perhaps it needs emphasis, perhaps it indicates a piece of text in a different language, perhaps it is used for a book title, etc.

There is very little semantic value associated with italic text. When Jack reads Jane's forum post, he'll see the italic text and will (hopefully) be able to figure out why the text is set in an italic font. The forum software is not able to figure out why the text is italic; it only knows that italic text is somehow different from its surroundings.

### Class Bloat

Some people tell web designers who are new to semantic markup to replace their `b` with `strong` and `i` with `em`. This is really bad advice: italic text is not necessarily important, and bold text is not necessarily very important. Ideally, `em` should only be used to convey emphasis and `strong` should only be used to convey strong emphasis.

Unfortunately, using `em` when you want italics is very tempting. I sometimes get the urge to write this:

<pre><code>In his book &lt;<span class="element">em</span>>De engelenmaker&lt;/<span class="element">em</span>>, Stefan Brijs&hellip;</code></pre>

In the above example, "De engelenmaker" is the title of a book. Book titles are usually set in an italic font. Using `em` to mark up a book title in this case is a bad idea. A better way of marking this up would be:

<pre><code>In his book &lt;<span class="element">span</span> <span class="attribute">class</span>=<span class="value">"book-title"</span>>De engelenmaker&lt;/<span class="element">span</span>>,
Stefan Brijs&hellip;</code></pre>

This markup is more correct than the markup in the example above it. The style definition for the `book-title` class will likely look like this:

<pre><code>.<span class="element">book-title</span> {
    <span class="attribute">font-style</span>: <span class="value">italic</span>;
}</code></pre>

Book titles are virtually always set in italic. This means that it is very unlikely that the style definition for the `book-title` class will ever be changed.

Keeping HTML and CSS as lean as possible is one of the goals every web designer should have. Semantic markup is a very useful tool for this. However, _semantic markup should not be a goal itself_. If semantic markup would be a goal on itself, we'd all be writing this kind of HTML:

<pre><code>&lt;<span class="element">p</span> <span class="attribute">class</span>=<span class="value">"property-definition declaration statement sentence"</span>>
    &lt;<span class="element">span</span> <span class="attribute">class</span>=<span class="value">"reference word"</span>>This&lt;/<span class="element">span</span>>
    &lt;<span class="element">span</span> <span class="attribute">class</span>=<span class="value">"verb action word"</span>>is&lt;/<span class="element">span</span>>
    &lt;<span class="element">span</span> <span class="attribute">class</span>=<span class="value">"adjective word positive"</span>>cool&lt;/<span class="element">span</span>>.
&lt;/<span class="element">p</span>></code></pre>

instead of this:

<pre><code>&lt;<span class="element">p</span>>This is cool.&lt;/<span class="element">p</span>></code></pre>

We're not writing that kind of markup because doing so would be completely pointless. Something similar can be said about the markup that uses the `book-title` class; it may look cool, but it doesn't really have a point. I'd much rather write this instead:

<pre><code>In his book &lt;<span class="element">i</span>>De engelenmaker&lt;/<span class="element">i</span>>, Stefan Brijs&hellip;</code></pre>

Yes, what you see there is the `i` element. What an evil person I must be to recommend writing presentational HTML, right?

Presentational HTML is usually bad because it makes restyling web pages harder. Moving all presentational information into a separate stylesheet makes restyling pages easier. However, book titles are virtually _always_ going to be set in an italic font, so in this case, that argument's moot.

Using `i` and `b` elements where appropriate prevents you from using markup that is semantically invalid (by using `em` instead of `i`) and using markup that is bloated (by using custom classes such as `book-title`).

### Presentational Elements in HTML5

Having said that, here is an excerpt of <i>[HTML5 Sucks](/journal/2007/html5-sucks/)</i>, an article I wrote a few months ago:

> The b, i [&hellip;] elements, which had no semantic meaning in HTML4, suddenly receives a rather unsatisfying new meaning

For completeness, here is how the HTML5 specification defines the `i` element: 

> The i element represents a span of text in an alternate voice or mood, or
> otherwise offset from the normal prose, such as a taxonomic designation, a
> technical term, an idiomatic phrase from another language, a thought, a ship
> name, or some other prose whose typical typographic presentation is
> italicized.

In that article, I also said:

> Forgive me when I translate that as &ldquo;The i element represents a span of text
> that is italic&rdquo;.

I didn't realise it at the time, but _that exactly is the point_ of the `i` element. In HTML5, the `i` element pretty much represents italic text. It is a presentation element with very little semantic value; the only thing you can derive from its usage is that text inside an `i` element is somehow different from its surroundings.

### BBCode Again

In the <i>De engelenmaker</i> example above, there still was a way of marking up the book title in a semantic way. In BBCode, this is absolutely impossible; forum software is unable to convert `[B]...[/B]` into something semantically meaningful.

Requiring users to define their own classes in BBCode, along with style information, is a very non-user-friendly solution that is way too complex and way too confusing. The probability of users using such a feature correctly is zero. Additionally, it suffers from the class bloat issue outlined above.

Using [STRONG] and [EM] instead of [B] and [I] buttons is not a good solution either, because people will use [STRONG] for bold and [EM] for italic text&mdash;they'd use semantic elements for presentational purposes.

So we're stuck with [B] and [I]. Using inline CSS to tackle this issue is ugly. Using presentation class names such as `bold` and `italic` is not great either. The `b` and `i` elements, however, are a perfect solution.

### Presentational Markup&mdash;Underrated!

Presentational markup definitely can be useful at times. When using WYSIWYG editors, using presentation markup is pretty much impossible to avoid&mdash;don't try work around it, because it's not going to work anyway.

Even in other cases it can be useful to fall back to the good old `b` and `i` elements. Ironically, using non-semantical markup can make your code leaner, and therefore easier to maintain.

Meaningful markup is extremely useful for cleaning up your site's code, but don't be afraid of falling back to what often seems to be evil markup.

(But don't overuse those presentational elements either.)

### Update (December 8th)

[Mathias Bynens](http://mathiasbynens.be/) responded and said:

> Why don't you just use a CITE element instead of the `book-title` class?

I must admit `CITE` completely slipped my mind while writing this blog post. In certain cases, this would indeed be a better choice than `I`.

`CITE` can only be used when citing; the element is meant to mark up sources for quotations in the document. For example:

<pre><code><span class="comment">&lt;!-- Correct --></span>
In his book &lt;<span class="element">cite</span>>De engelenmaker&lt;/<span class="element">cite</span>>, Stefan Brijs wrote:
&lt;q>Sommige inwoners van Wolfheim beweren nog altijd&hellip;&lt;/q>

<span class="comment">&lt;!-- Incorrect --></span>
I like Stefan Brijs' book &lt;<span class="element">cite</span>>De engelenmaker&lt;/<span class="element">cite</span>>.</code></pre>

The original example (<q>In his book <i>De engelenmaker</i>, Stefan Brijs&hellip;</q>) is  rather ambiguous. I should have written a full example sentence instead of abruptly terminating it with an ellipsis.

Unfortunately, the CITE element isn't explained particularly well in the HTML 4 specification. HTML 5, though, <a href="http://www.whatwg.org/specs/web-apps/current-work/#the-cite">defines `CITE`</a> in a much more understandable way:

> The cite element represents a citation: the source, or reference, for a quote or statement made in the document.

While `CITE` definitely has a good use, it's not always the right choice. When in doubt about when to use it, it's better not to use the element and go with a custom class name or `I` instead.
