"Basics
setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab
let b:undo_ftplugin .= '|setlocal shiftwidth< tabstop< expandtab<'

" Run the formatprg before saving
function! s:FormatBeforeSave()
  if ! exists('g:disable_auto_format')
    augroup python_autoformat_before_save
      autocmd!
      autocmd BufWritePre <buffer> call formatting#format_whole_buffer()
      let b:undo_ftplugin .= '|autocmd! python_autoformat_before_save'
    augroup END
  endif
endfunction

" Run the linter on save
function! s:RunMakeOnSave()
  if ! exists('g:disable_auto_make')
    augroup python_make_on_save
      autocmd!
      autocmd BufWritePost <buffer> execute 'silent Make'
    augroup END
    let b:undo_ftplugin .= '|autocmd! python_make_on_save'
  endif
endfunction

" Formatting
if executable('yapf')
  let &l:formatprg='yapf'
  let b:undo_ftplugin .= '|setlocal formatprg<'
  call <SID>FormatBeforeSave()
endif

" Linting
if executable('pylint')
  compiler pylint
  call <SID>RunMakeOnSave()
elseif executable('flake8')
  compiler flake8
  call <SID>RunMakeOnSave()
endif

nnoremap <buffer> <C-c><C-r> :Run !python3 -u %<cr>
let b:undo_ftplugin .= '|nunmap <buffer> <C-c><C-r>'
