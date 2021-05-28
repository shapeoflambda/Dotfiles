"Basics
setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab
let b:undo_ftplugin .= '|setlocal shiftwidth< tabstop< expandtab<'

" Formatting
if executable('yapf')
  let &l:formatprg='yapf'
  let b:undo_ftplugin .= '|setlocal formatprg<'
endif

" Run scripts using <C-c><C-c>
nnoremap <buffer> <C-c><C-c>
      \ :w\|Redir !python3 -u %<CR> 
let b:undo_ftplugin .= '|nunmap <buffer> <C-c><C-c>'

nnoremap <buffer> <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
let b:undo_ftplugin .= '|nunmap <buffer> gd'


setlocal include=^\\s*\\(import\\\|from\\)\\s*\\zs\\(\\S\\+\\s\\{-}\\)*\\ze\\($\\\|as\\)
function! PyInclude(fname)
  let parts = split(a:fname, ' import ')
  let l = parts[0]

  if len(parts) > 1
    let r = parts[1]
    let joined = join([l, r], '.')

    let filepath = substitute(joined, '\.', '/', 'g') . '.py'
    echom("filepath: " . filepath)
    let found = glob(filepath, 1)
    if found
      return filepath
    endif
  endif

  return substitute(l, '\.', '/', 'g') . '.py'
endfunction

setlocal includeexpr=PyInclude(v:fname)

" Run scripts using <C-c><C-v>
nnoremap <buffer> <C-c><C-v>
      \ :w\|Trun python3 -u %<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <C-c><C-v>'
