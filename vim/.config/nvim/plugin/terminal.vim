if exists('g:loaded_terminal')
  finish
endif
let g:loaded_terminal = 1

if !exists('g:term_eof')
  let g:term_eof = ''
end

"Open terminal in a bottom split
" nnoremap <C-t> <Cmd>12sp\|terminal<cr>
nnoremap <silent> <C-t> :call terminal#show_hide_terminal()<Cr>
tnoremap <silent> <C-t> <C-\><C-n>:call terminal#show_hide_terminal()<Cr>

tnoremap <Esc> <C-\><C-n>

" Switching splits
" Terminal mode:
tnoremap <A-h> <c-\><c-n><c-w>h
tnoremap <A-j> <c-\><c-n><c-w>j
tnoremap <A-k> <c-\><c-n><c-w>k
tnoremap <A-l> <c-\><c-n><c-w>l
tnoremap <A-Left> <c-\><c-n><c-w>h
tnoremap <A-Down> <c-\><c-n><c-w>j
tnoremap <A-Up> <c-\><c-n><c-w>k
tnoremap <A-Right> <c-\><c-n><c-w>l

 " Insert mode:
inoremap <M-h> <Esc><c-w>h
inoremap <M-j> <Esc><c-w>j
inoremap <M-k> <Esc><c-w>k
inoremap <M-l> <Esc><c-w>l
inoremap <M-Left> <Esc><c-w>h
inoremap <M-Down> <Esc><c-w>j
inoremap <M-Up> <Esc><c-w>k
inoremap <M-Right> <Esc><c-w>l

" Visual mode:
vnoremap <M-h> <Esc><c-w>h
vnoremap <M-j> <Esc><c-w>j
vnoremap <M-k> <Esc><c-w>k
vnoremap <M-l> <Esc><c-w>l
vnoremap <M-Left> <Esc><c-w>h
vnoremap <M-Down> <Esc><c-w>j
vnoremap <M-Up> <Esc><c-w>k
vnoremap <M-Right> <Esc><c-w>l

" Normal mode:
nnoremap <M-h> <c-w>h
nnoremap <M-j> <c-w>j
nnoremap <M-k> <c-w>k
nnoremap <M-l> <c-w>l 
nnoremap <M-Left> <Esc><c-w>h
nnoremap <M-Down> <Esc><c-w>j
nnoremap <M-Up> <Esc><c-w>k
nnoremap <M-Right> <Esc><c-w>l

nnoremap ,T :Trun 

command! -nargs=1 -complete=shellcmd Trun :call terminal#run_command(<q-args>)
command! -nargs=0 Tclear :call terminal#run_command('clear')
