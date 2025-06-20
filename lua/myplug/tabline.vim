" #aa3731 同 Title 的高亮
hi TabLineNr term=bold cterm=bold gui=bold guifg=#aa3731 guibg=#aaaaaa
hi TabLineSelNr term=bold cterm=bold gui=bold guifg=#aa3731 guibg=#c7b7d7
hi TabLineSeperator guifg=#333333 guibg=#333333

" modified from MyTabLine() in tabpage.txt
function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        "if i > 0
        "    let s ..= '%#TabLineFill#' .. ' '
        "endif

        " select the highlighting
        if i+1 == tabpagenr()
            let tab_hi = '%#TabLineSel#'
            let tabnr_hi = '%#TabLineSelNr#'
        else
            let tab_hi = '%#TabLine#'
            let tabnr_hi = '%#TabLineNr#'
        endif

        " set the tab page number (for mouse clicks)
        let s ..= '%' .. (i+1) .. 'T'

        let buflist = tabpagebuflist(i+1)
        let winnr = tabpagewinnr(i+1)

        " tabpage number and number of buffers
        let s ..= tabnr_hi .. ' ' .. len(buflist)
        " current working directory
        let s ..= tab_hi .. ' ' .. fnamemodify(getcwd(winnr, i+1), ':t') .. '/ '
        " current file name
        "let s ..= fnamemodify(bufname(buflist[winnr-1]), ':t') .. ' '
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s ..= '%#TabLineFill#%T'
    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let s ..= '%=%#TabLine#%999XX'
    endif

    return s
endfunction

set tabline=%!MyTabLine()
