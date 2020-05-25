" Returns 1 if file exists, else returns 0
fun! file_util#file_exists(file_path)
  if !empty(glob(a:file_path))
    return 1
  endif
  return 0
endfun
