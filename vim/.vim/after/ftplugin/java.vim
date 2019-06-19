" vim: foldmethod=marker

" Basics {{{1
setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab

" Linting settings {{{1
if executable('javac')
  setlocal makeprg=javac\ %
  setlocal errorformat+=%f:%l:\ %m

  " open quickfix list as soon as make is done
  autocmd QuickFixCmdPost * copen
endif

" Code formatting {{{1
if executable('google-java-format')
  setlocal formatprg=google-java-format\ -a\ %
endif

" format on save by default
let g:java_format_on_save=1

if g:java_format_on_save
  autocmd BufWritePost * exec "normal gggqG"
endif
