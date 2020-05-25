" Mimic the neovim cursor behavior in vim
if exists("g:loaded_cursor_shape")
  finish
endif
if has('nvim') || !has('autocmd')
  finish
endif
let g:loaded_cursor_shape = 1

"Ps = 0  -> blinking block.
"Ps = 1  -> blinking block (default).
"Ps = 2  -> steady block.
"Ps = 3  -> blinking underline.
"Ps = 4  -> steady underline.
"Ps = 5  -> blinking bar (xterm).
"Ps = 6  -> steady bar (xterm).

let &t_SI = "\e[5 q" "Start insert mode (bar cursor shape)
let &t_EI = "\e[2 q" "End insert or replace mode (block cursor shape)
