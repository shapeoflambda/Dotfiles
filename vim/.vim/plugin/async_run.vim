if exists("g:loaded_async_run")
  finish
endif
" Need async support of vim or neovim to use the plguin
if ! (has('channel') || has('nvim'))
  finish
endif
let g:loaded_async_run = 1

function! s:AsyncRun(cmd)
  " Exitng if the command is not an external command
  if a:cmd !~ '^!'
    echom "[async_runner] Not an external command! You can only run a command prefixed with '!'"
    return
  endif

  let cmd = a:cmd =~' %'
        \ ? matchstr(substitute(a:cmd, ' %', ' ' . expand('%:p'), ''), '^!\zs.*')
        \ : matchstr(a:cmd, '^!\zs.*')
  let cmd = substitute(cmd, "^!", "", "")
  let cmd = split(cmd)
  let output = async_run#run_cmd(cmd)
endfunction

command! -nargs=1 -complete=command -bar Run silent call <SID>AsyncRun(<q-args>)
