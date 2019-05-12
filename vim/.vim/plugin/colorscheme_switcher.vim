" Set light theme
function! LightTheme()
  colorscheme gray
  let g:lightline = {
        \ 'colorscheme': 'PaperColor_light'
        \ }
  call LightlineReload()
endfunction

" Set Dark theme
function! DarkTheme()
  colorscheme dark_purple
  let g:lightline = {
        \ 'colorscheme': 'one'
        \ }
  call LightlineReload()
endfunction

command Light call LightTheme()
command Dark call DarkTheme()

" Reload light line
function! LightlineReload()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction
