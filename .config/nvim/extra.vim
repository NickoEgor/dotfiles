" vim: fdm=marker fdl=0

if isdirectory($IDE_DIR)
  " autocomplete
  " {{{ ycm
  Plug 'ycm-core/YouCompleteMe'
  nn <localleader>y :YcmRestartServer<CR>
  let g:ycm_global_ycm_extra_conf = getcwd() . "/.nvim/ycm.py"
  let g:ycm_confirm_extra_conf = 0
  nn <silent> <leader>k :YcmCompleter GetDoc<CR>
  " }}}
endif

" debug
Plug 'puremourning/vimspector'
