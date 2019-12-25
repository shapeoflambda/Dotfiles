" Attempt at a sane vimrc
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
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/vim-easy-align'
Plug 'AndrewRadev/switch.vim'

" Fuzzy find, everything! {{{2
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Git {{{2
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

" Snippets {{{2
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Look & feel {{{2
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'lifepillar/vim-solarized8'
Plug 'shapeoflambda/dark-purple.vim'
Plug 'itchyny/lightline.vim'


" Autocompletion & Language Plugins {{{2
" Golang {{{3
Plug 'fatih/vim-go', { 'for': 'go' }
" Rust {{{3
Plug 'neomake/neomake'


" Coc with and extensions {{{2
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Extensions
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-emmet', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}

call plug#end()

" Basics {{{1
set ignorecase
set smartcase
set incsearch
set hlsearch

set noswapfile
set autoread

set shiftwidth=2 tabstop=2
set expandtab
set backspace=indent,eol,start
set autoindent

filetype plugin indent on

set wildmenu                           " Use wildmenu
silent! set wildignorecase             " Case insensitive, if supported

set hidden
set autoread
set showcmd
set noshowmode

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

set diffopt+=vertical,filler,algorithm:patience

" Look & Feel {{{1
syntax enable
set termguicolors

" Always show lightline
set laststatus=2

" Mappings {{{1
" Leader {{{2
let mapleader=","

" Fuzzy finding mappings {{{2
" Find all (f)iles
nnoremap <leader>f :Files<cr>

" Find files tracked by git aka (g)it (f)iles
nnoremap <leader>gf :GitFiles<cr>

" Find files in the ~/.vim directory
nnoremap <leader>v :call fzf#run({'options': '--prompt ">"', 'down': 20, 'dir': '~/.vim/', 'sink': 'e' })<cr>

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

" Use Rg for grepping
if executable('rg')
  nnoremap <leader>rg :Rg<cr>
endif

" }}}
" Git {{{2
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gr :Gread<cr>
nnoremap <leader>gbl :Gblame<cr>
nnoremap <leader>gbr :Gbrowse<cr>
xnoremap <leader>gbr :Gbrowse<cr>
nnoremap <leader>ga :execute "normal \<Plug>(GitGutterStageHunk)"<cr>
nnoremap <leader>gu :execute "normal \<Plug>(GitGutterUndoHunk)"<cr>
nnoremap [g :execute "normal \<Plug>(GitGutterPrevHunk)"<cr>
nnoremap ]g :execute "normal \<Plug>(GitGutterNextHunk)"<cr>

" Misc {{{2
" Open explorer
nnoremap <leader>e :Ex<cr>

" Fix typos staying in insert mode
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Copy to system's clipboard
xnoremap <C-c> "+y

" Stop (h)ighighting
nnoremap <silent> <leader>h :nohl<cr>
nnoremap <silent> <leader><cr> :nohl<cr>

" Strip (a)ll trailing white (s)paces
nnoremap <silent> <leader>as :call StripTrailingWhitespace()<cr>

" Retain selection when indenting
xnoremap < <gv
xnoremap > >gv

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" "in line" (entire line sans white-space; cursor at beginning--ie, ^)
xnoremap <silent> il :<c-u>normal! g_v^<cr>
onoremap <silent> il :<c-u>normal! g_v^<cr>

" "in document" (from first line to last; cursor at top--ie, gg)
xnoremap <silent> id :<c-u>normal! G$Vgg0<cr>
onoremap <silent> id :<c-u>normal! GVgg<cr>

" Easy align mappings {{{2
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Quickfix and Location list mappings {{{2
nnoremap <silent> <leader>qc :ccl<cr>
nnoremap <silent> <leader>lc :lcl<cr>

" Autocommands {{{1
" Reload vimrc as soon as it's saved
augroup vimrc
  autocmd!
  autocmd! BufwritePost .vimrc source $MYVIMRC | call LightlineReload()
  autocmd! BufwritePost *.vim source $MYVIMRC | call LightlineReload()
augroup END

" Open quickfix list as soon as messages are posted
" Useful when performing grep, make, etc.
augroup qfList
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END

" Plugin Settings {{{1
" Ultisnip Settings {{{2
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Gitgutter settings {{{2
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'

" coc settings {{{2
" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Remap keys for gotos
nnoremap <silent> gD <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gI <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Navigate diagnostics
nmap <silent> <leader>lp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>ln <Plug>(coc-diagnostic-next)

" Format the selected region
xmap <silent> <leader>lf  <Plug>(coc-format-selected)

" Fix autofix problem of current line
nmap <silent> <leader>lf  <Plug>(coc-fix-current)
