set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" latex
Plugin 'ying17zi/vim-live-latex-preview'
Plugin 'lervag/vimtex'

" markdown
Plugin 'vim-pandoc/vim-pandoc-syntax'

" other
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'alvan/vim-closetag'
Plugin 'easymotion/vim-easymotion'
Plugin 'ervandew/supertab'
Plugin 'jiangmiao/auto-pairs'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'junegunn/goyo.vim'
Plugin 'lilydjwg/colorizer'
Plugin 'lyokha/vim-xkbswitch'
Plugin 'markonm/traces.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-airline/vim-airline'

" i3
Plugin 'PotatoesMaster/i3-vim-syntax'

" python plugins
Plugin 'vim-scripts/indentpython.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'w0rp/ale'

" theme
Plugin 'morhetz/gruvbox'
Plugin 'crusoexia/vim-monokai'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()

filetype plugin indent on
filetype plugin on
syntax on
set laststatus=0
set encoding=utf-8
set autoindent
set incsearch
set hlsearch
set hidden
set viminfo="-"
set clipboard=unnamedplus
set tabstop=4
set shiftwidth=4
set smarttab
set number
set relativenumber
set nobackup
set nowritebackup
set noundofile
set bg=dark
set modeline
set modelines=2
set noshowmode
set showcmd

" colorscheme
colo ron
au FileType python let g:gruvbox_contrast_dark='hard' | colo gruvbox
au FileType tex,markdown colo monokai

" change <paste> command behaviour
xnoremap p "_dp
xnoremap P "_dP

" disable Ex mode
nnoremap Q <nop>

" annoying keys
command! Q :q
command! W :w
command! WQ :wq
command! Wq :wq
command! -bang Q :q<bang>

" normal mode bindings
nnoremap <Enter> o<ESC>
nnoremap S i<Enter><ESC>
nnoremap <Backspace> i<Backspace><ESC>l
nnoremap <silent> gr :noh<Enter>
nnoremap gl $
nnoremap Y y$

" moving in insert mpde
inoremap <C-H> <Left>
inoremap <C-L> <Right>

" different cursors per mode
if (&term!='linux')
	let &t_SI = "\<Esc>[6 q"
	let &t_SR = "\<Esc>[4 q"
	let &t_EI = "\<Esc>[2 q"
endif

" folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" Split direction 
set splitbelow
set splitright

" Tab/split moving
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" bash script execution
augroup shexec
	au FileType sh nn <leader>e :w <bar> :echo system('./"' . expand('%') . '"')<cr>
	au FileType sh nn <leader>E :w <bar> :! ./% >/tmp/vim_sh.txt<cr> :new /tmp/vim_sh.txt<cr>
	au FileType sh nn <leader>a :w <bar> :! ./% 
augroup END

" python script execution and debugging
augroup pyexec
	au FileType python nn <leader>e :w <bar> :echo system('python "' . expand('%') . '"')<cr>
	au FileType python nn <leader>E :w <bar> :! python % >/tmp/vim_py.txt<cr> :new /tmp/vim_py.txt<cr>
	au FileType python nn <leader>B :!pudb3 %<cr>
augroup END

" groff compiling
augroup groff_compile
	au FileType nroff com! GroffCompile !groff -ms % -T pdf -t > %:r.pdf
	au FileType nroff nn <silent> <leader>e :w <bar> :GroffCompile<cr>
augroup END

" latex
augroup tex_compile
	au FileType tex com! TexCompile !pdflatex %
	au FileType tex nn <silent> <leader>e :w <bar> :TexCompile<cr>

	au FileType tex ino <leader><leader>f \frac{}<ESC>i
	au FileType tex ino <leader><leader>p \partial
	au FileType tex ino <leader><leader>b \begin{}<ESC>i
	au FileType tex ino <leader><leader>d \displaystyle
	au FileType tex ino <leader><leader>l \left(
	au FileType tex ino <leader><leader>r \right)
augroup END

" markdown compiling
augroup md_compile
	au FileType markdown com! MdCompile !pandoc % --pdf-engine=xelatex -V mainfont="DejaVu Sans" -o %:r.pdf
	au FileType markdown nn <silent> <leader>e :MdCompile<cr>

	au FileType markdown com! PresCompile !pandoc % -V lang=ru -t beamer -o %:r.pdf
	au FileType markdown nn <silent> <leader>E :PresCompile<cr>
augroup END

" calcurse
augroup calcurse
	au BufRead,BufNewFile /tmp/calcurse* set filetype=markdown
	au BufRead,BufNewFile ~/.calcurse/notes/* set filetype=markdown
augroup END

" markdown syntax
augroup pandoc_syntax
	au FileType markdown set filetype=markdown.pandoc
augroup END

" systemd service files
augroup systemd_syntax
	au BufRead,BufNewFile *.service set filetype=dosini
augroup END

" python pep8 indentations
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" enable autoswitching language
let g:XkbSwitchEnabled = 1

" NERDTree bind
let NERDTreeShowHidden = 1
nnoremap <silent> <C-N> :NERDTreeToggle<CR>

" Tag closing
let g:closetag_filenames = '*'
let g:closetag_filetypes = '*'
let g:closetag_shortcut = '>'
let g:closetag_emptyTags_caseSensitive = 1
nnoremap <silent> <leader>t :CloseTagToggleBuffer<CR>
au BufNewFile,BufRead * :CloseTagDisableBuffer<CR>

" Auto-pairs toggling
let g:AutoPairsShortcutToggle = '<leader>P'

" Nerd commenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
nmap <C-_> <plug>NERDCommenterInvert<ESC>j0
vmap <C-_> <plug>NERDCommenterInvert<ESC>j0
imap <C-_> <plug>NERDCommenterInsert

" colorizer
let g:colorizer_maxlines = 1000

" supertab
let b:SuperTabDisabled = 1

" ale
let g:ale_enabled = 0
let g:ale_fixers = {
\	'*': ['remove_trailing_lines', 'trim_whitespace'],
\	'python': ['autopep8', 'isort', 'black'],
\} 
let g:ale_linters = {
\	'python': ['flake8', 'pylint'],
\}

if (&term=='linux')
	let g:loaded_colorizer=1
	let g:loaded_nerdtree_git_status=1
endif

" airline
if (&term=='linux')
	let g:loaded_airline=1
	let g:loaded_airline_themes=1
else
	let g:airline_powerline_fonts = 1
	let g:airline_exclude_filetypes = ['text']
	let g:airline_theme='minimalist'
	let g:airline#extensions#tabline#enabled = 1
	let g:airline_extensions = ['branch', 'tabline', 'ale']
endif

augroup pycommands
	au FileType python
		\ let g:airline#extensions#ale#enabled = 1 |
		\ let b:SuperTabDisabled = 0 |
		\ let g:SuperTabDefaultCompletionType = 'context' |
		\ let g:jedi#force_py_version = 3 |
		\ let g:jedi#use_splits_not_buffers = "left" |
		\ let g:jedi#show_call_signatures = 2 |
		\ let g:jedi#popup_select_first = 0 |
		\ let b:ale_set_highlights = 1 |
		\ let b:ale_lint_on_text_changed = 'never' |
		\ let b:ale_lint_on_enter = 0 |
		\ let b:ale_completion_enabled = 0 |
		\ let b:ale_list_window_size = 5 |
		\ let b:ale_warn_about_trailing_blank_lines = 1 |
		\ let b:ale_warn_about_trailing_whitespace = 1

	au FileType python setlocal completeopt-=preview
	au FileType python call jedi#configure_call_signatures()

	au FileType python nnoremap <leader>l :ALELint<CR>
	au FileType python nnoremap <leader>f :ALEFix<CR>
	au FileType python nnoremap <leader>L :ALEToggle<CR>
augroup END
