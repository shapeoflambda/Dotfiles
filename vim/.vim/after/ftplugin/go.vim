" Some Basic Settings
setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab

" Syntax highlighting for the go plugin
let g:go_highlight_fields    = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods   = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs   = 1
let g:go_highlight_types     = 1

" Enable auto import
let g:go_fmt_command = "goimports"

" Use go language server for completion, only when asked for!
" If not available already install by:
" go get -u golang.org/x/tools/cmd/gopls
if executable("gopls")
  let g:go_def_mode = "gopls"
endif

" Use gofmt as the formating program
" This is generally available via standard go install
if executable("gofmt")
  setlocal formatprg=gofmt
endif

" Disable opening of the scratch buffer during completion
setlocal completeopt-=preview

" (G)o mappings
nnoremap <leader>gr :GoRun<cr>
nnoremap <leader>gl :GoLint<cr>
nnoremap <leader>gb :GoBuild<cr>
nnoremap <leader>gt :GoTest<cr>
nnoremap <leader>gr :GoRun<cr>
nnoremap <leader>ga :GoAlternate<cr>
nnoremap <leader>gc :GoCoverageToggle<cr>
nnoremap <leader>rn :GoRename<cr>

nnoremap <silent> <leader>r :w<CR>:vsplit <bar> terminal go run %<CR>
nnoremap <silent> f<CR> ggVGgq

" show documentation in the pop-up menu instead of opening a scratch buffer
let go_doc_popup_window=1
