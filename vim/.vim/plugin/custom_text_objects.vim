" Defines some useful textobjects
" Mostly from https://vimways.org/2018/transactions-pending/
if exists('g:loaded_custom_text_objects')
  finish
endif
let g:loaded_custom_text_objects = 1

" "in line" (entire line sans white-space; cursor at beginning--ie, ^)
xnoremap <silent> il :<c-u>normal! g_v^<cr>
onoremap <silent> il :<c-u>normal! g_v^<cr>

" "around line" (entire line sans trailing newline; cursor at beginning--ie, 0)
xnoremap <silent> al :<c-u>normal! $v0<cr>
onoremap <silent> al :<c-u>normal! $v0<cr>

" "in document" (from first line to last; cursor at top--ie, gg)
xnoremap <silent> id :<c-u>normal! G$Vgg0<cr>
onoremap <silent> id :<c-u>normal! GVgg<cr>

function! s:inIndentation()
	" select all text in current indentation level excluding any empty lines
	" that precede or follow the current indentationt level;
	"
	" the current implementation is pretty fast, even for many lines since it
	" uses "search()" with "\%v" to find the unindented levels
	"
	" NOTE: if the current level of indentation is 1 (ie in virtual column 1),
	"       then the entire buffer will be selected
	"
	" WARNING: python devs have been known to become addicted to this

	" magic is needed for this
	let l:magic = &magic
	set magic

	" move to beginning of line and get virtcol (current indentation level)
	" BRAM: there is no searchpairvirtpos() ;)
	normal! ^
	let l:vCol = virtcol(getline('.') =~# '^\s*$' ? '$' : '.')

	" pattern matching anything except empty lines and lines with recorded
	" indentation level
	let l:pat = '^\(\s*\%'.l:vCol.'v\|^$\)\@!'

	" find first match (backwards & don't wrap or move cursor)
	let l:start = search(l:pat, 'bWn') + 1

	" next, find first match (forwards & don't wrap or move cursor)
	let l:end = search(l:pat, 'Wn')

	if (l:end !=# 0)
		" if search succeeded, it went too far, so subtract 1
		let l:end -= 1
	endif

	" go to start (this includes empty lines) and--importantly--column 0
	execute 'normal! '.l:start.'G0'

	" skip empty lines (unless already on one .. need to be in column 0)
	call search('^[^\n\r]', 'Wc')

	" go to end (this includes empty lines)
	execute 'normal! Vo'.l:end.'G'

	" skip backwards to last selected non-empty line
	call search('^[^\n\r]', 'bWc')

	" go to end-of-line 'cause why not
	normal! $o

	" restore magic
	let &magic = l:magic
endfunction

" "in indentation" (indentation level sans any surrounding empty lines)
xnoremap <silent> ii :<c-u>call <sid>inIndentation()<cr>
onoremap <silent> ii :<c-u>call <sid>inIndentation()<cr>
