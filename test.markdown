This is a heading
=================

This is a relatively innocent paragraph of text, certainly nothing interesting
about it at all, except that it forms the core of everything done in markdown,
and should therefore be front and center, waiting for someone to use it.  Text
inside paragraphs might be _emphasized_ or **strengthened**.  It might even
not be plain text at all, but `code` of some sort.  Exciting, eh?

    function this_is_a( code_block ) {
        its( indented, by, 4, spaces );
        and( ought, be_displayed, properly );
    }

So.  What else do I generally do in Markdown?  Ah, yes.  I [link][name] to 
things.  Also, I [link](http://inline), and sometimes make lists.

![this is an image](/it/is/i_swear.jpg "and this is a title")

![this is also an image][with_id]

1.  Lists are also an interesting part of Markdown, but they're a bit of a
    bitch to handle correctly in Vim.  This paragraph, for instance, has
    a nice indent on the side so that it looks clean.  It is decidedly
    _not_ a code block.
    
    This paragraph is also not a code block, even though I can totally see
    how it _really_ looks like one to the vim syntax file.  I'll have to
    think about how it ought be represented.  A\*nd, to make things even
    more complicated, code blocks can be:
    
        nested inside lists.  This is a code block.  It's
        nested inside a list.  It's going to be a pain in
        the ass to discover correctly.
    
    I'm not at all sure how it's going to work.  The vim syntax file
    syntax doesn't seem very supportive.  Ah well.  Let's see how it
    goes.

2.  This is a second list item, for completeness.

[with_id]: /it/is/i_swear.jpg "This is a title"
