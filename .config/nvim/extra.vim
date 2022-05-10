" vim: fdm=marker fdl=0

if IsProject()
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

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
