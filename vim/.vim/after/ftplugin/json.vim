" Additional Settings for json
" vim: foldmethod=marker
" Filetype check {{{1
if &filetype !=# 'json' || v:version < 700
  finish
endif

" Formatting {{{1
if executable('js-beautify')
    let &l:formatprg = 'js-beautify -f - -j -t -s ' . &shiftwidth
elseif executable('jq')
  let &l:formatprg=jq\ .
endif
