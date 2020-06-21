" Returns 1 if file exists, else returns 0
function! file_util#file_exists(file_path) abort
  if !empty(glob(a:file_path))
    return 1
  endif
  return 0
endfunction
