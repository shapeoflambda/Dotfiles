" Use vim-plug to install and manage plugins
if has('unix')
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
  endif
endif

" Plugins
call plug#begin('~/.vim/plugged')
" Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'romainl/vim-cool'

" Fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'machakann/vim-highlightedyank'

Plug 'tpope/vim-fugitive'

" Color Schemes
Plug 'ayu-theme/ayu-vim'

"On Demand Plugins
Plug 'junegunn/vim-easy-align', { 'for': 'markdown' }

"Language plugins
Plug 'udalov/kotlin-vim'

" LSP & Autocompletion for neovim
if has('nvim')
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'
  Plug 'nvim-lua/lsp-status.nvim'
endif

call plug#end()

if has('nvim')
  " Recommended autocompletion settings
  " Use <Tab> and <S-Tab> to navigate through popup menu
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

  " Set completeopt to have a better completion experience
  set completeopt=menuone,noinsert,noselect

  " Avoid showing message extra message when using completion
  set shortmess+=c

  " Enable Snippet completion
  let g:completion_enable_snippet = 'UltiSnips'

  " Complete parentheses for functions
  let g:completion_enable_auto_paren = 1


lua <<EOF
local lsp_status = require('lsp-status')
local completion = require('completion')
local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
  lsp_status.on_attach(client, bufnr)
  completion.on_attach(client, bufnr)

  -- Keybindings for LSPs
  -- Note these are in on_attach so that they don't override bindings in a non-LSP setting
  vim.fn.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", {noremap = true, silent = true})
end

lsp_status.register_progress()
lsp_status.config({
  status_symbol = '',
  indicator_errors = 'e',
  indicator_warnings = 'w',
  indicator_info = 'i',
  indicator_hint = 'h',
  indicator_ok = 'ok',
})

lspconfig.pyls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
lspconfig.gopls.setup{
  on_attach = on_attach,
}
lspconfig.vimls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
lspconfig.jsonls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
lspconfig.html.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
EOF
endif

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

  " let g:tokyonight_style = 'night' " available: night, storm
  " let g:tokyonight_enable_italic = 1

  " colorscheme tokyonight
  let ayucolor='mirage'
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
let g:UltiSnipsSnippetDirectories  = ['UltiSnips', 'customsnippets']
let g:UltiSnipsExpandTrigger       = '<tab>'
let g:UltiSnipsJumpForwardTrigger  = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsListSnippets        = '<C-s>'
let g:UltiSnipsEnableSnipMate      = 1
let g:UltiSnipsEditSplit           = 'vertical'

" Mappings
" Files, directories, recent and tags
nnoremap ,e :Explore<cr>
nnoremap ,f :find 
nnoremap ,rf :History<cr>
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

" FZF Mappings
nnoremap ,F :GFiles<cr>
nnoremap ,b :Buffers<cr>
nnoremap ,l :Lines<cr>

if has('nvim')
  augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 300)
  augroup END
endif

if &term ==? 'st-256color' && ! has('nvim')
  " set Vim-specific sequences for RGB colors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
