" vim: foldmethod=marker

" Basics {{{1
set tabstop=2
set shiftwidth=2
set expandtab

" Linter {{{1
if executable('pylint')
  setlocal makeprg=pylint\ --output-format=parseable\ %
endif

" Code formatting {{{1
if executable('yapf')
  setlocal formatprg=yapf\ %
endif


" Mappings {{{1
" Execute python file from within vim
cabbrev <buffer> py3 Redir !python3 %
cabbrev <buffer> py2 w ! python
