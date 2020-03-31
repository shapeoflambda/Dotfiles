function! AutoReply()
  let previous_cmdline  = histget('cmd', -1)
  let previous_cmd      = split(previous_cmdline)[0]
  let previous_args     = split(previous_cmdline)[1:]

  let ignorecase    = &ignorecase
  set noignorecase
  let previous_cmd  = get(getcompletion(previous_cmd, 'command'), 0)
  let &ignorecase   = ignorecase

  if empty(previous_cmd)
    return
  endif

  if previous_cmd ==# 'global'
    call feedkeys(':', 'n')
  elseif previous_cmd ==# 'undolist'
    call feedkeys(':undo' . ' ', 'n')
  elseif previous_cmd ==# 'oldfiles'
    call feedkeys(':edit #<', 'n')
  elseif previous_cmd ==# 'marks'
    call feedkeys(':normal! `', 'n')

  elseif previous_cmd ==# 'changes'
    call feedkeys(':normal! g;', 'n')
    call feedkeys("\<S-Left>", 'n')
  elseif previous_cmd ==# 'jumps'
    call feedkeys(':normal!' . ' ', 'n')
    call feedkeys("\<C-O>\<S-Left>", 'n')

  elseif index(['ls', 'files', 'buffers'], previous_cmd) != -1
    call feedkeys(':buffer' . ' ', 'n')
  elseif index(['clist', 'llist'], previous_cmd) != -1
    call feedkeys(':silent' . ' ' . repeat(previous_cmd[0], 2) . ' ', 'n')
  elseif index(['dlist', 'ilist'], previous_cmd) != -1
    call feedkeys(':' . previous_cmd[0] . 'jump' . ' ' . join(previous_args), 'n')
    call feedkeys("\<Home>\<S-Right>\<Space>", 'n')
  endif
endfunction

augroup AutoReply
  autocmd!
  autocmd CmdlineLeave : call AutoReply()
augroup END
