" Some basics
setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab
let b:undo_ftplugin .= '|setlocal shiftwidth< tabstop< expandtab<'

function! s:CleverTab()
  " if pop-up menu (pum) is already visble then cycle through completion options
  if pumvisible()
    return "\<C-N>"
  endif

  " See if a snippet can be expanded
  call UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res!=0
    return ''
  endif

  " If at the begining of the line just hit tab
  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
    return "\<Tab>"
  endif

  " Else try to use the vim command-line completeion
  return "\<C-X>\<C-V>"
endfunction

inoremap <buffer> <Tab> <C-R>=<SID>CleverTab()<CR>
let b:undo_ftplugin .= '|iunmap <buffer> <Tab>'
