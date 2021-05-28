if exists('g:loaded_grep')
  finish
endif
let g:loaded_grep = 1

" Set a faster grepprg if available
if executable('rg')
  " Rg supports smart case, we'll use it is smartcase is turned on in vim
  if &smartcase
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  else
    set grepprg=rg\ --vimgrep\ --no-heading
  endif
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" command! -nargs=+ Grep execute 'silent grep! <args>'
function! Grep(args)
  return system(&grepprg . ' ' . a:args)
endfunction

command! -nargs=+ Grep cgetexpr Grep(<f-args>)
nnoremap ,S :Grep 

" Operator for grepping use ,s<motion> or in visual mode for grepping
function! GrepOperator(type, ...)
  " We will select and yank to perform the operation.
  " So, saving the previous selection and default register
  " content, so that we can reset it after the operation is complete.
  let sel_save = &selection
  let &selection = 'inclusive'
  let reg_save = @@

  if a:0  " Invoked from Visual mode, use gv command.
    silent exe 'normal! gvy'
  elseif a:type ==# 'line'
    silent exe "normal! '[V']y"
  else
    silent exe 'normal! `[v`]y'
  endif

  " Grep and open if there are results
  execute 'Grep '. shellescape(@@)

  " Restore the default register content and previous selection
  let &selection = sel_save
  let @@ = reg_save
endfunction

" Mapping for grep operators
nnoremap <silent> ,s :set opfunc=GrepOperator<CR>g@
xnoremap <silent> ,s :<C-U>call GrepOperator(visualmode(), 1)<CR>
