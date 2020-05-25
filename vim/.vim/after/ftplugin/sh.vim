" Most settings are dereived from the Google style guide fo shell scripts
" Link: https://google.github.io/styleguide/shellguide.html
setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab
let b:undo_ftplugin .= '|setlocal shiftwidth< tabstop< expandtab<'

setlocal colorcolumn=80
let b:undo_ftplugin .= '|setlocal colorcolumn<'

" Use bash as default compiler for shell scripts
compiler bash
let b:undo_ftplugin .= '|setlocal errorformat< makeprg<'

" If "shfmt" is installed use the same as formatprg
if executable('shfmt')
  let &l:formatprg='shfmt -i ' . &l:shiftwidth . ' -ln posix -sr -ci -s'
endif
let b:undo_ftplugin .= '|setlocal formatprg<'

" Stop here if autocmd is not supported
if ! has('autocmd')
  finish
endif

" Format using the formatprg
if ! exists('g:shell_format_on_save')
  augroup shell_format_on_save
    autocmd!
    autocmd BufWritePost <buffer> execute 'normal! gqid'
          \ . '| redraw!'
  augroup END
endif
let b:undo_ftplugin .= '|autocmd! shell_format_on_save'

" Run make on save
if ! exists('g:disable_auto_make')
  augroup shell_make_on_save
    autocmd!
    autocmd BufWritePost <buffer> execute 'silent make'
  augroup END
endif
let b:undo_ftplugin .= '|autocmd! shell_make_on_save'
