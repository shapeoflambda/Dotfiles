" Show snippets available in the current context using pop-up menu
if exists('g:loaded_ultisnip_snippet_completion')
  finish
endif
let g:loaded_ultisnip_snippet_completion = 1

function! s:complete_ultisnips_snippets() abort
  if empty(UltiSnips#SnippetsInCurrentScope(1))
    return ''
  endif

  let l:word_to_complete = matchstr(strpart(getline('.'), 0, col('.') - 1), '\S\+$')
  let l:contain_word = 'stridx(v:val, l:word_to_complete)>=0'
  let l:candidates = map(filter(keys(g:current_ulti_dict_info), l:contain_word),
        \  "{
        \      'word': v:val,
        \      'menu': '[snip] '. g:current_ulti_dict_info[v:val]['description'],
        \      'dup' : 1,
        \   }")
  let from_where = col('.') - len(l:word_to_complete)
  if !empty(l:candidates)
    call complete(from_where, l:candidates)
  endif
  return ''
endfunction

inoremap <silent> <c-x><c-z> <c-r>=<sid>complete_ultisnips_snippets()<cr>
