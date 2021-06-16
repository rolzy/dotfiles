call plug#begin('~/.local/share/nvim/plugged')

" Gruvbox theme
Plug 'morhetz/gruvbox'

" Auto-completing brackets and quotes
Plug 'jiangmiao/auto-pairs'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'

" Fern
Plug 'lambdalisue/fern.vim'

" status bar
Plug 'vim-airline/vim-airline'

" Vimsurround
Plug 'tpope/vim-surround'

" Python indentation
Plug 'Vimjas/vim-python-pep8-indent'

" autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" jupyter-vim
Plug 'jupyter-vim/jupyter-vim'

call plug#end()

" Load Gruvbox
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

" .............................................................................
" junegunn/fzf
" .............................................................................
function! GFilesFallback()
  let output = system('git rev-parse --show-toplevel') " Is there a faster way?
  let prefix = get(g:, 'fzf_command_prefix', '')
  if v:shell_error == 0
    exec "normal :" . prefix . "GFiles --exclude-standard --cached --others\<CR>"
  else
    exec "normal :" . prefix . "Files\<CR>"
  endif
  return 0
endfunction

" Use CtrlP for fzf filesearch
" Use CtrlG for fzf grepping
nnoremap <C-p> :call GFilesFallback()<CR>
nnoremap <C-g> :Ag<CR>

" .............................................................................
" lambdalisue/fern.vim
" .............................................................................
" Disable netrw.
let g:loaded_netrw  = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

" Custom settings and mappings.
let g:fern#disable_default_mappings = 1
let g:fern#drawer_keep = 'true'

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
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> c <Plug>(fern-action-copy)
  nmap <buffer> M <Plug>(fern-action-rename)
  nmap <buffer> h <Plug>(fern-action-hidden-toggle)
  nmap <buffer> r <Plug>(fern-action-reload)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

" .............................................................................
" jiangmiao/auto-pairs
" .............................................................................
au FileType python let b:AutoPairs = AutoPairsDefine({"f'" : "'", "r'" : "'", "b'" : "'"})

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

" .............................................................................
" jupyter-vim/jupyter-vim
" .............................................................................
augroup python_execute
    au!
    au FileType python nmap <leader>J :JupyterConnect<CR>
    au FileType python nmap <leader>I :PythonImportThisFile<CR>
    au FileType python nmap <leader>a :JupyterSendRange<CR>
    au FileType python xmap <leader>a <Plug>JupyterRunVisual
augroup END
