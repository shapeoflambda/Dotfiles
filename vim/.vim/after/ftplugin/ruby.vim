set shiftwidth=2
set tabstop=2
set expandtab

" Use rubocop as makeprg and frmatprg
" This is generally available via standard go install
if executable("rubocop")
  setlocal makeprg=rubocop\ -f\ s\ %
endif

" Mappings for vim-rails
nnoremap <leader>em :Emodel 
nnoremap <leader>ec :Econtroller 
nnoremap <leader>ef :Efunctionaltest 
nnoremap <leader>ei :Eintegrationtest 

" Since there are other leader e mapping, add one to quickly open Explorer
nnoremap <leader>ex :Explore<cr>

"""""""""""""
"  Testing  "
"""""""""""""
let test#strategy = "dispatch"
