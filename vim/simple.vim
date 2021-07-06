syntax on

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set rnu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set nohlsearch
set incsearch

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Set mapleader before loading plugins
let mapleader=" "

" Set tabwidth to 2 for html
autocmd BufRead,BufNewFile *.htm,*.html,*.js setlocal tabstop=2 shiftwidth=2 softtabstop=2

" Disable arrows and pgup/pgdn
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <PageUp> <Nop>
noremap <PageDown> <Nop>

" Navigate around splits with a single key combo.
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>

" Terminal hotkeys
nmap <leader>t :terminal<CR>
tnoremap <Esc> <C-\><C-n>

" Copy paste using system clipboard
vnoremap <C-c> "+y
map <C-v> "+P
