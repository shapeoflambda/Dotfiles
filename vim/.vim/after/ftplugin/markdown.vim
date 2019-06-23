setlocal spelllang=en_us
setlocal spell

setlocal complete+=kspell

" Folding based on heading levels. Source:
" https://gist.github.com/anonymous/4149842
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

function! MarkdownFoldText()
  let foldsize = (v:foldend-v:foldstart)
  return getline(v:foldstart).' ('.foldsize.' lines)'
endfunction

" Mapping to toggle status of TODO item
nnoremap <buffer> <silent> <space>  :call winrestview(<SID>toggle('^\s*\*\s*\[\zs.\ze\]', {' ': '.', '.': 'x', 'x': ' '}))<cr>

function! s:toggle(pattern, dict, ...)
  let view = winsaveview()
  execute 'keeppatterns s/' . a:pattern . '/\=get(a:dict, submatch(0), a:0 ? a:1 : " ")/e'
  return view
endfunction

" syntax highlighting for code blocks
let g:markdown_fenced_languages = ['java', 'go', 'html', 'vim', 'ruby', 'python', 'sh', 'bash=sh']

" format table under the cursor
nnoremap <buffer> <silent> <leader>\| vip:EasyAlign *\|<cr>
