" plugins.vim
" contains plugins and colortheme setting

" {{{ PLUGINS
call plug#begin()

" {{{ treeview
if has('nvim')
  Plug 'antoinemadec/FixCursorHold.nvim'
endif
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'
nn <silent> <C-n> :Fern . -reveal=%<CR>
nn <silent> <leader>n :Fern %:p:h -reveal=%<CR>
nn <silent> <leader>N :Fern . -reveal=% -drawer -toggle<CR>
let g:fern#default_hidden = 1
let g:fern#disable_default_mappings = 1
let g:fern#disable_viewer_hide_cursor = 1

function! FernInit() abort
  nm <buffer><nowait> <CR> <Plug>(fern-action-open-or-expand)
  nm <buffer><nowait> l <Plug>(fern-action-open-or-expand)
  nm <buffer><nowait> h <Plug>(fern-action-collapse)
  nm <buffer><nowait> s <Plug>(fern-action-open:split)
  nm <buffer><nowait> v <Plug>(fern-action-open:vsplit)
  nm <buffer><nowait> r <Plug>(fern-action-reload:cursor)
  nm <buffer><nowait> R <Plug>(fern-action-reload:all)
  nm <buffer><nowait> u <Plug>(fern-action-leave)
  nm <buffer><nowait> d <Plug>(fern-action-enter)
  nm <buffer><nowait> c <Plug>(fern-action-cancel)
  nm <buffer> za <Plug>(fern-action-hidden:toggle)
  nm <buffer> yy <Plug>(fern-action-yank:label)
  nm <buffer> yb <Plug>(fern-action-yank)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END
" }}}

" comments
Plug 'tpope/vim-commentary'
nm <C-_> <plug>CommentaryLine<ESC>j
vm <C-_> <plug>Commentary<ESC>

" improved quoting/parenthesizing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " dot command for vim-surround

" highlight for substituion
Plug 'markonm/traces.vim'

" rename file
Plug 'vim-scripts/Rename2'

" status line
Plug 'itchyny/lightline.vim'
let g:lightline = {
  \  'active': {'left': [['mode', 'paste'], ['readonly', 'relativepath', 'modified']]},
  \  'inactive': {'left': [['relativepath', 'modified']]}
  \}

" {{{ snippets
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets'
im <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xm <C-k> <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \  '\<Plug>(neosnippet_expand_or_jump)' : '\<TAB>'
" }}}

" {{{ linting
Plug 'w0rp/ale'
" NOTE: do not use 'clangd' linter as it's too heavy
let g:ale_linters = {
  \  'cpp': ['cpplint', 'cc', 'clangtidy'],
  \  'c': ['cpplint', 'cc', 'clangtidy'],
  \  'cmake': ['cmake_lint'],
  \  'sh': ['shellcheck'],
  \  'python': ['flake8', 'pylint'],
  \  'tex': ['chktex'],
  \}
let g:ale_fixers = {
  \  '*': ['remove_trailing_lines', 'trim_whitespace'],
  \  'cpp': ['clangtidy', 'clang-format'],
  \  'c': ['clangtidy', 'clang-format'],
  \  'cmake': ['cmakeformat'],
  \  'sh': ['shfmt'],
  \  'python': ['autoimport', 'isort', 'autoflake', 'autopep8']
  \}
let g:ale_set_highlights = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let b:ale_list_window_size = 5
let g:ale_completion_enabled = 1
" tex options
" 13 - intersentence spacing
" 26 - spaces before punctuation
" 44 - hline in tables
let g:ale_tex_chktex_options = '-n13 -n26 -n44'
" c/c++ options
" NOTE: cpp headers issue
let g:ale_c_parse_compile_commands = 1
let g:ale_c_cpplint_options =
  \'--linelength=120 --filter=-legal/copyright,-legal/license,
  \-whitespace/todo,-readability/todo,-runtime/references,
  \-build/include_order,-build/include'
let g:ale_cpp_cpplint_options = g:ale_c_cpplint_options
let g:ale_cpp_cc_options = '-std=c++17 -Wall -Wextra -pedantic'
" python
let g:ale_python_flake8_options = '--max-line-length=120'
let g:ale_python_autopep8_options = '--max-line-length=120'
let g:ale_python_isort_options = '--line-length=120'
" cmake
let g:ale_cmake_cmake_lint_executable = 'cmake-lint'
let g:ale_cmake_cmake_lint_options = '--line-width=120'
let g:ale_cmake_cmakeformat_executable = 'cmake-format'
let g:ale_cmake_cmakeformat_options = '--line-width=120'
" completion
set omnifunc=ale#completion#OmniFunc
nm <localleader>l <Plug>(ale_lint)
nm <localleader>e <Plug>(ale_enable)
nm <localleader>d <Plug>(ale_disable)
nm <localleader>f <Plug>(ale_fix)
nm <localleader>i <Plug>(ale_detail)
nm <localleader>] <Plug>(ale_next)
nm <localleader>[ <Plug>(ale_previous)
nm <localleader>} <Plug>(ale_next_error)
nm <localleader>{ <Plug>(ale_previous_error)
" }}}

" go
Plug 'fatih/vim-go'
au FileType go let g:go_fmt_fail_silently = 1
au FileType go let g:go_fmt_autosave = 0

" fzf
if filereadable('/usr/bin/fzf')
  Plug '/usr/bin/fzf'
else
  Plug 'junegunn/fzf'
endif
Plug 'junegunn/fzf.vim'
nn <silent> <C-b> :Buffers<CR>
nn <silent> <leader>b :FZF<CR>

" c++
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rhysd/vim-clang-format'
Plug 'derekwyatt/vim-fswitch'
au FileType c,cpp nn <silent> <leader>o :FSHere<CR>

" git
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/conflict-marker.vim'

" auto tag management
Plug 'ludovicchabant/vim-gutentags'
if g:has_project_config
  let g:gutentags_ctags_executable = 'guten.sh'
  let g:gutentags_ctags_tagfile = $IDE_DIR . '/tags'
  nn <localleader>t :GutentagsUpdate!<CR>
  " NOTE: to debug gutentags uncomment line below
  " let g:gutentags_trace = 1
else
  let g:gutentags_dont_load = 1
endif

" markdown
Plug 'plasticboy/vim-markdown'

" aligning text
" NOTE: http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
" NOTE: align by '=': Tabularize /=
Plug 'godlygeek/tabular'

" highlight colors
Plug 'ap/vim-css-color'

" python
Plug 'vim-scripts/indentpython.vim'

" theme
Plug 'liuchengxu/space-vim-dark'
Plug 'NLKNguyen/papercolor-theme'
Plug 'EdenEast/nightfox.nvim'

" additional plugins
call TryReadScriptFile('extra.vim')

call plug#end()

filetype plugin indent on
" }}}

" {{{ COLORTHEME
" colo space-vim-dark
" ---
" set t_Co=256
" set background=dark
" colo PaperColor
" ---
" colo nightfox
" colo dayfox
" colo dawnfox
colo duskfox
" colo nordfox
" colo terafox
" colo carbonfox
" ---
hi Comment cterm=italic
" }}}
