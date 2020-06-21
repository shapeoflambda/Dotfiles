if exists('g:loaded_async_make')
  finish
endif

" Need async support of vim or neovim to use the plguin
if ! (has('channel') || has('nvim'))
  finish
endif
let g:loaded_async_make = 1

function! s:Make(...)
  if empty(&l:errorformat)
    echom '[async_make] Error format is not set for this filetype: ' . &filetype
    return
  endif

  call async_make#make(a:000)
endfunction

command -nargs=* Make call <SID>Make(<f-args>)
