" Custom Switch definitions to be used by the AndrewRadev/switch.vim plugin
" :help switch-customization
" vim: foldmethod=marker
if exists("g:loaded_switches")
  finish
endif
let g:loaded_switches = 1

" Mapping {{{1
nnoremap <silent> <Space><Space> :Switch<CR>

" FileTypes {{{1
" Java {{{2
autocmd FileType java let b:switch_custom_definitions =
      \ [
      \   [ 'private', 'protected', 'public' ],
      \   [ 'true', 'false' ]
      \ ]

" Python {{{2
autocmd FileType python let b:switch_custom_definitions =
      \ [
      \   [ 'True', 'False' ]
      \ ]

" Markdown {{{2
autocmd FileType markdown let b:switch_custom_definitions =
      \ [
      \   [ '^\s*\*\s*\[\zs\ \ze]', '^\s*\*\s*\\zsx\ze]' ]
      \ ]

" Git Rebase {{{2
autocmd FileType gitrebase let b:switch_custom_definitions =
      \ [
      \   [ 'pick', 'reword', 'edit', 'squash', 'fixup', 'exec' ]
      \ ]
