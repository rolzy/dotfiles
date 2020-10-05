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
let mapleader=" "

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

" fern
Plug 'lambdalisue/fern.vim'

" git integration
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'

" markdown support
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

call plug#end()

" Load Gruvbox
colorscheme gruvbox
set background=dark

" deoplete-jedi autocompletions
let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

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

" Navigate around splits with a single key combo.
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>

" Use CtrlP for fzf
nnoremap <C-p> :GFiles<CR>

" .............................................................................
" lambdalisue/fern.vim
" .............................................................................

" Disable netrw.
let g:loaded_netrw  = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

augroup my-fern-hijack
  autocmd!
  autocmd BufEnter * ++nested call s:hijack_directory()
augroup END

function! s:hijack_directory() abort
  let path = expand('%:p')
  if !isdirectory(path)
    return
  endif
  bwipeout %
  execute printf('Fern %s', fnameescape(path))
endfunction

" Custom settings and mappings.
let g:fern#disable_default_mappings = 1

noremap <silent> <Leader>f :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=

function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> M <Plug>(fern-action-rename)
  nmap <buffer> h <Plug>(fern-action-hidden-toggle)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> * <Plug>(fern-action-mark:toggle)
  nmap <buffer> b <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

" .............................................................................
" tpope/vim-fugitive
" .............................................................................
nmap <leader>gp :diffget //3<CR>
nmap <leader>gq :diffget //2<CR>
nmap <leader>gs :G<CR>

" .............................................................................
" plasticboy/vim-markdown
" .............................................................................
autocmd FileType markdown set conceallevel=0
autocmd FileType markdown normal zR

let g:vim_markdown_frontmatter=1

" .............................................................................
" iamcco/markdown-preview.nvim
" .............................................................................
let g:mkdp_refresh_slow=1
let g:mkdp_markdown_css='/home/roland/dotfiles/css/github-markdown.css'
let g:mkdp_browser = '/c/Program Files/Mozilla Firefox/firefox.exe'
