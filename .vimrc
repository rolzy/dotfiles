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
set incsearch

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Set mapleader before loading plugins
let mapleader=","

call plug#begin('~/.local/share/nvim/plugged')

" Gruvbox theme
Plug 'morhetz/gruvbox'

" Python auto-complete
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'

" Auto-completing brackets and quotes
Plug 'jiangmiao/auto-pairs'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'

call plug#end()

" Load Gruvbox
colorscheme gruvbox
set background=dark

" deoplete-jedi autocompletions
let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Don't use jedi autocomplete
let g:jedi#completions_enabled = 0

" Use go-to function in split, not buffers
let g:jedi#use_splits_not_buffers = "right"

" Disable arrows and pgup/pgdn
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <PageUp> <Nop>
noremap <PageDown> <Nop>

" Use CtrlP for fzf
nnoremap <C-p> :GFiles<CR>

if $TERM =~ 'xterm-256color'
    set noek
endif
