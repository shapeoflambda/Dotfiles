" Custom text objects
" Credits: https://gist.github.com/romainl/c0a8b57a36aec71a986f1120e1931f20

if exists('g:loaded_text_objects')
  finish
endif
let g:loaded_text_objects = 1

" 24 simple pseudo-text objects
" -----------------------------
" i_ i. i: i, i; i| i/ i\ i* i+ i- i#
" a_ a. a: a, a; a| a/ a\ a* a+ a- a#
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#' ]
	execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
	execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
	execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
	execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

" line pseudo-text objects
" ------------------------
" il al
xnoremap il g_o^
onoremap il :<C-u>normal vil<CR>
xnoremap al $o0
onoremap al :<C-u>normal val<CR>

" number pseudo-text object (integer and float)
" ---------------------------------------------
" in
function! VisualNumber()
	call search('\d\([^0-9\.]\|$\)', 'cW')
	normal v
	call search('\(^\|[^0-9\.]\d\)', 'becW')
endfunction
xnoremap in :<C-u>call VisualNumber()<CR>
onoremap in :<C-u>normal vin<CR>

" buffer pseudo-text objects
" --------------------------
" id
xnoremap id :<c-u>normal! G$Vgg0<cr>
onoremap id :<C-u>normal vid<CR>

" square brackets pseudo-text objects
" -----------------------------------
" ir ar
xnoremap ir i[
xnoremap ar a[
onoremap ir :normal vi[<CR>
onoremap ar :normal va[<CR>

" block comment pseudo-text objects
" ---------------------------------
" i? a?
xnoremap a? [*o]*
onoremap a? :<C-u>normal va?V<CR>
xnoremap i? [*jo]*k
onoremap i? :<C-u>normal vi?V<CR>

" last change seudo-text objects
" -------------------------------
" ik ak
xnoremap ik `]o`[
onoremap ik :<C-u>normal vik<CR>
onoremap ak :<C-u>normal vikV<CR>

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

function! s:aroundIndentation()
	" select all text in the current indentation level including any emtpy
	" lines that precede or follow the current indentation level;
	"
	" the current implementation is pretty fast, even for many lines since it
	" uses "search()" with "\%v" to find the unindented levels
	"
	" NOTE: if the current level of indentation is 1 (ie in virtual column 1),
	"       then the entire buffer will be selected
	"
	" WARNING: python devs have been known to become addicted to this

	" magic is needed for this (/\v doesn't seem work)
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

	" NOTE: if l:start is 0, then search() failed; otherwise search() succeeded
	"       and l:start does not equal line('.')
	" FORMER: l:start is 0; so, if we add 1 to l:start, then it will match
	"         everything from beginning of the buffer (if you don't like
	"         this, then you can modify the code) since this will be the
	"         equivalent of "norm! 1G" below
	" LATTER: l:start is not 0 but is also not equal to line('.'); therefore,
	"         we want to add one to l:start since it will always match one
	"         line too high if search() succeeds

	" next, find first match (forwards & don't wrap or move cursor)
	let l:end = search(l:pat, 'Wn')

	" NOTE: if l:end is 0, then search() failed; otherwise, if l:end is not
	"       equal to line('.'), then the search succeeded.
	" FORMER: l:end is 0; we want this to match until the end-of-buffer if it
	"         fails to find a match for same reason as mentioned above;
	"         again, modify code if you do not like this); therefore, keep
	"         0--see "NOTE:" below inside the if block comment
	" LATTER: l:end is not 0, so the search() must have succeeded, which means
	"         that l:end will match a different line than line('.')

	if (l:end !=# 0)
		" if l:end is 0, then the search() failed; if we subtract 1, then it
		" will effectively do "norm! -1G" which is definitely not what is
		" desired for probably every circumstance; therefore, only subtract one
		" if the search() succeeded since this means that it will match at least
		" one line too far down
		" NOTE: exec "norm! 0G" still goes to end-of-buffer just like "norm! G",
		"       so it's ok if l:end is kept as 0. As mentioned above, this means
		"       that it will match until end of buffer, but that is what I want
		"       anyway (change code if you don't want)
		let l:end -= 1
	endif

	" finally, select from l:start to l:end
	execute 'normal! '.l:start.'G0V'.l:end.'G$o'

	" restore magic
	let &magic = l:magic
endfunction

" "around indentation" (indentation level and any surrounding empty lines)
xnoremap <silent> ai :<c-u>call <sid>aroundIndentation()<cr>
onoremap <silent> ai :<c-u>call <sid>aroundIndentation()<cr>
