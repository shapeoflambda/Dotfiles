set hidden "edit more than one unsaved buffers at a time
set ruler  "show the current line number

" Proper indentation setting
set shiftwidth=2
set tabstop=2
set expandtab
set autoindent
set smartindent

set backspace=indent,eol,start	"sane backspace setting

" Searching
set ignorecase
set smartcase
set hlsearch
set incsearch
set nowrapscan
set shortmess-=S "Display the number of matches
set shortmess-=s "Show the search hit bottom message

filetype plugin indent on "Enable filetype plugins

" Add completion options
if exists('+completeopt')
  set completeopt+=longest  " Insert longest common substring
  set completeopt-=menuone  " Don't show the menu even if only one match
endif

" Don't show a statusline if there's only one window
" This is the Vim default, but NeoVim changed it
if &laststatus != 1
  set laststatus=1
endif

" Another Neovim default, that I don't like
set wildoptions=

" Try to keep swapfiles in one system-appropriate dir
set directory^=~/.vim/cache/swap//
if has('win32') || has('win64')
  set directory-=~/.vim/cache/swap//
  set directory^=~/vimfiles/cache/swap//
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

set wildmenu "tab select options and filepath
set wildmode=full
set wildignorecase  "ignore case when searching in wildmenu

" Jump to the last position in the file while opening.
" From ":h last-postion-jump"
augroup LastPosition
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ |   execute "normal! g`\""
        \ |   execute "normal! zz"
        \ | endif
augroup end

" Use cursorline, which is made smarter by
" ~/.vim/plugin/smarter_cursorline.vim
if has('syntax')
  set cursorline
  syntax enable
endif

" Get matchit.vim, one way or another
if has('packages') && !has('nvim')
  packadd matchit
else
  silent! runtime macros/matchit.vim
endif

" Use my colorscheme if using the GUI or if we have 256 colors
if has('gui_running') || &t_Co >= 256
  set termguicolors

  augroup UseTermBackground
    autocmd!
    autocmd ColorScheme * highlight Normal guibg=NONE
  augroup END

  let ayucolor="mirage"
  silent! colorscheme ayu
endif

" If colors not set, then default with dark background
if !exists('g:colors_name')
  set background=dark
endif

" Set timeout
set timeout
set timeoutlen=3000
set ttimeoutlen=50

"Ultisnip settings
let g:UltiSnipsSnippetDirectories  = ["UltiSnips", "customsnippets"]
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsListSnippets        = "<C-s>"
let g:UltiSnipsEnableSnipMate      = 1
let g:UltiSnipsEditSplit           = "vertical"

" Mappings
" Files, directories, recent and tags
nnoremap ,e :Explore<cr>
nnoremap ,f :find 
nnoremap ,rf :Recent 
nnoremap ,v :VimFiles 
nnoremap ,t :tag *

" use the asynchronous version if possible
if ! (has('channel') || has('nvim'))
  nnoremap ,m :make<cr>
else
  nnoremap ,m :Make<cr>
endif

" Search for the highlighted text
xnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Stay in visual mode after (in|out)denting
xnoremap < <gv
xnoremap > >gv

" System clipboard integration
nnoremap gy "+y
xnoremap gy "+y

" gp/gP are built-in mappings, but I don't use them
nnoremap gp "+p
nnoremap gP "+P
xnoremap gp "+p
xnoremap gP "+P

" Fix typos staying in insert mode
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Splits
set splitright
nnoremap <c-p> :vnew<cr>
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j

if has('nvim')
  augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 300)
  augroup END
endif
