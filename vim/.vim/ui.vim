" For Italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

set termguicolors
let g:gruvbox_italic = 1
let g:dracula_italic = 1
colorscheme dracula
set background=dark

" Statusline theme
let g:lightline = {
			\ 'colorscheme': 'material',
			\ 'active': {
			\   'right': [ [ 'lineinfo' ],
			\             [ 'filetype' ],
			\             [ 'gitinformation' ] ]
			\ },
			\ 'component_function': {
			\   'gitinformation': 'GitInformation',
			\ },
			\ }
highlight Comment cterm  = italic
highlight Function cterm = italic
highlight type cterm     = italic

" Function to show the current branch
function! GitInformation()
	let branch_name = call(function('fugitive#head'), [''])
	return  strlen(branch_name) > 0 ? ' '. branch_name : ""
endfunction
