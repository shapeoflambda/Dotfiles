function! terminal#show_hide_terminal() abort
  if !exists('g:terminal_buffer_id') || !buflisted(g:terminal_buffer_id)
    return terminal#create_terminal()
  endif

  if bufwinnr(g:terminal_buffer_id) < 0
    silent execute '12sp'
    silent execute g:terminal_buffer_id . 'buffer'
    startinsert
  else
    silent execute bufwinnr(g:terminal_buffer_id) 'close'
  endif

endfunction

function terminal#run_command(command) abort
  let l:command = s:expand(a:command). "\n"

  if !exists('g:terminal_buffer_id') || !buflisted(g:terminal_buffer_id) || bufwinnr(g:terminal_buffer_id) < 0
    call terminal#show_hide_terminal()
  endif

  call jobsend(g:terminal_job_id, l:command)
endfunction

function! terminal#create_terminal() abort
  silent execute '12sp'
  silent execute 'terminal'
  let s:terminal_buffer_number = bufnr('')
  let g:terminal_buffer_id = s:terminal_buffer_number
  let g:terminal_job_id = b:terminal_job_id
  startinsert
  return s:terminal_buffer_number
endfunction

function! s:expand(command) abort
  let l:command = substitute(a:command, '[^\\]\zs%\(:[phtre]\)\+', '\=expand(submatch(0))', 'g')
  let l:command = substitute(l:command, '\c\\<cr>', g:term_eof, 'g')
  let l:path = expand('%:p')

  let l:command = substitute(l:command, '[^\\]\zs%', l:path, 'g')
  let l:command = substitute(l:command, '\\%', '%', 'g')

  return l:command
endfunction
