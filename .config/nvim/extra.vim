" vim: fdm=marker fdl=0

if isdirectory($IDE_DIR)
  " autocomplete
  " {{{ ycm
  Plug 'ycm-core/YouCompleteMe'
  nn <localleader>y :YcmRestartServer<CR>
  let g:ycm_global_ycm_extra_conf = getcwd() . "/.nvim/ycm.py"
  let g:ycm_confirm_extra_conf = 0
  " }}}
endif

" debug
Plug 'puremourning/vimspector'

" highlight colors
Plug 'ap/vim-css-color'

" python
Plug 'vim-scripts/indentpython.vim'
