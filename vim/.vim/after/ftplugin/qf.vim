nnoremap <buffer> <silent> <Left>
      \ :colder<cr> 
nnoremap <buffer> <silent> <Right>
      \ :cnewer<cr> 
nnoremap <buffer> ,a
      \ :Cfilter 
nnoremap <buffer> ,A
      \ :Cfilter! 

let b:undo_ftplugin .= '|nunmap <buffer> <Left>'
      \ . '|nunmap <buffer> <Right>'
      \ . '|nunmap <buffer> ,a'
      \ . '|nunmap <buffer> ,A'

setlocal number
let b:undo_ftplugin .= '|setlocal number<'

