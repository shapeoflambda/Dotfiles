function! scratch#create_scratch_window(window_height) abort
  execute 'botright ' . a:window_height . 'new'
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
  let w:scratch = 1

  return {'buffer_number': bufnr(), 'window_id': win_getid()}
endfunction

function! scratch#close_all_existing_scratch_buffers() abort
  let l:current_window_id = win_getid()
  "Close any existing scratch buffers
  for win in range(1, winnr('$'))
    if getwinvar(win, 'scratch')
      try
        execute win . 'windo close'
      catch
        echom 'Failed to close an existing scratch buffer'
      endtry
    endif
  endfor
  silent call win_gotoid(l:current_window_id)
endfunction

