if exists('g:loaded_fzf_settings')
  finish
endif
let g:loaded_fzf_settings = 1

" Fix erroneous Esc behavior
augroup FZF_ESC_BEHAVIOR
  autocmd!
  autocmd TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  autocmd FileType fzf tunmap <buffer> <Esc>
augroup END

" Layout preference
let g:fzf_layout = { 'window': { 'reverse': 1, 'width': 1, 'height': 0.4, 'yoffset': 1 } }  
