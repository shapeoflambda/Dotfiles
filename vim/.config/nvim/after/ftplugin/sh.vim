" Most settings are dereived from the Google style guide fo shell scripts
" Link: https://google.github.io/styleguide/shellguide.html
setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab
let b:undo_ftplugin .= '|setlocal shiftwidth< tabstop< expandtab<'

setlocal colorcolumn=80
let b:undo_ftplugin .= '|setlocal colorcolumn<'

" If "shfmt" is installed use the same as formatprg
if executable('shfmt')
  let &l:formatprg='shfmt -i ' . &l:shiftwidth . ' -ln posix -sr -ci -s'
endif
let b:undo_ftplugin .= '|setlocal formatprg<'

" Stop here if autocmd is not supported
if ! has('autocmd')
  finish
endif

" Run scripts using <C-c><C-c>
nnoremap <buffer> <C-c><C-c>
      \ :w\|Trun sh %<CR>

let b:undo_ftplugin .= '|nunmap <buffer> <C-c><C-c>'

" Use bash as default compiler for shell scripts
compiler bash
let b:undo_ftplugin .= '|setlocal errorformat< makeprg<'

let b:make_program = &makeprg
let b:error_format = &errorformat
command! Make call luaeval('require"async_make".make(_A[1], _A[2])', [b:make_program, b:error_format])
