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
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

" jupyter-vim
Plug 'jupyter-vim/jupyter-vim'

" markdown support
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Syntax Highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

" Load Gruvbox
set termguicolors
let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'
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
" vim-airline/vim-airline
" .............................................................................
let g:airline_powerline_fonts = 1

" .............................................................................
" jiangmiao/auto-pairs
" .............................................................................
au FileType python let b:AutoPairs = AutoPairsDefine({"f'" : "'", "r'" : "'", "b'" : "'"})

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

" .............................................................................
" plasticboy/vim-markdown
" .............................................................................
let g:vim_markdown_folding_disabled = 1

" .............................................................................
" neovim/nvim-lspconfig
" .............................................................................
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true

lua << EOF
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local servers = { "pyright","bashls" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach
    }
end
EOF

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set completeopt=menuone,noinsert,noselect
highlight LspDiagnosticsDefaultError guifg=#FF0000
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" .............................................................................
" nvim-treesitter/nvim-treesitter
" .............................................................................
lua <<EOF
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true
    },
}
EOF
