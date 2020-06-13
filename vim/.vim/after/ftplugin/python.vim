"Basics
setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab
let b:undo_ftplugin .= '|setlocal shiftwidth< tabstop< expandtab<'

" Formatting
if executable('yapf')
  let &l:formatprg='yapf'
  let b:undo_ftplugin .= '|setlocal formatprg<'
endif

" Run the formatprg beofre saving
if ! exists('g:disable_auto_format')
  augroup python_autoformat_before_save
    autocmd!
    autocmd BufWritePre <buffer> call formatting#format_whole_buffer()
    let b:undo_ftplugin .= '|autocmd! python_autoformat_before_save'
  augroup END
endif

" Linting
if executable('flake8')
  compiler flake8

  if ! exists('g:disable_auto_make')
    augroup go_make_on_save
      autocmd!
      autocmd BufWritePost <buffer> execute 'silent Make'
    augroup END
    let b:undo_ftplugin .= '|autocmd! go_make_on_save'
  endif
endif
