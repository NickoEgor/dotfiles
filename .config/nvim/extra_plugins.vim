" extra_plugins.vim

if project#isDirSet()
  " autocomplete
  let completeplug='no' " coc/ycm/etc...
  if (completeplug=='ycm')
    " {{{ ycm
    Plug 'ycm-core/YouCompleteMe'
    nn <localleader>y :YcmRestartServer<CR>
    let g:ycm_global_ycm_extra_conf = getcwd() . "/.nvim/ycm.py"
    let g:ycm_confirm_extra_conf = 0
    nn <silent> <leader>k :YcmCompleter GetDoc<CR>
    " }}}
  elseif (completeplug=='coc')
    " {{{ coc.nvim
    Plug 'Shougo/neoinclude.vim'
    Plug 'jsfaint/coc-neoinclude'
    Plug 'neoclide/coc.nvim'
    " tab completion
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction
    ino <silent><expr> <TAB>
      \  pumvisible() ? "\<C-n>" :
      \  <SID>check_back_space() ? "\<TAB>" :
      \  coc#refresh()
    ino <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    ino <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    ino <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " remap keys for gotos
    nm <silent> gd <Plug>(coc-definition)
    nm <silent> gy <Plug>(coc-type-definition)
    nm <silent> gi <Plug>(coc-implementation)
    " refresh
    ino <silent><expr> <C-space> coc#refresh()
    " symbol renaming
    nm <leader>R <Plug>(coc-rename)
    " }}}
  endif
endif

" {{{ DEBUG
Plug 'puremourning/vimspector'
let g:vimspector_install_gadgets = ['debugpy', 'vscode-cpptools']

nn <leader>d :call vimspector#Launch()<CR>
nn <leader>q :call vimspector#Reset()<CR>
nn <localleader>r :call vimspector#Restart()<CR>
nn <localleader>b <Plug>VimspectorToggleBreakpoint
nn <localleader>B <Plug>VimspectorBreakpoints
nn <localleader>s <Plug>VimspectorStop
nn <localleader>l <Plug>VimspectorStepInto
nn <localleader>h <Plug>VimspectorStepOut
nn <localleader>j <Plug>VimspectorStepOver
nn <localleader>k <Plug>VimspectorContinue
" }}}

" tree-sitter syntax highlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" targets/objects manipulations
Plug 'michaeljsmith/vim-indent-object'
Plug 'wellle/targets.vim'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>
