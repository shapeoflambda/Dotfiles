setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab
let b:undo_ftplugin .= '|setlocal shiftwidth< tabstop< expandtab<'

" Formatting
if executable('jq')
  let &l:formatprg='jq'
endif
let b:undo_ftplugin .= '|setlocal formatprg<'
