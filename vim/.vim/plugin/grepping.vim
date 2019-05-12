"""""""""""""""""""
"  Sane Grepping  "
"""""""""""""""""""
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --hidden
    set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

""""""""""""""""""""""""""""""
"  Use Grep instead of grep  "
""""""""""""""""""""""""""""""
command! -nargs=+ -complete=file_in_path -bar Grep cgetexpr system(&grepprg . ' ' . shellescape(<q-args>))

""""""""""""""""""""""""""""""""""""""""""""""""
"  Grep for the current word under the cursor  "
""""""""""""""""""""""""""""""""""""""""""""""""
function! GrepCurrentWord()
  let current_word = expand("<cword>")
  execute "Grep " . current_word
endf

"""""""""""""""""""""""""""
"  Mappings for grepping  "
"""""""""""""""""""""""""""
nnoremap \ :Grep 
nnoremap <leader>\ :call GrepCurrentWord()<cr>
