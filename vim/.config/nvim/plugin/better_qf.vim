" Auto open/close qf window based if there are results.
" Also use the max number of lines as 10 in the qf window.
if exists('g:loaded_better_qf')
  finish
endif
let g:loaded_better_qf = 1

augroup better_qf
  autocmd!
  autocmd QuickFixCmdPost [^l]* execute 'TroubleToggle quickfix' 
  autocmd QuickFixCmdPost l* execute 'TroubleToggle loclist'

  " automatically close corresponding qflist when quitting a window
  if exists('##QuitPre')
    autocmd QuitPre * nested if &filetype != 'qf' | silent! cclose | endif
  endif
augroup end

" Enable the handy Cfilter plugin if possible
if has('packages')
  packadd cfilter
endif
