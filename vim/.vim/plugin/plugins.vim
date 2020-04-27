" Editing {{{2
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/vim-easy-align'
Plug 'AndrewRadev/switch.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'justinmk/vim-sneak'
Plug 'justinmk/vim-dirvish'
Plug 'machakann/vim-highlightedyank'
Plug 'romainl/vim-cool'

" Fuzzy find, everything! {{{2
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Git {{{2
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'mhinz/vim-signify'

" Snippets {{{2
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Look & feel {{{2
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'lifepillar/vim-solarized8'
Plug 'lifepillar/vim-colortemplate'
Plug 'shapeoflambda/dark-purple.vim'
Plug 'cocopon/iceberg.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'fatih/molokai'
Plug 'lifepillar/vim-gruvbox8'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'itchyny/lightline.vim'
Plug 'psliwka/vim-smoothie'

" Tags {{{2
Plug 'ludovicchabant/vim-gutentags'

" Autocompletion & Language Plugins {{{2

" Golang {{{3
Plug 'fatih/vim-go', { 'for': 'go' }

" Rust {{{3
Plug 'rust-lang/rust.vim'

" Rails {{{3
Plug 'tpope/vim-rails'
Plug 'tpope/vim-dispatch'
Plug 'janko/vim-test'

" Coc with and extensions {{{3
Plug 'neoclide/coc.nvim', {'branch': 'release'}
