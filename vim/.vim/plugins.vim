" This must be first, because it changes other options as a side effect.
set nocompatible

set runtimepath+=~/.vim/

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

" Plugins
call plug#begin('~/.local/share/nvim/plugged')

" Look and feel
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'Erichain/vim-monokai-pro'
Plug 'kaicataldo/material.vim'
Plug 'dracula/vim', { 'as': 'dracula' }

" Autocompletion
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'autozimu/LanguageClient-neovim', {
			\ 'branch': 'next',
			\ 'do': 'bash install.sh',
			\ }

" Linter
Plug 'w0rp/ale'

" NERDTree
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-icons'

" Snippets
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" Fuzzy finder FTW!
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Tabularize and Markdown
Plug 'junegunn/vim-easy-align'

" Tim Pope essentials
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'

" Language Plugins
Plug 'udalov/kotlin-vim'

" Go Lang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()
