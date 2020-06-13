if exists('g:current_compiler')
  finish
endif
let g:current_compiler = 'pylint'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

" 7.4.191 is the earliest version with the :S file name modifier, which we
" really should use if we can
if v:version >= 704 || v:version == 704 && has('patch191')
  CompilerSet makeprg=pylint\ --msg-template=\'{path}:{line}:{column}:{msg_id}:{msg}\'\ --score=no\ %:S
else
  CompilerSet makeprg=pylint\ --msg-template=\'{path}:{line}:{column}:{msg_id}:{msg}\'\ --score=no\ %
endif
CompilerSet errorformat=%f:%l:%c:%t%n:%m,%-Z%p^%.%#,%-G%.%#  
