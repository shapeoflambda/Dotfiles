"Basics
setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab
let b:undo_ftplugin .= '|setlocal shiftwidth< tabstop< expandtab<'

" Formatting
if executable('black')
  let &l:formatprg='black --quiet -'
  let b:undo_ftplugin .= '|setlocal formatprg<'
elseif executable('yapf')
  let &l:formatprg='yapf'
  let b:undo_ftplugin .= '|setlocal formatprg<'
endif

" Run scripts using <C-c><C-c>
nnoremap <buffer> <C-c><C-c>
      \ :w\|Redir !python3 -u %<CR> 
let b:undo_ftplugin .= '|nunmap <buffer> <C-c><C-c>'

nnoremap <buffer> <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
let b:undo_ftplugin .= '|nunmap <buffer> gd'

" Run scripts using <C-c><C-v>
nnoremap <buffer> <C-c><C-v>
      \ :w\|Trun python3 -u %<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <C-c><C-v>'

" Organize imports using LSP
nnoremap <buffer> ,i
      \ :PyrightOrganizeImports<CR>
let b:undo_ftplugin .= '|nunmap <buffer> ,i'

command! PyTestFile Trun pytest %
command! PyTestFunc exec 'Trun pytest % -k '. luaeval("require('ts_python').get_current_function_name()")

nnoremap <buffer> ,tt :PyTestFile<CR>
nnoremap <buffer> ,tf :PyTestFunc<CR>
let b:undo_ftplugin .= '|nunmap <buffer> ,tt'
let b:undo_ftplugin .= '|nunmap <buffer> ,tf'
