function scratch#create_scratch_window(window_height)
  if ! &splitbelow
    setlocal splitbelow
    execute a:window_height .. 'new'
    setlocal nosplitbelow
  else
    execute a:window_height .. 'new'
  endif
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
  let w:scratch = 1

  return {"buffer_number": bufnr(), "window_id": win_getid()}
endfunction

function scratch#close_all_existing_scratch_buffers()
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
endfunction

