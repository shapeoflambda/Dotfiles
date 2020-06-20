function! async_run#run_cmd(cmd) abort
  call scratch#close_all_existing_scratch_buffers()

  let s:current_window_id = win_getid()

  if exists('g:async_runner_window_height')
    let l:runner_window_height = g:async_runner_window_height
  else
    let l:runner_window_height = 12
  endif
  let s:scratch_properties = scratch#create_scratch_window(l:runner_window_height)

  "Take the cursor back to where it was
  call win_gotoid(s:current_window_id)

  call appendbufline(
        \ s:scratch_properties['buffer_number'],
        \ 0,
        \ "### [async_runner] running '" .. join(a:cmd, ' ') .. "'"
        \ )

  function! s:PrintToScratchBuffer(job_id, msg, event) closure
    call filter(a:msg, {idx, val ->  val != ''})

    let last_line = len(getbufline(s:scratch_properties['buffer_number'], 1, '$'))
    call appendbufline(s:scratch_properties['buffer_number'], last_line, a:msg)
  endfunction

  if has('nvim')
    let opt = {
          \ 'on_stdout': function('<SID>PrintToScratchBuffer'),
          \ }
    let run_job_id = jobstart(a:cmd, opt)
    echom '[async_runner] job started. Job ID: ' .. run_job_id
  else
    let opt = {
          \ 'mode': 'nl', 
          \ 'err_io': 'out',
          \ 'out_io': 'buffer', 
          \ 'out_buf': l:scratch_properties['buffer_number'], 
          \ }
    let job_run = job_start(a:cmd, opt)
  endif
endfunction
