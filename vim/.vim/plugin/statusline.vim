let g:currentmode={
  \ 'n'      : 'NORMAL',
  \ 'no'     : 'N-Operator Pending ',
  \ 'v'      : 'VISUAL',
  \ 'V'      : 'V-Line ',
  \ "\<C-v>" : 'V-Block ',
  \ 's'      : 'Select ',
  \ 'S'      : 'S-Line ',
  \ "\<C-S>" : 'S-Block ',
  \ 'i'      : 'INSERT',
  \ 'R'      : 'REPLACE',
  \ 'Rv'     : 'V-Replace ',
  \ 'c'      : 'Command ',
  \ 'cv'     : 'Vim Ex ',
  \ 'ce'     : 'Ex',
  \ 'r'      : 'Prompt ',
  \ 'rm'     : 'More ',
  \ 'r?'     : 'Confirm ',
  \ '!'      : 'Shell ',
  \ 't'      : 'Terminal '
  \}

function! CurrentMode()
  return get(g:currentmode, mode(), '')
endfunction
