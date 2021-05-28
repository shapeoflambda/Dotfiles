" Enable spell checking
setlocal spelllang=en_us
let b:undo_ftplugin .= '|setlocal spelllang<'

setlocal spell
let b:undo_ftplugin .= '|setlocal spell<'

" Jump to the next and previous headings using ']]' and '[[' respectively
let s:headersRegexp = '\v^(#|.+\n(\=+|-+)$)'
function! MoveToNextHeader()
  " W flag to prevent from wrapping search
  if search(s:headersRegexp, 'W') == 0
    echo 'Reached the last header!'
  endif
endfunction

function! MoveToPreviousHeader()
  if search(s:headersRegexp, 'bW') == 0
    echo 'Reached the first header!'
  endif
endfunction

nnoremap <buffer> <silent> ]] :call MoveToNextHeader()<cr>
nnoremap <buffer> <silent> [[ :call MoveToPreviousHeader()<cr>

let b:undo_ftplugin .= '|nunmap <buffer> ]]'
      \ . '|nunmap <buffer> [['

" syntax highlighting for code blocks
let g:markdown_fenced_languages = ['java', 'go', 'html', 'vim', 'ruby',
      \ 'python', 'sh', 'bash=sh']

if system('uname') =~ 'darwin'
  nnoremap <buffer> <silent> ,o :silent !open -a "Google Chrome" %<cr>:redraw!<cr>
  let b:undo_ftplugin .= '|nunmap <buffer> ,o'
endif

" Insert bullets automatically
" setlocal comments=b:*\ [\ ],b:*\ [x],b:*\ [X],b:-\ [\ ],b:-\ [x],b:-\ [X],b:*,b:-
setlocal formatoptions=tcroqln
let b:undo_ftplugin .= '|setlocal comments< formatoptions<'

setlocal conceallevel=1

" Mappings
xmap ga <Plug>(EasyAlign)
