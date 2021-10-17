if exists('g:loaded_fzf_settings')
  finish
endif
let g:loaded_fzf_settings = 1

" Fix erroneous Esc behavior
augroup FZF_ESC_BEHAVIOR
  autocmd!
  autocmd TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  autocmd FileType fzf tunmap <buffer> <Esc>
augroup END

" Global options
let $FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

" Layout preference
let g:fzf_layout = { 'window': { 'reverse': 1, 'width': 1, 'height': 0.4, 'yoffset': 1 } }  

" Mappings to open fzf commands
nnoremap ,F <cmd>Files<CR>
nnoremap ,b <cmd>Buffers<CR>
nnoremap ,gf <cmd>GitFiles<CR>
nnoremap ,h <cmd>Helptags<CR>
nnoremap ,rf <cmd>History<CR>
nnoremap ,rg <cmd>Rg<CR>
nnoremap <M-x> <cmd>Commands<CR>

" Fuzzy find vim config files
command! -bang VimFiles call fzf#vim#files('~/.config/nvim/',{'options': ['--layout=reverse', '--info=inline']}, <bang>-1)
nnoremap ,v <cmd>VimFiles<CR>

" Lsp mappings from gfanto/fzf-lsp.nvim
nnoremap ,@ <cmd>DocumentSymbols<CR>
nnoremap ,ld <cmd>Diagnostics<CR>
nnoremap ,lg <cmd>Definitions<CR>
nnoremap ,lr <cmd>References<CR>
