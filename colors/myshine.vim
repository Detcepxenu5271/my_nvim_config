" modify from shine (one of the original colorscheme)
" mainly make the white a bit dimmer

" load the "shine" colorscheme
runtime colors/shine.vim

" runtime 中 colors 的 README 推荐设置:
"     "autocmd SourcePre */colors/blue_sky.vim set background=dark"
set background=light

" change the color
hi NonText guibg=NONE
hi Search guifg=#f5f5f5
hi MoreMsg guibg=#f5f5f5
hi ModeMsg guibg=#f5f5f5
hi StatusLine guifg=#f5f5f5
hi StatusLineNC guifg=#f5f5f5
hi WarningMsg guibg=#f5f5f5
hi DiffAdd guifg=#f5f5f5
hi DiffChange guifg=#f5f5f5
hi DiffDelete guifg=#f5f5f5
hi PmenuSbar guifg=#f5f5f5 guibg=#f5f5f5
hi TabLineSel guibg=#f5f5f5
hi Cursor guifg=#f5f5f5
hi Normal guibg=#f5f5f5
hi MatchParen guifg=#f5f5f5
hi Error guibg=#f5f5f5

hi clear TabLineFill
hi TabLineFill guibg=grey

