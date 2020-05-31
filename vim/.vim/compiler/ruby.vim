if exists('g:current_compiler')
  finish
endif
let g:current_compiler = 'ruby'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

" 7.4.191 is the earliest version with the :S file name modifier, which we
" really should use if we can
if v:version >= 704 || v:version == 704 && has('patch191')
  CompilerSet makeprg=ruby\ -c\ %:S
else
  CompilerSet makeprg=ruby\ -c\ %
endif
"test.rb:1: unterminated string meets end of file
CompilerSet errorformat=%f:%l:\ %m

