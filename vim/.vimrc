" A minimal vimrc
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

" Fuzzy find, everything! {{{2
Plug 'junegunn/fzf.vim'

" Git {{{2
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Snippets {{{2
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

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

" Look & Feel {{{1
syntax enable
set background=dark
colorscheme kuroi

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Statusline {{{2
set laststatus=2
set noshowmode

set statusline=%{CurrentMode()}\                 "Readable mode name
set statusline+=%t                               "tail of the filename
set statusline+=%m                               "modified flag
set statusline+=%r                               "read only flag
set statusline+=%=                               "left/right separator
set statusline+=%{StatuslineGit()}               "git branch name
set statusline+=%{strlen(&fenc)?&fenc:'none'}\   "file encoding
set statusline+=%{&ff}\                          "file format
set statusline+=%y\                              "filetype
set statusline+=%l,                              "cursor line
set statusline+=%c                               "cursor column
set statusline+=\ %P\                            "percent through file

" Mappings {{{1
" Define leader
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

" }}}

" Stop (h)ighighting
nnoremap <leader>h :nohl<cr>
nnoremap <leader><cr> :nohl<cr>

" Strip (a)ll trailing white (s)paces
nnoremap <silent> <leader>as :call StripTrailingWhitespace()<cr>

" Retain selection when indenting
xnoremap < <gv
xnoremap > >gv

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

" Fix typos staying in insert mode
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Copy to system's clipboard
xnoremap <C-c> "+y

" Autocommands {{{1
" Reload vimrc as soon as it's saved
augroup vimrc
  autocmd!
  autocmd! BufwritePost .vimrc source $MYVIMRC
augroup END
