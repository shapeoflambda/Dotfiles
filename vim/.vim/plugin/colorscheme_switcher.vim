if exists("g:loaded_colorscheme_switcher")
  finish
endif
let g:loaded_colorscheme_switcher = 1

" Global terminal variable used to toggle colorscheme
let g:isLightTheme=0

" Set light theme
function! LightTheme()
  colorscheme gray
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             ['readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'filetype' ],
      \              [ 'gitbranch'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
  call LightlineReload()

  let g:isLightTheme=1
endfunction

" Set Dark theme
function! DarkTheme()
  if !exists('g:lightline')
    let g:lightline = ''
  endif

  colorscheme dark_purple

  let g:lightline = {
        \ 'colorscheme': 'dark_purple',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             ['readonly', 'filename', 'modified' ] ],
        \   'right': [ [ 'lineinfo' ],
        \              [ 'filetype' ],
        \              [ 'gitbranch'] ]
        \ },
        \ 'component_function': {
        \   'gitbranch': 'fugitive#head'
        \ },
        \ }
  call LightlineReload()

  let g:isLightTheme=0
endfunction

fun! ToggleColorScheme()
  if g:isLightTheme
    call DarkTheme()
  else
    call LightTheme()
  endif
endf


" Commands for switching/toggling color schemes
command Light call LightTheme()
command Dark call DarkTheme()
command ToggleColorScheme call ToggleColorScheme()

" Reload light line
function! LightlineReload()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

" Mappings to (t)oggle (c)olor schemes
nnoremap <silent> <leader>tc :ToggleColorScheme<cr>

call DarkTheme()
