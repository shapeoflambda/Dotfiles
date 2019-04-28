" My no/bare minimum plugins vimrc
" vim: foldmethod=marker

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

set wildmenu
set hidden
set showcmd

" `matchit.vim` is built-in so let's enable it!
" " Hit `%` on `if` to jump to `else`.
runtime macros/matchit.vim

" Look & Feel {{{1
syntax enable
colorscheme elflord

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
nnoremap <leader>as :call StripTrailingWhitespace()<cr>

" Retain selection when indenting
xnoremap < <gv
xnoremap > >gv

" Autocompletion - Tab complete menu options
inoremap <silent><expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <silent><expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Autocommands {{{1
" Reload vimrc as soon as it's saved
augroup vimrc
  autocmd!
  autocmd! BufwritePost .vimrc source $MYVIMRC
augroup END
