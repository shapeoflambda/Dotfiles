"Basics
setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab
let b:undo_ftplugin .= '|setlocal shiftwidth< tabstop< expandtab<'

" Formatting
if executable('perltidy')
  let &l:formatprg='perltidy -q -st'
  let b:undo_ftplugin .= '|setlocal formatprg<'

  let &l:equalprg='perltidy -q -st'
  let b:undo_ftplugin .= '|setlocal equalprg<'
endif

