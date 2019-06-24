""""""""""""""""""""""
"  Spelling options  "
""""""""""""""""""""""
setlocal spelllang=en_us
setlocal spell
setlocal complete+=kspell

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Folding based on heading levels. Source: https://gist.github.com/anonymous/4149842  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MarkdownFoldText()
  let foldsize = (v:foldend-v:foldstart)
  return getline(v:foldstart).' ('.foldsize.' lines)'
endfunction
setlocal foldtext=MarkdownFoldText()

function! MarkdownFolds()
  let thisline = getline(v:lnum)
  if match(thisline, '^##') >= 0
    return ">2"
  elseif match(thisline, '^#') >= 0
    return ">1"
  else
    return "="
  endif
endfunction

setlocal foldmethod=expr
setlocal foldexpr=MarkdownFolds()

""""""""""""""""""""
"  Format options  "
""""""""""""""""""""
set comments+=n:#
nnoremap <leader>aa mmggVGgw`mzz

""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Shortcut for opening & previewing current file  "
""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("unix")
  echom("something")
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"
    nnoremap <leader>o :!open % -b com.google.Chrome<cr>
    echom "has mac"
  endif
endif

nnoremap <buffer> <silent> ]] :call MoveToNextHeader()<cr>
nnoremap <buffer> <silent> [[ :call MoveToPreviousHeader()<cr>
