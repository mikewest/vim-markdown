" Vim syntax file
" Language:     Markdown
" Maintainer:   Tim Pope <vimNOSPAM@tpope.org>
" Filenames:    *.markdown

if exists("b:current_syntax")
  finish
endif

runtime! syntax/html.vim
unlet! b:current_syntax

syn sync minlines=10
syn case ignore

syn match markdownValid '[<>]\S\@!'
syn match markdownValid '&\%(#\=\w*;\)\@!'

syn match markdownLineStart "^[<@]\@!" nextgroup=@markdownBlock

syn cluster markdownNestable contains=markdownNestedParagraph,markdownNestedCodeBlock,@markdownInline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Block Level Elements:
"
syn cluster markdownBlock contains=markdownH1,markdownH2,markdownH3,markdownH4,markdownH5,markdownH6,markdownBlockquote,markdownListMarker,markdownOrderedListMarker,markdownCodeBlock,markdownRule

"
"   Line Breaks:
"
"   Ending a line with two or more spaces generates a `<br>`
"
syn match markdownLineBreak "\s\{2,\}$"

"
"   Headings:
"
"   Markdown headings come in one of two forms, underlined:
"
"       This is an H1       |   This is an H2
"       =============       |   -------------
"
"   or prefixed:
"
"       # This is an H1     |   ## This is an H2
"
syn match markdownH1 ".\+\n=\+$" contained contains=@markdownInline,markdownHeadingRule
syn match markdownH2 ".\+\n-\+$" contained contains=@markdownInline,markdownHeadingRule
syn match markdownHeadingRule "^[=-]\+$" contained

syn region markdownH1 matchgroup=markdownHeadingDelimiter start="##\@!"      end="#*\s*$" keepend oneline contains=@markdownInline contained
syn region markdownH2 matchgroup=markdownHeadingDelimiter start="###\@!"     end="#*\s*$" keepend oneline contains=@markdownInline contained
syn region markdownH3 matchgroup=markdownHeadingDelimiter start="####\@!"    end="#*\s*$" keepend oneline contains=@markdownInline contained
syn region markdownH4 matchgroup=markdownHeadingDelimiter start="#####\@!"   end="#*\s*$" keepend oneline contains=@markdownInline contained
syn region markdownH5 matchgroup=markdownHeadingDelimiter start="######\@!"  end="#*\s*$" keepend oneline contains=@markdownInline contained
syn region markdownH6 matchgroup=markdownHeadingDelimiter start="#######\@!" end="#*\s*$" keepend oneline contains=@markdownInline contained

"
"   Blockquotes:
"
"   Blockquotes are strings of text, prefixed with `>`:
"
"       >   This is a blockquote, isn't
"       >   it blockquoty?
"
"   Markdown itself supports only prefixing the first line of a paragraph
"   with `>`, but I see no reason to support that here.
"
syn match markdownBlockquote ">\s" contained nextgroup=@markdownBlock,@markdownInline

"
"   Code Blocks:
"
syn region markdownCodeBlock start="^\z(\s*\)    \|^\z(\t*\)\t" end="^\z1$"
syn region markdownNestedCodeBlock start="^        \|^\t\t" end="^    $" contained

"
"   Lists:
"
"   TODO: real nesting
"
syn region markdownOrderedList matchgroup=markdownOrderedListMarker start=" \{0,4}\<\d\+\.\%(\s*\S\)\@=" end="^\z1$" contains=@markdownNestable
"syn match markdownListMarker " \{0,4\}[-*+]\%(\s\+\S\)\@=" contained
"syn match markdownOrderedListMarker " \{0,4}\<\d\+\.\%(\s*\S\)\@=" contained


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Horizontal Rule:
"
"   There are 5 valid patterns that generate horizontal rules:
"
"       * * *
"       ***
"       - - -
"       ---
"       ___
"
syn match markdownRule "^\* *\* *\*[ *]*$" contained
syn match markdownRule "^- *- *-[ -]*$" contained
syn match markdownRule "^___+$" contained


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Inline Elements:
"
syn cluster markdownInline contains=markdownLineBreak,markdownLinkText,markdownItalic,markdownBold,markdownCode,markdownEscape,@htmlTop

"
"   Links:
"
"   Inline links:
"       
"       This is [an example](http://example.com/ "Title") inline link.
"       [This link](http://example.net/) has no title attribute.
"
"   Reference links:
"
"       This is [an example][id] reference-style link.
"       ...
"       [id]: 
"
"   Automatic Links:
"
"       <http://example.com/>
"
syn region markdownAutomaticLink matchgroup=markdownUrlDelimiter start="<\%(\w\+:\|[[:alnum:]_+-]\+@\)\@=" end=">" keepend oneline

syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="\[\%(\_[^]]*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" keepend nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart
syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained
syn region markdownId matchgroup=markdownIdDelimiter start="\[" end="\]" keepend contained

syn region markdownIdDeclaration matchgroup=markdownLinkDelimiter start="^ \{0,2\}!\=\[" end="\]:" oneline keepend nextgroup=markdownUrl skipwhite
syn match markdownUrl "\S\+" nextgroup=markdownUrlTitle skipwhite contained
syn region markdownUrl matchgroup=markdownUrlDelimiter start="<" end=">" oneline keepend nextgroup=markdownUrlTitle skipwhite contained
syn region markdownUrlTitle matchgroup=markdownUrlTitleDelimiter start=+"+ end=+"+ keepend contained
syn region markdownUrlTitle matchgroup=markdownUrlTitleDelimiter start=+'+ end=+'+ keepend contained
syn region markdownUrlTitle matchgroup=markdownUrlTitleDelimiter start=+(+ end=+)+ keepend contained

"
"   Images:
"
"   Inline URL:
"
"       ![Alt text](/path/to/img.jpg)
"       ![Alt text](/path/to/img.jpg "Optional title")
"
"   Referenced URL:
"
"       ![Alt text][id]
"
syn match markdownImageDelimiter "!\[\@=" nextgroup=markdownLinkText

"
"   Emphasis:
"
"       *single asterisks*
"
"       _single underscores_
"
"       **double asterisks**
"
"       __double underscores__
"
syn region markdownItalic start="\S\@<=\*\|\*\S\@=" end="\S\@<=\*\|\*\S\@=" keepend contains=markdownLineStart
syn region markdownItalic start="\S\@<=_\|_\S\@=" end="\S\@<=_\|_\S\@=" keepend contains=markdownLineStart
syn region markdownBold start="\S\@<=\*\*\|\*\*\S\@=" end="\S\@<=\*\*\|\*\*\S\@=" keepend contains=markdownLineStart
syn region markdownBold start="\S\@<=__\|__\S\@=" end="\S\@<=__\|__\S\@=" keepend contains=markdownLineStart

"
"   Code:
"
"       Use the `printf()` function.
"
"       ``There is a literal backtick (`) here.``
"
syn region markdownCode matchgroup=markdownCodeDelimiter start="`" end="`" keepend contains=markdownLineStart
syn region markdownCode matchgroup=markdownCodeDelimiter start="`` \=" end=" \=``" keepend contains=markdownLineStart

"
"   Escapes:
"
"   \   backslash
"   `   backtick
"   *   asterisk
"   _   underscore
"   {}  curly braces
"   []  square brackets
"   ()  parentheses
"   #   hash mark
"   +   plus sign
"   -   minus sign (hyphen)
"   .   dot
"   !   exclamation mark

syn match markdownEscape "\\[][\\`*_{}()#+.!-]"

hi def link markdownH1                    htmlH1
hi def link markdownH2                    htmlH2
hi def link markdownH3                    htmlH3
hi def link markdownH4                    htmlH4
hi def link markdownH5                    htmlH5
hi def link markdownH6                    htmlH6
hi def link markdownHeadingRule           markdownRule
hi def link markdownHeadingDelimiter      Delimiter
hi def link markdownOrderedListMarker     markdownListMarker
hi def link markdownListMarker            htmlTagName
hi def link markdownBlockquote            Comment
hi def link markdownRule                  PreProc

hi def link markdownLinkText              htmlLink
hi def link markdownIdDeclaration         Typedef
hi def link markdownId                    Type
hi def link markdownAutomaticLink         markdownUrl
hi def link markdownUrl                   Float
hi def link markdownUrlTitle              String
hi def link markdownIdDelimiter           markdownLinkDelimiter
hi def link markdownUrlDelimiter          htmlTag
hi def link markdownUrlTitleDelimiter     Delimiter
hi def link markdownImageDelimiter        Delimiter

hi def link markdownItalic                htmlItalic
hi def link markdownBold                  htmlBold
hi def link markdownCodeDelimiter         Delimiter
hi def link markdownCode                  String
hi def link markdownCodeBlock             String
hi def link markdownNestedCodeBlock       String

hi def link markdownEscape                Special

let b:current_syntax = "markdown"

" vim:set sw=2:
