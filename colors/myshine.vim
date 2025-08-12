" modify from shine (one of the original colorscheme)
" mainly make the white a bit dimmer

" load the "shine" colorscheme
runtime colors/shine.vim

" runtime 中 colors 的 README 推荐设置:
"     "autocmd SourcePre */colors/blue_sky.vim set background=dark"
set background=light

" change the color
hi Cursor guifg=#f5f5f5
hi CursorLineNr guibg=#a8a8a8
hi DiffAdd guifg=#f5f5f5
hi DiffChange guifg=#f5f5f5
hi DiffDelete guifg=#f5f5f5
hi Error guibg=#f5f5f5
hi LineNr guibg=#e8e8e8
hi MatchParen guifg=#f5f5f5
hi ModeMsg guibg=#f5f5f5
hi MoreMsg guibg=#f5f5f5
hi NonText guibg=NONE
hi Normal guibg=#f5f5f5
hi NormalNC guibg=#e8e8e8
hi PmenuSbar guifg=#f5f5f5 guibg=#f5f5f5
hi Search guifg=#f5f5f5
hi StatusLine gui=bold guifg=black guibg=lightgrey
hi StatusLineNC guifg=#f5f5f5
hi TabLineSel guibg=#f5f5f5
hi WarningMsg guibg=#f5f5f5
hi link WinSeperator Normal

hi clear TabLineFill
hi TabLineFill guibg=grey

