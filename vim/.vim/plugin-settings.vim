" Autocompletion Settings
set completeopt-=preview    "disable the annoying scratch windows
let g:LanguageClient_serverCommands = {
			\ 'python': ['/usr/local/bin/pyls'],
			\ 'ruby': ['solargraph', 'stdio'],
			\ 'kotlin': ['/Users/chndha/.config/nvim/tools/bin/kotlin-language-server'],
			\ }
augroup lsp
	au!
	au FileType ruby,python,kotlin setlocal omnifunc=LanguageClient#complete
	au FileType ruby,python,kotlin nn <buffer> <leader>h :call LanguageClient_textDocument_hover()<cr>
	au FileType ruby,python,kotlin nn <buffer> gd :call LanguageClient_textDocument_definition()<cr>
	au FileType ruby,python,kotlin nn <buffer> <F5> :call LanguageClient_textDocument_contextMenu()<cr>
	au FileType ruby,python,kotlin nn <buffer> <F2> :call LanguageClient_textDocument_rename()<cr>
	au FileType ruby,python,kotlin nn <buffer> <leader>u :call LanguageClient_textDocument_documentSymbol()<cr>
	au FileType ruby,python,kotlin nn <buffer> <leader>x :LanguageClientStop<cr>:LanguageClientStart<cr>
augroup END

augroup go
	autocmd!
	autocmd FileType go nn <buffer> <F2> :GoRename<CR>
	autocmd FileType go nn <buffer> <F5> :GoRun<CR>
	autocmd BufWritePost *.go :GoImports
augroup END
let g:go_fmt_command = "goimports"

" Javacomplete 2 settings
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" Use fzf for selecting auto comlpetion options
function! s:fzf_insert(data)
	execute 'normal!' (empty(s:fzf_query) ? 'a' : 'ciW')."\<C-R>=a:data\<CR>"
	startinsert!
endfunction

" ALE Settings
" Linters
let g:ale_linters = {
			\ 'java': ['checkstyle'] ,
			\ 'python': ['pylint'] ,
			\ }
" Fixers
let g:ale_fixers = {
      \   '*':          ['remove_trailing_lines', 'trim_whitespace'],
			\   'html':       ['tidy'],
			\   'javascript': ['prettier'],
			\   'json':       ['prettier'],
			\   'ruby':       ['rubocop'],
			\   'python':     ['yapf', 'isort'],
			\   'go':         ['gofmt', 'goimports'],
			\   'java':       ['google_java_format'],
			\   'xml':        ['xmllint'],
			\}
let g:ale_kotlin_languageserver_executable = "/Users/chndha/.config/nvim/tools/bin/kotlin-language-server"
let g:ale_java_google_java_format_options  = "-aosp"
let g:ale_java_checkstyle_options          = '-c ~/scripts/google_checks.xml'
let g:ale_lint_delay                       = 400
let g:ale_sign_error                       = '>>'
let g:ale_sign_warning                     = '--'
let g:ale_echo_msg_format                  = '[%linter%] %s' "Print which linter is complaining

" Filetype specific settings
filetype plugin indent on
autocmd FileType go     setlocal shiftwidth=4 tabstop=4 expandtab
autocmd FileType html   setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType ion    setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType java   setlocal shiftwidth=4 tabstop=4 expandtab
autocmd FileType json   setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType kotlin setlocal shiftwidth=4 tabstop=4 expandtab
autocmd FileType ruby   setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType zsh   setlocal shiftwidth=2 tabstop=2 expandtab
au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell! spelllang=en_us

autocmd FileType go         set formatprg=gofmt\ --stdin
autocmd FileType javascript set formatprg=prettier\ --stdin
autocmd FileType json       set formatprg=jq

" Go Settings
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types       = 1
let g:go_highlight_fields            = 1
let g:go_highlight_functions         = 1
let g:go_highlight_methods           = 1
let g:go_highlight_operators         = 1
let g:go_highlight_structs           = 1
let g:go_highlight_types             = 1

function! s:fzf_words(query)
	let s:fzf_query = a:query
	let matches = fzf#run({
				\ 'source':  'cat /usr/share/dict/words',
				\ 'sink':    function('s:fzf_insert'),
				\ 'options': '--no-multi --query="'.escape(a:query, '"').'"',
				\ 'down':    '40%'
				\ })
endfunction

"Fuzzy complete a dictionary word - Awesome! :O
inoremap <silent> <C-X><C-W> <C-o>:call <SID>fzf_words(expand('<cWORD>'))<CR>

" FZF Setttings
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=? -complete=dir GitFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --hidden --ignore .git -g '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
