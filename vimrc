" .vimrc

" Some defaults
set nocp
set visualbell
set wildmenu
set number
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

" Search options
set hlsearch
set incsearch
set ignorecase
set smartcase

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
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" No clue what this does
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
set background=light
colorscheme solarized
hi ColorColumn ctermbg=231
hi LineNr ctermbg=231

" Jedi-vim options
let g:jedi#use_splits_not_buffers = "left"

" Turn off Powerline
let g:powerline_loaded = 1
" Add Python3 for Powerline
" let $PYTHONPATH='/usr/lib/python3.5/site-packages'
