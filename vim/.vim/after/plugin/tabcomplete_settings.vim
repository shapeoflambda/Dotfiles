if exists("g:loaded_tabcomplete_settings")
  finish
endif
let g:loaded_tabcomplete_settings = 1

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<S-tab>'

inoremap <silent><expr> <TAB> "\<C-R>=tabcomplete_settings#expand_or_jump()<cr>"
snoremap <silent><expr> <TAB> "\<C-R>=tabcomplete_settings#expand_or_jump()<cr>"

imap <expr> <silent> <cr> pumvisible() ? "\<C-y>" : "\<CR>"
smap <expr> <silent> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

" Tab & Shift-Tab to cycle through completion options
imap <expr> <silent> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-R>=UltiSnips#JumpBackwards()<CR>"

" If pum is visible, use Esc to dismiss the pum
inoremap <expr> <silent> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"

fun tabcomplete_settings#expand_or_jump()
  if pumvisible()
    return "\<C-n>"
  endif

  if coc#expandableOrJumpable()
    return "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>"
  endif

  call UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res==0
    return "\<Tab>"
  endif

  return ""
endf
