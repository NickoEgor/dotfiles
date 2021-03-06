" vim: fdm=marker fdl=0 ts=2 sw=2 sts=2
set nocompatible

" set leader key
let mapleader=" "
let maplocalleader=","

" {{{ PLUGINS

call plug#begin('~/.vim/plugged')

" treeview
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'
nn <silent> <C-n> :Fern . -reveal=%<CR>
nn <silent> <leader>n :Fern . -reveal=% -drawer -toggle<CR>
let g:fern#disable_default_mappings = 1
let g:fern#disable_viewer_hide_cursor = 1

function! FernInit() abort
  nm <buffer><nowait> <CR> <Plug>(fern-action-open-or-expand)
  nm <buffer><nowait> l <Plug>(fern-action-open-or-expand)
  nm <buffer><nowait> h <Plug>(fern-action-collapse)
  nm <buffer><nowait> s <Plug>(fern-action-open:split)
  nm <buffer><nowait> v <Plug>(fern-action-open:vsplit)
  nm <buffer><nowait> r <Plug>(fern-action-reload)
  nm <buffer> za <Plug>(fern-action-hidden-toggle)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

" buffer manipulation
Plug 'rbgrouleff/bclose.vim'
nn <silent> <leader>q :Bclose<CR>

" comments
Plug 'tpope/vim-commentary'
nm <C-_> <plug>CommentaryLine<ESC>j
vm <C-_> <plug>Commentary<ESC>

" improved quoting/parenthesizing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " dot command for vim-surround
Plug 'jiangmiao/auto-pairs'
let g:AutoPairsShortcutToggle = ''

" highlight for substituion
Plug 'markonm/traces.vim'

" rename file
Plug 'vim-scripts/Rename2'

" status line
Plug 'itchyny/lightline.vim'

" autocomplete
Plug 'Shougo/neoinclude.vim'
Plug 'jsfaint/coc-neoinclude'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
" extensions
let g:coc_global_extensions = ['coc-cmake', 'coc-json']
" tab completion
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
ino <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
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
nm <leader>rn <Plug>(coc-rename)

" snippets
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets'
im <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xm <C-k> <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" linting
Plug 'w0rp/ale'
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
let g:ale_linters = {
      \   'cpp': ['cpplint', 'cc', 'clangtidy', 'clang-format'],
      \   'c': ['cc', 'clangtidy', 'clang-format'],
      \   'sh': ['shfmt', 'shellcheck'],
      \   'python': ['flake8', 'pylint'],
      \   'tex': ['chktex'],
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
let g:ale_cpp_cpplint_options =
      \'--linelength=120 --filter=-legal/copyright,-readability/todo,
      \-runtime/references,-build/include_order,-build/include'
let g:ale_cpp_cc_options = '-std=c++17 -Wall -Wextra -pedantic'
set omnifunc=ale#completion#OmniFunc
nm <leader>l <Plug>(ale_lint)
nm <leader>a <Plug>(ale_toggle)
nm <leader>f <Plug>(ale_fix)
nm <leader>d <Plug>(ale_detail)
nm <leader>] <Plug>(ale_next)
nm <leader>[ <Plug>(ale_previous)
nm <leader>} <Plug>(ale_next_error)
nm <leader>{ <Plug>(ale_previous_error)

" python
Plug 'vim-scripts/indentpython.vim'

" go
Plug 'fatih/vim-go'
au FileType go let g:go_fmt_fail_silently = 1

" fzf
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
nn <silent> <C-b> :Buffers<CR>
nn <silent> <leader>b :FZF<CR>

" c++
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rhysd/vim-clang-format'
Plug 'derekwyatt/vim-fswitch'
au FileType c,cpp nn <silent> <leader>s :FSHere<CR>

" tagbar
Plug 'majutsushi/tagbar'
" TODO: make focusable from any split
nn <silent> <leader>T :TagbarToggle<CR>

" indentation
Plug 'Yggdroot/indentLine' " can break conceallevel
au FileType tex,markdown,json let g:indentLine_setColors = 0
au FileType tex,markdown,json let g:indentLine_enabled = 0

" language switching
Plug 'lyokha/vim-xkbswitch'
let g:XkbSwitchEnabled = 1

" highlight colors
Plug 'ap/vim-css-color'

" syntax files
Plug 'baskerville/vim-sxhkdrc'      " sxhkd
Plug 'tomlion/vim-solidity'         " solidity

" markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" file picker
Plug 'vifm/vifm.vim'

" theme
Plug 'liuchengxu/space-vim-dark'

call plug#end()

filetype plugin on

" }}}

" {{{ COLORTHEME
colo space-vim-dark
hi Comment cterm=italic
" }}}

" {{{ OPTIONS
" status line
set laststatus=2
" encoding/fileformat
set encoding=utf-8
set fileencodings=utf-8,cp1251,ucs-2,koi8-r,cp866
set fileformat=unix
set fileformats=unix,dos,mac
" search
set incsearch
set hlsearch
" tab/space/indent
set tabstop=4       " width for Tab
set shiftwidth=4    " width for shifting with '>>'/'<<'
set softtabstop=4   " width for Tab in inserting or deleting (Backspace)
set smarttab
set expandtab
set autoindent
set nolist
" numbers
set number
set relativenumber
" info/swap/backup
set viminfo="-"
set nobackup
set nowritebackup
set noundofile
" modeline
set modeline
set modelines=5
set noshowmode
set showcmd
" wildmenu
set wildmenu
set wildmode=longest,full
" mouse
set mouse=a
" folding
set foldmethod=indent
set foldlevel=99
" splits
set splitbelow
set splitright
" conceal
set conceallevel=0
set concealcursor=nvic
" tags
set tags=./tags,tags,~/.local/share/tags
" spell
set spell spelllang=
" file search
set path+=**
set wildignore+=*/build/*,*/.git/*,*/node_modules/*
" local .vimrc support
set exrc
set secure
" misc
set completeopt-=preview
set clipboard=unnamedplus
set scrolloff=5
set hidden
set cursorline
set cinoptions=N-s,g0
set matchpairs+=<:>
" }}}

" {{{ MAPPINGS

" change <paste> command behaviour
xn p "_dp
xn P "_dP

" disable Ex mode
nn Q <nop>

" annoying keys
com! Q :q
com! W :w
com! WQ :wq
com! Wq :wq
com! Qa :qa
com! -bang Q :q<bang>

" normal mode bindings
nn <silent> <leader>h :noh<Enter>
nn Y y$
nn zq ZQ

" buffer close
nn <silent> <C-q> :close<CR>

" }}}

" {{{ CURSOR
" NOTE: different cursors per mode
if (&term!='linux')
  if exists('$TMUX')
    let &t_SI = "\ePtmux;\e\e[6 q\e\\"
    let &t_SR = "\ePtmux;\e\e[4 q\e\\"
    let &t_EI = "\ePtmux;\e\e[2 q\e\\"
  else
    let &t_SI = "\e[6 q"
    let &t_SR = "\e[4 q"
    let &t_EI = "\e[2 q"
  endif
endif
" }}}

" {{{ SPLIT/RESIZE
fun! ToggleResizeSplitMode()
  if !exists('b:SplitResize')
    let b:SplitResize=1
    echo "Resizing enabled"
  else
    unlet b:SplitResize
    echo "Resizing disabled"
  endif
endfun

nn <silent> <expr> <C-h> !exists('b:SplitResize') ? '<C-w><C-h>' : ':vert res -1<CR>'
nn <silent> <expr> <C-j> !exists('b:SplitResize') ? '<C-w><C-j>' : ':res -1<CR>'
nn <silent> <expr> <C-k> !exists('b:SplitResize') ? '<C-w><C-k>' : ':res +1<CR>'
nn <silent> <expr> <C-l> !exists('b:SplitResize') ? '<C-w><C-l>' : ':vert res +1<CR>'
 " NOTE: it's better to not remap ESC button
nn gr :call ToggleResizeSplitMode()<CR>
" }}}

" {{{ GREPPING
if executable('rg')
  set grepprg=rg\ --vimgrep\ -g\ '!build'\ -g\ '!.git'\ -F\ --hidden\ --no-messages
endif

func! QuickGrep(pattern)
  " TODO: add check for empty string
  exe "silent grep! " . a:pattern
  copen
  if line('$') == 1 && getline(1) == ''
    echo "No search results"
    cclose
  else
    let l:nr=winnr()
    exe l:nr . "wincmd J"
  endif
endfunc

command! -nargs=1 QuickGrep call QuickGrep(<f-args>)
nn <leader>g :QuickGrep<space>""<left>
vn <leader>g y:QuickGrep "<C-r>+"<CR>
" }}}

" {{{ FILETREE
let g:netrw_banner = 0
let g:netrw_list_hide = '^\./'
let g:netrw_liststyle = 3
let g:netrw_dirhistmax = 0
nn <silent> <localleader><C-n> :Explore<CR>
nn <silent> <localleader><leader>n :Lexplore<CR>
nn <silent> <leader>_ <Plug>NetrwRefresh
" }}}

" {{{ TABS
nn <silent> th :tabprev<CR>
nn <silent> tl :tabnext<CR>
nn <silent> tn :tabnew<CR>
nn <silent> tc :tabclose<CR>
nn <silent> tH :tabmove -1<CR>
nn <silent> tL :tabmove +1<CR>
" }}}

" {{{ SPELL
nn <silent> <leader>Se :setlocal spell spelllang+=en<CR>
nn <silent> <leader>Sr :setlocal spell spelllang+=ru<CR>
nn <silent> <leader>Sd :setlocal nospell spelllang=<CR>
" }}}

" {{{ SESSIONS
nn <silent> <leader>ms :mksession! <bar> echo "Session saved"<CR>
nn <silent> <leader>ml :source Session.vim<CR>
nn <silent> <leader>md :!rm Session.vim<CR>
" }}}

" {{{ STYLES
" python pep textwidth
au FileType python setlocal textwidth=119 | setlocal colorcolumn=120
" c++ style
au FileType c,cpp setlocal tabstop=4 | setlocal shiftwidth=4 |
      \ setlocal textwidth=119 | setlocal colorcolumn=120
" cmake, js, yaml, proto
au FileType cmake,javascript,typescript,yaml,proto
      \ setlocal tabstop=2 | setlocal shiftwidth=2
" }}}

" {{{ FORMATTERS
" c/c++
au FileType c,cpp,javascript,typescript nn <buffer> <C-f> :ClangFormat<CR>
au FileType c,cpp,javascript,typescript vn <buffer> <C-f> :ClangFormat<CR>
" shell
au FileType sh nn <buffer> <C-f> :%!shfmt<CR>
au FileType sh vn <buffer> <C-f> :%!shfmt<CR>
" json
au FileType json nn <buffer> <C-f> :%!jq<CR>
au FileType json vn <buffer> <C-f> :%!jq<CR>
" yaml,html,css
au FileType yaml,html,css nn <buffer> <C-f> :!prettier --write %<CR>
" cmake
au FileType cmake nn <buffer> <C-f> :!cmake-format --line-width 120 -i % <CR><CR>:e<CR>
" }}}

" {{{ MISC
" file executing
nn <leader>e :w <bar> :!compiler %<CR>
nn <leader>E :w <bar> :!compiler % 2<CR>
nn <leader>x :!chmod +x %<CR>
nn <leader>X :!chmod -x %<CR>

" commentstring's
au FileType xdefaults setlocal commentstring=!\ %s
au FileType desktop,sxhkdrc,bib setlocal commentstring=#\ %s

" showing results
au FileType tex,markdown nn <leader>o :!openout %<CR><CR>
au FileType c,cpp nn <leader>o :!./%:r<CR>

" tex
let g:tex_flavor = "latex" " set filetype for tex
au FileType tex nn <leader>c :!texclear %:p:h<CR><CR>
au VimLeave *.tex !texclear %:p:h

" autoremove trailing whitespaces
nn <silent> <leader>w :%s/\s\+$//e <bar> nohl<CR>

" update ctags
com! Ctags execute "!updtags.sh"
nn <silent> <leader>t :Ctags<CR>

" search visually selected text with '//'
vn // y/\V<C-R>=escape(@",'/\')<CR><CR>

" replace visually selected text
vn <leader>s y:%s/<C-R>+//g<Left><Left>

" use K for c++ man pages
au FileType c,cpp setlocal keywordprg=cppman
" }}}

" {{{ TEMP (Ctrl not working)
nn <silent> <expr> <A-h> !exists('b:SplitResize') ? '<C-w><C-h>' : ':vert res -1<CR>'
nn <silent> <expr> <leader><leader>j !exists('b:SplitResize') ? '<C-w><C-j>' : ':res -1<CR>'
nn <silent> <expr> <leader><leader>k !exists('b:SplitResize') ? '<C-w><C-k>' : ':res +1<CR>'
nn <silent> <expr> <A-l> !exists('b:SplitResize') ? '<C-w><C-l>' : ':vert res +1<CR>'
nn <leader><leader>o <C-o>
nn <leader><leader>i <C-i>
nn <leader><leader>v <C-v>
nn <leader><leader>] <C-]>
nn <A-r> <C-r>
nn <A-a> <C-a>
nn <A-x> <C-x>
nn <A-w> <C-w>
nm <A-f> <C-f>
nn <silent> <leader><leader>n :Fern . -reveal=%<CR>
im \\k <C-k>
im \\f <C-x><C-f>
" }}}
