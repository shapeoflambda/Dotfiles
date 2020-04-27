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
  let s:uname = system("uname -s")
  if s:uname =~ "Darwin"
    nnoremap <silent> <leader>o :silent !open % -b com.google.Chrome<cr>
  else
    nnoremap <silent> <leader>o :silent !google-chrome-stable %<cr><cr>
  endif
endif

" Jump to the next and previous headings using ']]' and '[[' respectively
let s:headersRegexp = '\v^(#|.+\n(\=+|-+)$)'
function! MoveToNextHeader()
  if search(s:headersRegexp, 'W') == 0
    echo 'no next header'
  endif
endfunction

function! MoveToPreviousHeader()
  if search(s:headersRegexp, 'b') == 0
    echo 'no previous header'
  endif
endfunction

nnoremap <buffer> <silent> ]] :call MoveToNextHeader()<cr>
nnoremap <buffer> <silent> [[ :call MoveToPreviousHeader()<cr>

" Mapping to toggle status of TODO item
nnoremap <buffer> <silent> <space>  :call winrestview(<SID>toggle('^\s*\*\s*\[\zs.\ze\]', {' ': 'x', 'x': ' '}))<cr>

function! s:toggle(pattern, dict, ...)
  let view = winsaveview()
  execute 'keeppatterns s/' . a:pattern . '/\=get(a:dict, submatch(0), a:0 ? a:1 : " ")/e'
  return view
endfunction

" syntax highlighting for code blocks
let g:markdown_fenced_languages = ['java', 'go', 'html', 'vim', 'ruby', 'python', 'sh', 'bash=sh']

" format table under the cursor
nnoremap <buffer> <silent> <leader>\| vip:EasyAlign *\|<cr>
