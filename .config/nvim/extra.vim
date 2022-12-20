" vim: fdm=marker fdl=0

if project#isDirSet()
  " autocomplete
  let completeplug='ycm' " coc/ycm/etc...
  if (completeplug=='no')
    " {{{ ycm
    Plug 'ycm-core/YouCompleteMe'
    nn <localleader>y :YcmRestartServer<CR>
    let g:ycm_global_ycm_extra_conf = getcwd() . "/.nvim/ycm.py"
    let g:ycm_confirm_extra_conf = 0
    nn <silent> <leader>k :YcmCompleter GetDoc<CR>
    " }}}
  endif
endif

" {{{ DEBUG
Plug 'puremourning/vimspector'
let g:vimspector_install_gadgets = ['debugpy'] ", 'vscode-cpptools', 'CodeLLDB' ]

nn <localleader>b <Plug>VimspectorToggleBreakpoint
nn <localleader>B <Plug>VimspectorBreakpoints
nn <localleader>c <Plug>VimspectorContinue
nn <localleader>S <Plug>VimspectorStop
nn <localleader>j <Plug>VimspectorStepInto
nn <localleader>o <Plug>VimspectorStepOver
nn <localleader>k <Plug>VimspectorStepOut
nn <localleader>L :call vimspector#Launch()<CR>
nn <localleader>r :call vimspector#Restart()<CR>
nn <localleader>R :call vimspector#Reset()<CR>
" }}}

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
