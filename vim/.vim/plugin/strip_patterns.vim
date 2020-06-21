" Strip anooying carriage return characters and trailing whitespaces
if exists('g:loaded_strip_patterns')
  finish
endif
let g:loaded_strip_patterns = 1

function! s:StripPatternInLines(pattern)
  let l:count = 0

  let l:num = 1
  while l:num <= line('$')
    let l:line = getline(l:num)
    if l:line =~# a:pattern
      call setline(l:num, substitute(l:line, a:pattern, '', ''))
      let l:count = l:count + 1
    endif
    let l:num = l:num + 1
  endwhile

  echomsg l:count.' lines trimmed'
  
endf

function! s:StripCarriageReturn() abort
  call <SID>StripPatternInLines('')
endf

function! s:StripTrailingWhitespace() abort
  call <SID>StripPatternInLines('\s\+$')
endf

command! StripTrailingWhitespace call <SID>StripTrailingWhitespace() 
command! StripCarriageReturn call <SID>StripCarriageReturn()
