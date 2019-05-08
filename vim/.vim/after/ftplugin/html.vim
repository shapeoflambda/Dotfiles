" Additional Settings for html
" vim: foldmethod=marker
" Filetype check {{{1
if &filetype !=# 'html' || v:version < 700
  finish
endif

" Formatting {{{1
if executable('html-beautify')
    let &l:formatprg = 'html-beautify -f - -I -s ' . &shiftwidth
endif
