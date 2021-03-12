call plug#begin('~/.local/share/nvim/plugged')

" Gruvbox theme
Plug 'morhetz/gruvbox'

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

" Vimsurround
Plug 'tpope/vim-surround'

" Python indentation
Plug 'Vimjas/vim-python-pep8-indent'

" autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" Load Gruvbox
colorscheme gruvbox
set background=dark

" .............................................................................
" junegunn/fzf
" .............................................................................
" Use CtrlP for fzf filesearch
nnoremap <C-p> :GFiles<CR>
nnoremap <C-g> :Ag<CR>

" .............................................................................
" jiangmiao/auto-pairs
" .............................................................................
au FileType python let b:AutoPairs = AutoPairsDefine({"f'" : "'", "r'" : "'", "b'" : "'"})

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

" .............................................................................
" neoclide/coc.nvim
" .............................................................................
nmap <silent> gd <Plug>(coc-definition)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

nmap <leader>rn <Plug>(coc-rename)

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

