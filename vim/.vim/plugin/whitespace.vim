if exists('g:loaded_strip_trailing_whitespace') || &compatible
  finish
endif
let g:loaded_strip_trailing_whitespace = 1

function! StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction
