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
"set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1

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

" <leader>k opens Vexplorer
let g:netrw_liststyle=3
map <leader>k :Vexplore<cr> 

" F8 after search collapses everything unmatched
set foldexpr=getline(v:lnum)!~@/
map <F8> :set foldmethod=expr<CR><Bar>zM

map <leader>db :DBPromptForBufferParameters<cr> 

let g:http_client_verify_ssl = 0
command! -range=% -nargs=1 SumColumn <line1>,<line2>!awk -F '|' '{print; sum+=$('<args>' + 1)} END {print "Total: "sum}'

augroup XML
    autocmd!
    autocmd FileType xml let g:xml_syntax_folding=1
    autocmd FileType xml setlocal foldmethod=syntax
    autocmd FileType xml :syntax on
    autocmd FileType xml :%foldopen!
augroup END
