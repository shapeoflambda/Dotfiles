" Call make asynchronously. Reuses ths makeprg and errorformat already set.
" Works for both vim and neovim
function! async_make#make(args)
  let cmd = split(&makeprg, ' ')

  " Include arguments to "Make" in the cmd
  let cmd += a:args

  " Some compilers use '%' instead of the recommended '%:S', so handling both
  call map(cmd, {_, val -> substitute(val, '%:S', expand('%'), '')})
  call map(cmd, {_, val -> substitute(val, '%', expand('%'), '')})

  " Clear the current quickfix list
  call setqflist([])

  " Vim and neovim has different jobstart APIs, supporting both
  if has('nvim')
    let opt = {
          \ 'on_stderr': function('async_make#process_erros_nvim'),
          \ 'on_stdout': function('async_make#process_erros_nvim'),
          \ 'on_exit': function('async_make#handle_job_exit_nvim')
          \ }
    call jobstart(cmd, opt)
  else
    let opt = {
          \ 'err_io': 'out',
          \ 'callback': 'async_make#process_errors_vim', 
          \ 'exit_cb': 'async_make#handle_job_exit_vim',
          \ }

    let job_make = job_start(cmd, opt)
  endif
endfunction

function! async_make#process_erros_nvim(job_id, msg, event)
  " Looks like a neovim specific issue, for some linters, it receives an empty line
  if empty(a:msg) || empty(a:msg[0])
    return
  endif

  call async_make#process_errors(a:msg)
endfunction

function! async_make#process_errors_vim(channel, msg)
  call async_make#process_errors(a:msg)
endfunction

function! async_make#process_errors(msg)
  let l:old_global_errorformat = &g:errorformat
  let l:old_local_errorformat = &l:errorformat

  " cgetexpr explicitly uses the global errorformat and not the buffer local
  " errorformat set in the ftplugin. Note: this also overwrites the buffer
  " local errorformat
  let &g:errorformat = &l:errorformat

  " Using add instead of get as errors get posted asynchronously
  caddexpr a:msg

  let &g:errorformat = l:old_global_errorformat
  let &l:errorformat = l:old_local_errorformat
endfunction

" Vim and neovim has different method signatures for on_exit callbacks
" Handle on exit for neovim
function! async_make#handle_job_exit_nvim(job_id, exit_code, event)
  call async_make#handle_job_exit(a:exit_code)
endfunction

function! async_make#handle_job_exit_vim(job, exit_code)
  call async_make#handle_job_exit(a:exit_code)
endfunction

function! async_make#handle_job_exit(exit_code)
  if a:exit_code == 0
    cclose
    echom '[async_make] DONE. - No errors to report'
  elseif a:exit_code > 125
    echom "Job failed with the exit status: " .. a:exit_code
  else
    if ! empty(getqflist())
      call setqflist([], 'a', {'title': 'async_make'})
      let l:qf_size = getqflist({'id' : 0, 'size' : 0}).size
      execute 'copen ' .. min([10, l:qf_size + 3])
    endif
  endif
endfunction

