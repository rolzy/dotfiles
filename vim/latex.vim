call plug#begin('~/.local/share/nvim/plugged')

" LaTeX
Plug 'lervag/vimtex'

call plug#end()

" .............................................................................
" lervag/vimtex
" .............................................................................
let g:tex_flavor = 'latex'
let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options = '-reuse-instance @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'
