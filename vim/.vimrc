" A sane vimrc
" vim: foldmethod=marker

" Plugins {{{1
" Vim plug install {{{2
if has('unix')
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
  endif
elseif has('win32')
  if empty(glob('~/vimfiles/autoload/plug.vim'))
    echom "Install vim-plug!"
  endif
endif

call plug#begin('~/.vim/plugged')

" Editing {{{2
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/vim-easy-align'

" Fuzzy find, everything! {{{2
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Git {{{2
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Snippets {{{2
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Look & feel {{{2
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'itchyny/lightline.vim'

call plug#end()

" Basics {{{1
set number
set relativenumber
set ignorecase
set smartcase
set incsearch
set hlsearch

set noswapfile
set scrolloff=3

set shiftwidth=2 tabstop=2
set expandtab
set backspace=indent,eol,start
set autoindent

filetype plugin indent on

set wildmenu                           " Use wildmenu
silent! set wildignorecase             " Case insensitive, if supported

set hidden
set showcmd

" Add completion options
if exists('+completeopt')
  set completeopt+=longest             " Insert longest common substring
  set completeopt+=menuone             " Show the menu even if only one match
endif

" Keep undo files, hopefully in a dedicated directory
if has('persistent_undo')
  set undofile
  set undodir^=~/.vim/cache/undo//
  if has('win32') || has('win64')
    set undodir-=~/.vim/cache/undo//
    set undodir^=~/vimfiles/cache/undo//
  endif
endif

" `matchit.vim` is built-in so let's enable it!
" " Hit `%` on `if` to jump to `else`.
runtime macros/matchit.vim

set diffopt+=vertical

" Look & Feel {{{1
syntax enable
set termguicolors
set background=dark
colorscheme dracula

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

set laststatus=2

" Mappings {{{1
" Leader {{{2
let mapleader=","

" Fuzzy finding mappings {{{2
" Find all (f)iles
nnoremap <leader>f :Files<cr>

" Find files tracked by git aka (g)it (f)iles
nnoremap <leader>gf :GitFiles<cr>

" Open (r)ecent (f)iles
nnoremap <leader>rf :History<cr>

" Find all open (b)uffers
nnoremap <leader>b :Buffers<cr>

" Find all available (c)olorschemes
nnoremap <leader>c :Colors<cr>

" Find all (t)ags
nnoremap <leader>t :Tags<cr>

" Find all (t)ags in the current (b)uffer
nnoremap <leader>tb :BTags<cr>

" Find all (s)nippets
nnoremap <leader>s :Snippets<cr>

" Find all (m)appings
nnoremap <leader>m :Maps<cr>

" }}}
" Cycle through stuff {{{2
" Cycle through argument list
nnoremap [a :previous<CR>
nnoremap ]a :next<CR>

" Cycle through buffers
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>

" Cycle through quicklist/:helpgrep items
nnoremap [c :cprevious<CR>
nnoremap ]c :cnext<CR>

" Cycle through location list items
nnoremap [l :lprevious<CR>
nnoremap ]l :lnext<CR>
nnoremap ]l :lnext<CR>

" Git {{{2
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gr :Gread<cr>
nnoremap <leader>ga :execute "normal \<Plug>GitGutterStageHunk"<cr>
nnoremap <leader>gu :execute "normal \<Plug>GitGutterUndoHunk"<cr>
nnoremap <leader>gp :execute "normal \<Plug>GitGutterPrevHunk"<cr>
nnoremap <leader>gn :execute "normal \<Plug>GitGutterNextHunk"<cr>

" Misc {{{2
" Fix typos staying in insert mode
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Copy to system's clipboard
xnoremap <C-c> "+y

" Stop (h)ighighting
nnoremap <leader>h :nohl<cr>
nnoremap <leader><cr> :nohl<cr>

" Strip (a)ll trailing white (s)paces
nnoremap <silent> <leader>as :call StripTrailingWhitespace()<cr>

" Retain selection when indenting
xnoremap < <gv
xnoremap > >gv

" Easy align mappings {{{2
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Autocommands {{{1
" Reload vimrc as soon as it's saved
augroup vimrc
  autocmd!
  autocmd! BufwritePost .vimrc source $MYVIMRC | call LightlineReload()
augroup END

" Plugin Settings {{{1
" Ultisnip Settings {{{2
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Lightline Settings {{{2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             ['readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'filetype' ],
      \              [  'gitbranch', 'fileformat', 'fileencoding' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

function! LightlineReload()
	call lightline#init()
	call lightline#colorscheme()
	call lightline#update()
endfunction
