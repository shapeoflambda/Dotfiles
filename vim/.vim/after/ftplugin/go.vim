setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab
let b:undo_ftplugin .= '|setlocal shiftwidth< tabstop< expandtab<'

" Use golangci-lint if installed, else use the standard go compiler
if executable('staticcheck')
  compiler staticcheck
else
  compiler go
endif
let b:undo_ftplugin .= '|setlocal errorformat< makeprg<'

" Formatting
" goimports both formats and imports missing symbols, hence the higher
" precedence
if executable('goimports')
  let &l:formatprg='goimports'
elseif executable('gofmt')
  let &l:formatprg='gofmt %'
endif
let b:undo_ftplugin .= '|setlocal formatprg<'

" Run the formatprg beofre saving
if ! exists('g:disable_auto_format')
  augroup go_autoformat_before_save
    autocmd!
    autocmd BufWritePre <buffer> call formatting#format_whole_buffer()
    let b:undo_ftplugin .= '|autocmd! go_autoformat_before_save'
  augroup END
endif

" Run make on save
if ! exists('g:disable_auto_make')
  augroup go_make_on_save
    autocmd!
    autocmd BufWritePost <buffer> execute 'silent Make'
  augroup END
  let b:undo_ftplugin .= '|autocmd! go_make_on_save'
endif
