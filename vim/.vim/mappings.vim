" Keybindings
let mapleader=","

" Disable arrow keys in normal mode
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>

" normal mode mappings
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

nmap gh <C-w>h
nmap gj <C-w>j
nmap gk <C-w>k
nmap gl <C-w>l

nnoremap <expr> <C-p> IsInsideGitRepo() ? ':GitFiles<CR>' : ':Files<CR>' "Respect gitignore if inside a git repo
nnoremap <leader><CR> : nohl<CR>
nnoremap <leader>@    : BTags<CR>
nnoremap <leader>b    : TagbarToggle<CR><C-w>w
nnoremap <leader>f    : BLines<CR>
nnoremap <leader>g    : Rg<CR>
nnoremap <leader>o    : w <Bar> !open %<CR>
nnoremap <leader>rf   : History<CR>
nnoremap <leader>t    : Tags<CR>

inoremap jj <Esc>

" Visual mode mappings
vnoremap <leader>s :sort<CR>
vnoremap <C-c> "+y
vnoremap > >gv
vnoremap < <gv
vnoremap J :m '>+1<CR>gv=gv	" Move selected lines down
vnoremap K :m '<-2<CR>gv=gv	" Move selected lines up

" Move to the end of yanked text after yank and paste
nnoremap p p`]
vnoremap y y`]
vnoremap p p`]

" Neosnippet mappings
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

function! IsInsideGitRepo()
	let root = split(system('git rev-parse --show-toplevel'), '\n')[0]
	return v:shell_error ? 0 : 1
endfunction

nnoremap vii :call SelectIndent()<CR>
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
