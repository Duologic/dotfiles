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
let g:terraform_fmt_on_save=1

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
autocmd FileType go setlocal foldmethod=syntax
autocmd FileType go set completeopt=longest,menuone

" terraform folds
autocmd FileType terraform setlocal foldmarker={,}

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
