" .vimrc

" File encodings
set enc=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc

" Some defaults
set nocp
set visualbell
set wildmenu
set number
set relativenumber
set cursorline
set showmatch
set backspace=2
set mouse=a
set ttymouse=sgr " make it work properly in tmux

" Pathogen
call pathogen#infect()
call pathogen#helptags()

" Indentation options
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set textwidth=120

" Search options
set hlsearch
set incsearch
set ignorecase
set smartcase
" Ensure search results appear in the middle of the screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz


" Columns
set colorcolumn=121
execute "set colorcolumn=" . join(range(121,800), ',')

" Formatting
set formatoptions=c,q,r,t,b,n
set list listchars=tab:→\ ,trail:·,eol:$

" Status line
set ruler
set laststatus=2
set cmdheight=2
set shortmess=a
"set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1

" Remember cursor location on close
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Location of vim files
set viminfo='10,\"100,:20,%,n~/.vim/viminfo
set backupdir=~/.vim/backup/
set directory=~/.vim/swp/

" Colors & Syntax highlighting
filetype plugin indent on
syntax on
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_diffmode="high"
let g:solarized_visibility="low"
set background=light
colorscheme solarized
hi ColorColumn ctermbg=231
hi LineNr ctermbg=231
hi CursorLine ctermbg=lightyellow

" Jedi-vim options
let g:jedi#force_py_version = 3
let g:jedi#use_splits_not_buffers = "left"

" <leader>k opens Vexplorer
let g:netrw_liststyle=3
let g:netrw_winsize = 75
map <leader>k :Vexplore<cr> 
map <leader>t :terminal<cr> 

" F8 after search collapses everything unmatched
set foldexpr=getline(v:lnum)!~@/
map <F8> :set foldmethod=expr<CR><Bar>zM

" Small function to calculate sum in a column
command! -range=% -nargs=1 SumColumn <line1>,<line2>!awk -F '|' '{print; sum+=$('<args>' + 1)} END {print "Total: "sum}'

" XML folding
augroup XML
    autocmd!
    autocmd FileType xml let g:xml_syntax_folding=1
    autocmd FileType xml setlocal foldmethod=syntax
    autocmd FileType xml :syntax on
    autocmd FileType xml :%foldopen!
augroup END

" vim-terraform configuration
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=0
autocmd FileType terraform setlocal foldmarker={,}

" syntastic configuration
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1

let g:syntastic_enable_signs=1
let g:syntastic_error_symbol = '✗✗'
let g:syntastic_style_error_symbol = '✠✠'
let g:syntastic_warning_symbol = '∆∆'
let g:syntastic_style_warning_symbol = '≈≈'

" vim-airline / syntastic integration
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#syntastic#error_symbol = '✗✗:'
let g:airline#extensions#syntastic#stl_format_err = '%E{[%e(#%fe)]}'
let g:airline#extensions#syntastic#warning_symbol = '∆∆:'
let g:airline#extensions#syntastic#stl_format_warn = '%W{[%w(#%fw)]}'

let g:syntastic_html_tidy_ignore_errors = ['trimming empty']
let g:syntastic_python_checkers = ['flake8']

" golang
let g:syntastic_go_checkers = ['errcheck', 'go']
let g:go_fmt_experimental = 1
let g:go_rename_command = 'gopls'
let g:go_auto_type_info = 1
let g:go_debug_windows = {'vars': 'rightbelow 60vnew', 'stack': 'rightbelow 10new'}
autocmd FileType go setlocal foldmethod=syntax
autocmd FileType go set completeopt=longest,menuone

" jsonnet / tanka
let g:syntastic_jsonnet_checkers = ['jsonnet']
" Only check formatting because of Tanka import paths
let g:syntastic_jsonnet_jsonnet_exec = 'jsonnetfmt'
autocmd FileType jsonnet setlocal foldmethod=syntax
autocmd FileType jsonnet setlocal foldlevelstart=1

" Template (bash)
augroup templates
  autocmd BufNewFile *.sh 0r ~/.vim/templates/skel.bash
augroup END

" Spellcheck
autocmd FileType markdown setlocal spell spelllang=en_us
autocmd FileType gitcommit setlocal spell spelllang=en_us

" Checklist
nnoremap <leader>cc :ChecklistToggleCheckbox<cr>
nnoremap <leader>ce :ChecklistEnableCheckbox<cr>
nnoremap <leader>cd :ChecklistDisableCheckbox<cr>
vnoremap <leader>cc :ChecklistToggleCheckbox<cr>
vnoremap <leader>ce :ChecklistEnableCheckbox<cr>
vnoremap <leader>cd :ChecklistDisableCheckbox<cr>
au BufNewFile,BufRead *.chklst setf checklist
let g:checklist_filetypes = ['markdown', 'checklist']

let g:vim_markdown_folding_disabled = 1
let g:fugitive_git_command = 'git'

function! Openfile()
      call feedkeys("\<CR>\<C-W>w")
endfunction

" Opens URL in browser
nnoremap gx :!xdg-open <cWORD> &<CR><CR>
nnoremap gk :!k8s-alpha.sh <cWORD> &<CR><CR>

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
    let @/ = ''
    if exists('#auto_highlight')
        au! auto_highlight
        augroup! auto_highlight
        setl updatetime=4000
        echo 'Highlight current word: off'
        return 0
    else
        augroup auto_highlight
            au!
            au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
        augroup end
        setl updatetime=500
        echo 'Highlight current word: ON'
        return 1
    endif
endfunction

" Fold at a specific level
" Source: https://stackoverflow.com/a/25644411
function! FoldToTheLevel(TheLevel)
    "set mark "f" at current position
    execute "normal! mf"
    "close all the folder recursively
    execute "normal! ggVGzC"

    "open all the folder which have smaller level
    let h=0
    while h<a:TheLevel
        execute "normal! ggVGzo"
        let h+=1
    endwhile

    "open all the folder which have larger level
    folddoclosed execute "normal! VzOzc"
    "jump back and show in the middle
    execute "normal! `fzz"
endfunction
command! -nargs=1 F call FoldToTheLevel(<f-args>)

" JSONNET
au FileType jsonnet nmap <leader>b :call JsonnetEval()<cr>
function! JsonnetEval()
  " check if the file is a tanka file or not
  let output = system("tk tool jpath " . shellescape(expand('%')))
  if v:shell_error
    let output = system("jsonnet " . shellescape(expand('%')))
  else
    let output = system("tk eval " . shellescape(expand('%')))
  endif
  vnew
  setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile ft=json
  put! = output
endfunction
