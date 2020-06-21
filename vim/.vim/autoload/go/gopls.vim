function! go#gopls#go_to_definition() abort
  let l:filename = expand('%')
  let l:currentline = line('.')
  let l:column = col('.')

  let l:definition_output = systemlist('gopls query definition ' . l:filename . ':'
        \ . l:currentline . ':' . l:column)
  if v:shell_error != 0
    return
  endif

  let l:definition_info = split(l:definition_output[0], ':', '')
  if fnamemodify(l:definition_info[1], ':p') == expand('%:p')
    let edit_cmd = 'normal ' . l:definition_info[1] . 'G'
  else
    let edit_cmd = 'edit +' . l:definition_info[1] . ' ' . fnameescape(l:definition_info[0])
  endif
  execute edit_cmd
  execute 'normal ' . split(l:definition_info[2], '-', '')[0] . '|'
endfunction

