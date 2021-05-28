if exists('g:current_compiler')
  finish
endif
let g:current_compiler = 'bash'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=bash\ -n\ --\ %\ 1>\ /dev/null
CompilerSet errorformat=%f:\ line\ %l:\ %m
