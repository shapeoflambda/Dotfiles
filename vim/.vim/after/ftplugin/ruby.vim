" Use "rubocop" if installed, else fallback to ruby syntax check
if executable('rubocop')
  compiler rubocop
else
  compiler ruby
endif
let b:undo_ftplugin .= '|setlocal errorformat< makeprg<'

let b:make_on_save=1
