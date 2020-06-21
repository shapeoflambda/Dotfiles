" Auto open/close qf window based if there are results.
" Also use the max number of lines as 10 in the qf window.
if exists('g:loaded_better_qf')
  finish
endif
let g:loaded_better_qf = 1

augroup better_qf
  autocmd!
  autocmd QuickFixCmdPost [^l]* call OpenList('quickfix')
  autocmd QuickFixCmdPost l* call OpenList('location')

  " automatically close corresponding qflist when quitting a window
  if exists('##QuitPre')
    autocmd QuitPre * nested if &filetype != 'qf' | silent! cclose | endif
  endif
augroup end

function! OpenList(list_type)
  if a:list_type ==# 'quickfix'
    let l:items_length  = len(getqflist())
    if l:items_length == 0
      execute 'cclose'
      return
    endif

    " Open qf window with a max heoght of 10
    execute 'cwindow '. min([10, l:items_length])
    return
  endif

  " Do the same for location lists
  let l:items_length  = len(getloclist())
  if l:items_length == 0
    execute 'lclose'
    return
  endif

  " Open qf window with a max heoght of 10
  execute 'lwindow '. min([10, l:items_length])
endfunction

" Enable the handy Cfilter plugin if possible
if has('packages')
  packadd cfilter
endif
