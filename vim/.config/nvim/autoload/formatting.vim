function! formatting#format_whole_buffer() abort
  let l:saved_view = winsaveview()

  normal! ggVGgq

  if v:shell_error > 0
    silent undo
    redraw
    echom 'Formatprg ' 
          \. &formatprg 
          \. ' exited with status ' 
          \. v:shell_error 
          \. '.'
  endif

  call winrestview(l:saved_view)
  unlet l:saved_view
endfunction
