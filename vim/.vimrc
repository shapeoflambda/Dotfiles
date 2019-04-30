" A minimal vimrc
" vim: foldmethod=marker

" Plugins {{{1
" Download vim-plug if not already installed
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

" Essentials {{{2
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" Look and feel {{{2
Plug 'airblade/vim-gitgutter'

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

" Builtin file open
set wildcharm=<Tab>
set path-=/usr/include
nnoremap ,f :find **/*<Tab><S-Tab>

" Open (r)ecent (f)iles
nnoremap <leader>rf :browse oldfiles<cr>

" List all open (b)uffers
nnoremap <leader>b :buffers<cr>

" Stop (h)ighighting
nnoremap <leader>h :nohl<cr>

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

" Autocompletion - Tab complete menu options
inoremap <silent><expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <silent><expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Fix typos staying in insert mode
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Autocommands {{{1
" Reload vimrc as soon as it's saved
augroup vimrc
  autocmd!
  autocmd! BufwritePost .vimrc source $MYVIMRC
augroup END
