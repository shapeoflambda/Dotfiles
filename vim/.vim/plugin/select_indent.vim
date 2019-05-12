" Visually select an indent block
function! SelectIndent()
  let cur_line = line(".")
  let cur_ind = indent(cur_line)

  let line = cur_line
  while indent(line - 1) >= cur_ind
    let line = line - 1
  endw
  exe "normal " . line . "G"
  exe "normal V"

  let line = cur_line
  while indent(line + 1) >= cur_ind
    let line = line + 1
  endw
  exe "normal " . line . "G"
endfunction

" mapping to select indented lines
nnoremap <silent> vii :call SelectIndent()<cr>
