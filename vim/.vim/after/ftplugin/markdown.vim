setlocal nonumber norelativenumber

""""""""""""""""""""""
"  Spelling options  "
""""""""""""""""""""""
setlocal spelllang=en_us
setlocal spell
setlocal complete+=kspell

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Folding
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
nnoremap <leader>aa mmggVGgw`m
function! MarkdownFoldText()
  let foldsize = (v:foldend-v:foldstart)
  return getline(v:foldstart).' ('.foldsize.' lines)'
endfunction
setlocal foldtext=MarkdownFoldText()

" Mappings for bold and italics
xmap silent <leader>b <Tab>**<Tab><Tab>
xmap silent <leader>i <Tab>*<Tab><Tab>
