set nocompatible

filetype plugin indent on
set autoread
set backspace=indent,eol,start
set hidden
set hlsearch
set ignorecase smartcase
set incsearch
set laststatus=2	
set lazyredraw
set listchars=
set noerrorbells
set noshowmode 
set noswapfile
set novisualbell
set number relativenumber
set smartcase
set so=3
set expandtab
set shiftwidth=2
set tabstop=2
syntax on

" Don't save netrw history
let g:netrw_dirhistmax=0

" Source vimrc after saving
autocmd! bufwritepost .vimrc source % | call LightlineReload()
function! LightlineReload()
	call lightline#init()
	call lightline#colorscheme()
	call lightline#update()
endfunction

" Open the last opened poistion
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" persistent undo between file reloads 
if has('persistent_undo')
 set undofile
 set undodir=~/.vim/undodir
endif

" Use ripgrep as the default search program
if executable("rg")
	set grepprg=rg\ --vimgrep\ --no-heading
	set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
let g:ackprgg= 'rg --vimgrep --no-heading'

" Markdown settings
autocmd FileType markdown setlocal spell
set complete+=kspell
