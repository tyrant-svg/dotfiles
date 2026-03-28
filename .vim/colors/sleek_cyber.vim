" sleek_cyber — vim colorscheme matching Hyprland rice
set background=dark
hi clear
if exists("syntax_on") | syntax reset | endif
let g:colors_name = "sleek_cyber"

" Palette
" bg:      #16130b   surface:  #221f17   surface_hi: #2d2a21
" fg:      #e9e2d4   fg_muted: #cdc6b4
" gold:    #ddc66e   gold_dim: #d2c6a1
" cyan:    #aad0b2   border:   #4b4739
" red:     #ffb4ab

hi Normal          guifg=#e9e2d4  guibg=#16130b  ctermfg=254 ctermbg=232
hi NormalNC        guifg=#cdc6b4  guibg=#16130b
hi LineNr          guifg=#4b4739  guibg=#16130b
hi CursorLine      guibg=#221f17  ctermbg=235
hi CursorLineNr    guifg=#ddc66e  guibg=#221f17  gui=bold
hi SignColumn      guibg=#16130b
hi ColorColumn     guibg=#1a1714

" Selection / search
hi Visual          guibg=#2d2a21
hi Search          guifg=#16130b  guibg=#ddc66e
hi IncSearch       guifg=#16130b  guibg=#ddc66e  gui=bold

" Syntax
hi Comment         guifg=#4b4739  gui=italic
hi Constant        guifg=#ddc66e
hi String          guifg=#d2c6a1
hi Number          guifg=#ddc66e
hi Boolean         guifg=#ddc66e  gui=bold
hi Identifier      guifg=#e9e2d4
hi Function        guifg=#ddc66e  gui=bold
hi Statement       guifg=#ddc66e  gui=bold
hi Keyword         guifg=#ddc66e  gui=bold
hi Conditional     guifg=#ddc66e  gui=bold
hi Repeat          guifg=#ddc66e  gui=bold
hi Operator        guifg=#cdc6b4
hi PreProc         guifg=#aad0b2
hi Include         guifg=#aad0b2
hi Type            guifg=#d2c6a1  gui=bold
hi StorageClass    guifg=#d2c6a1
hi Structure       guifg=#d2c6a1
hi Special         guifg=#aad0b2
hi Delimiter       guifg=#4b4739
hi Error           guifg=#ffb4ab  guibg=#16130b  gui=bold
hi Todo            guifg=#16130b  guibg=#ddc66e  gui=bold

" UI chrome
hi StatusLine      guifg=#ddc66e  guibg=#221f17  gui=bold
hi StatusLineNC    guifg=#4b4739  guibg=#1a1714
hi VertSplit       guifg=#4b4739  guibg=#16130b
hi WildMenu        guifg=#16130b  guibg=#ddc66e
hi Pmenu           guifg=#e9e2d4  guibg=#221f17
hi PmenuSel        guifg=#16130b  guibg=#ddc66e
hi PmenuSbar       guibg=#2d2a21
hi PmenuThumb      guibg=#4b4739
hi TabLine         guifg=#4b4739  guibg=#1a1714
hi TabLineSel      guifg=#16130b  guibg=#ddc66e  gui=bold
hi TabLineFill     guibg=#16130b
hi Title           guifg=#ddc66e  gui=bold
hi MatchParen      guifg=#16130b  guibg=#ddc66e  gui=bold

" Diffs
hi DiffAdd         guibg=#1a2e1a
hi DiffChange      guibg=#2a2010
hi DiffDelete      guifg=#4b4739  guibg=#2a1010
hi DiffText        guibg=#3a3010  gui=bold

" Folds / misc
hi Folded          guifg=#4b4739  guibg=#1a1714  gui=italic
hi FoldColumn      guifg=#4b4739  guibg=#16130b
hi NonText         guifg=#2d2a21
hi SpecialKey      guifg=#2d2a21
hi Underlined      guifg=#ddc66e  gui=underline
hi SpellBad        guifg=#ffb4ab  gui=undercurl
