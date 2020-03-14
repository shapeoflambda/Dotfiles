" Some Basic Settings
setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab

" Use rustfmt as the formatprg
if executable("rustfmt")
  setlocal formatprg=rustfmt
endif

" Disable opening of the scratch buffer during completion
" setlocal completeopt-=preview

" Auto format using rustfmt
let g:rustfmt_autosave = 1

" (l)anguae mappings
nnoremap <leader>lr :Redir !cargo run<cr>
nnoremap <leader>ll :GoLint<cr>

nnoremap <silent> <leader>r<cr> :Redir !cargo run<CR>
nnoremap <silent> f<CR> ggVGgq

