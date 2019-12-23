set shiftwidth=2
set tabstop=2
set expandtab

" Use rubocop as makeprg and frmatprg
" This is generally available via standard go install
if executable("rubocop")
  setlocal makeprg=rubocop\ -f\ s\ %
endif
