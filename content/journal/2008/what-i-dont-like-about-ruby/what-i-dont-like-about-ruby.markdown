<div class="warning"><p><strong>Warning:</strong> Not everyone agreed with what I said in "Function calls without Parentheses". Ironically, I don't agree with what I said myself anymore. Be sure to check out the <a href="/journal/2008/on-requiring-parens-in-ruby/">On Requiring Parens in Ruby</a> followup article.</p></div>

Ruby is a fantastic programming language. For me, there are few languages (if any) that are as useful and as much fun as Ruby. I'm addicted to it.

But this is not an article about how cool Ruby really is. Instead, I'll talk about what I _don't_ like about Ruby. I won't be talking about bugs or missing features, but rather about design issues I disagree with. Most of these flaws can't be "fixed"—they're usually deliberate decisions that can't simply be reverted.

## Language flaws

### Function calls without Parentheses

In certain cases, it's impossible to distinguish between a variable and a function. Consider the following example:

    foo = bar

Is bar a variable? Is bar a method? There's no way to know for sure. Other languages such as PHP or C make this a lot more explicit:

<pre><code><span class="comment">C:</span>
<span class="variable">foo</span> = <span class="function">bar</span>(); <span class="comment">// function</span>
<span class="variable">foo</span> = <span class="function">bar</span>;   <span class="comment">// variable</span>

<span class="comment">PHP:</span>
<span class="variable">$foo</span> = <span class="function">bar</span>(); <span class="comment">// function</span>
<span class="variable">$foo</span> = <span class="function">$bar</span>;  <span class="comment">// variable</span></code>
</pre>

Ruby does not like so-called "line noise"—punctuation that seems to have a detrimental effect on source code readability. Compared to other programming languages, [Ruby is indeed pretty noiseless](http://onestepback.org/index.cgi/Tech/Ruby/LineNoise.rdoc). It is also possible, however, that the lack of punctuation makes a language _harder_ to read.

If one day I decide to write a language, I'd _require parentheses after a function call_, even for functions that don't take any arguments. This not only makes code easier to read, but it also makes it possible for a text editor to reliably highlight function calls, something that is very hard with Ruby code.

### `def` what?

`def` defines a function. `def`, being an abbreviation of "define", is a rather ambiguous keyword, because the keyword itself doesn't tell what is being defined.

Classes can also be defined, but you can't use `def` for that—the `class` keyword defines a class. So, for consistency's sake, I'd rather have `function` or `fun` instead of `def`.

### No explicit return

Functions don't have to explicitly return anything. If a function does not end with a return statement, the return value of the last statement in that function will be returned instead.

There are two things I don't like about this. First of all, in some cases you have to explicitly return anyway (e.g. at the beginning of a function), so why not _always_ make return explicit, instead of only sometimes? Secondly, a function can secretly return something even if you didn't intend it to return anything.

Explicit is often better than implicit, and this is one such case.

### Functions and lambdas and procs and blocks

There are no less than four ways to define blocks of executable code:

1. you can define _functions_ (global functions or class/instance methods),
2. you can pass _blocks_ to functions such as `each` and `map`,
3. you can create _procs_ using `Proc.new`, and
4. you can create _lambdas_, using `lambda` or `proc`.

`Proc.new`, `lambda` and `proc` all return `Proc` instances. Confusingly, `Proc`s created using `proc` or `lambda` behave differently from those created by `Proc.new`, but nobody really seems to understand those subtle differences.

It would perfectly be possible to unify procs, lambdas and blocks in one single data type. Instead of passing a block to a function, you pass it a lambda. This also makes it possible to pass multiple blocks to a single function, something that is not currently possible with Ruby.

### Questionable question marks

Function names can end with a question mark. This makes functions that query a data structure easy to recognise. For example, `user.logged_in?` returns true or false, depending on whether the user is logged in or not.

Unfortunately, it is not possible to define a function with a name ending in _both_ a question mark and an equals sign. Therefore, setter methods never have a question mark appended, so you can't say something like `user.logged_in? = true`, even though this would (arguably) look a lot cleaner.

Additionally, getters generated using `attr_reader` do not have a trailing question mark. Instead, you have to define a getter with a trailing question mark yourself. For example, suppose you have an instance variable which is either true or false depending on whether a user is logged in. `attr_reader :logged_in` will create a `logged_in` method, but no `logged_in?` one, and `attr_reader :logged_in?` causes errors.

Also, why can't variables end with question marks? There is no good reason to only allow question marks on functions—trailing question marks for boolean variable names would definitely be quite useful too.

## Standard library flaws

### Too many synonyms

* `Enumerable#collect`, `Enumerable#map`
* `Enumerable#map!`, `Enumerable#collect!`
* `Enumerable#find`, `Enumerable#detect`
* `Enumerable#select`, `Enumerable#find_all`
* `proc`, `lambda`
* `Array#delete_if`, `Array_reject`
* `Array#length`, `Array#size`
* …

All these pairs do exactly (or almost exactly) the same. Why does Ruby have all these synonyms?

### Inject? Eh?

Ruby's `inject` method is basically a `reduce` or `fold` function with a different name. Why pick a new name for a function that usually goes a different name?

## So what should we do now?

Stop using Ruby!

No, not really. Like I said, Ruby is great. No programming language is perfect though, and Ruby isn't either—but it's getting close. I have to agree with what Bjarne Stroustrup once said:

> There are two types of programming languages: the ones people bitch about, and the ones that nobody uses.

Just for the record, I'm not a fan of Bjarne Stroustrup's C++ programming language. In fact, I hate C++. And while I'm bitching about C++, let's throw in another quote, this time one by Alan Kay:

> I invented the term "object-oriented", and I can tell you I did not have C++ in mind.

I like to think that Ruby is what Alan Kay had in mind.

Every new language borrows ideas from older languages. Ruby borrowed from Python, Perl, Smalltalk and more, and Ruby will likely be an inspiration for many languages to come.

Perhaps one day I'll have the knowledge, time and courage to create my own language.
