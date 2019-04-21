" My no/bare minimum plugins vimrc
" vim: foldmethod=marker

" Basics {{{1
set number
set relativenumber
set ignorecase
set smartcase
set incsearch
set hlsearch

set sw=2 ts=2 expandtab

filetype plugin indent on

" Look & Feel {{{1
syntax enable
colorscheme elflord

" Statusline {{{2
function! GitBranch()
  if executable("git")
    return trim(system("git branch 2> /dev/null | grep '*' | cut -d ' ' -f2"))
  endif
""
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?''.l:branchname.'   ':''
endfunction

set laststatus=2
set noshowmode
let g:currentmode={
  \ 'n'      : 'NORMAL',
  \ 'no'     : 'N·Operator Pending ',
  \ 'v'      : 'VISUAL',
  \ 'V'      : 'V·Line ',
  \ '\<C-V>' : 'V·Block ',
  \ 's'      : 'Select ',
  \ 'S'      : 'S·Line ',
  \ '\<C-S>' : 'S·Block ',
  \ 'i'      : 'INSERT',
  \ 'R'      : 'REPLACE',
  \ 'Rv'     : 'V·Replace ',
  \ 'c'      : 'Command ',
  \ 'cv'     : 'Vim Ex ',
  \ 'ce'     : 'Ex',
  \ 'r'      : 'Prompt ',
  \ 'rm'     : 'More ',
  \ 'r?'     : 'Confirm ',
  \ '!'      : 'Shell ',
  \ 't'      : 'Terminal '
  \}

set statusline=%{g:currentmode[mode()]}\       "Readable mode name
set statusline+=%t       "tail of the filename
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%=      "left/right separator
set statusline+=%{StatuslineGit()}
set statusline+=%{strlen(&fenc)?&fenc:'none'}\  "file encoding
set statusline+=%{&ff}\ "file format
set statusline+=%y\       "filetype
set statusline+=%l,   "cursor line
set statusline+=%c     "cursor column
set statusline+=\ %P\     "percent through file

" Whitespace {{{2
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Mappings {{{1
" Define leader
let mapleader=","

" Open (r)ecent (f)iles
nnoremap <leader>rf :browse oldfiles<cr>

" Stop (h)ighighting
nnoremap <leader>h :nohl<cr>

function! StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction
" Strip (a)ll trailing white (s)paces
nnoremap <leader>as :call StripTrailingWhitespace()<CR>

" Autocommands {{{1
" Reload vimrc as soon as it's saved
au! BufwritePost .vimrc source $MYVIMRC

" Autocompletion
inoremap <silent><expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <silent><expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
