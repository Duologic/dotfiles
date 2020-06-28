" Live preview/reload of Markdown in lynx
function MDLynx()
    let filename = expand('%:p')

    if !exists("g:md_lynx_term_buffer")
        let current_buff = bufnr("%")
        vert term
        let g:md_lynx_term_buffer = bufnr("%")
        autocmd BufWritePost * call MDLynx()
        wincmd w
    endif

    if exists("g:md_lynx_term_buffer")
        call term_sendkeys(g:md_lynx_term_buffer, "Q\<CR>")
        sleep 500m
        call term_sendkeys(g:md_lynx_term_buffer, "pandoc " . filename . " | lynx --stdin\<CR>")
    endif
endfunction

" Live preview/reload of Markdown in man
function MDMan()
    let filename = expand('%:p')

    if !exists("g:md_man_term_buffer")
        let current_buff = bufnr("%")
        vert term
        let g:md_man_term_buffer = bufnr("%")
        autocmd BufWritePost * call MDMan()
        wincmd w
    endif

    if exists("g:md_man_term_buffer")
        call term_sendkeys(g:md_man_term_buffer, "ZZ\<CR>")
        sleep 500m
        call term_sendkeys(g:md_man_term_buffer, "pandoc -s -f markdown -t man " . filename . " | groff -T utf8 -man | less\<CR>")
    endif
endfunction
