This is a fork of [Tim Pope's][tpope] [vim-markdown][vm].

My goal is to figure out how to support markdown that looks like the following:

    This is a paragraph.  Isn't it paragraphy?

    1.  This is a list.  Hooray for lists.  What's nice about lists
        is how they support this sort of clean formatting for the
        paragraphs they contain.  Currently, neither 
        [`vim-markdown`][vm] nor [`mkd.vim`][mkd] correctly parses
        this syntax.

            Nor do they understand this: a code block inside
            a list element.  It's a pain in the ass to parse 
            properly.  I suspect I'll have to resort to dirty
            hacks.

    2.  This is a second list element.  For closure.

    And this is a closing paragraph.
    
    [vm]: http://github.com/tpope/vim-markdown
    [mkd]:  http://plasticboy.com/markdown-vim-mode/

I suspect it'll be a pain in the ass.  Hooray for vim.

[tpope]: http://tbaggery.com/
[vm]: http://github.com/tpope/vim-markdown
