" amazon-code-browser.vim - fugitive.vim extension for Amazon code browser and
" with some added functionalities. Added functionalities are view entire
" commit, reviews or jump to package if the word under the cursor is a package
" (useful when viewing) Config files.
" Maintainer: Harish Chandran <chndha@amazon.com>

if exists('g:loaded_codebrowser') || v:version < 700 || &compatible
  finish
endif
let g:loaded_codebrowser = 1

function! s:function(name) abort
  return function(substitute(a:name,'^s:',matchstr(expand('<sfile>'), '<SNR>\d\+_'),''))
endfunction

function! s:AmazonCodeBrowserUrl(opts, ...) abort
  if a:0 || type(a:opts) != type({})
    return ''
  endif

  let path = substitute(a:opts.path, '^/', '', '')
  let domain_pattern = 'amazon\.com'
  let domains = exists('g:fugitive_amazon_domains') ? g:fugitive_amazon_domains : []
  for domain in domains
    let domain_pattern .= '\|' . escape(split(domain, '://')[-1], '.')
  endfor

  let package_name = matchstr(a:opts.remote,'^\(ssh\:\/\/\|http\:\/\/\)git.amazon.com:\d\+\/pkg\/\zs\w\+')
  if package_name ==# ''
    return ''
  endif

  let root = 'https://code.amazon.com/packages/'.package_name

  if path =~# '^\.git/refs/heads/'
    return root . '/commits/' . path[16:-1]
  elseif path =~# '^\.git/refs/tags/'
    return root . '/src/' .path[15:-1]
  elseif path =~# '.git/\%(config$\|hooks\>\)'
    return root . '/admin'
  elseif path =~# '^\.git\>'
    return root
  endif

  if a:opts.commit =~# '^\d\=$'
    let commit = a:opts.repo.rev_parse('HEAD')
  else
    let commit = a:opts.commit
  endif

  if get(a:opts, 'type', '') ==# 'tree' || a:opts.path =~# '/$'
    let url = root
  elseif get(a:opts, 'type', '') ==# 'blobs' || a:opts.path =~# '[^/]$'
    let url = root . '/blobs/' . commit . '/--/' . path
    if get(a:opts, 'line1')
      let url .= '#L'. a:opts.line1
      if get(a:opts, 'line2')
        let url .= '-L' . a:opts.line2
      endif
    endif
  else
    let url = root . '/commits/' . commit
  endif

  return url
endfunction

if !exists('g:fugitive_browse_handlers')
  let g:fugitive_browse_handlers = []
endif

call insert(g:fugitive_browse_handlers, s:function('s:AmazonCodeBrowserUrl'))


"""""""""""""""""""""""""""""""""""""""""""
"  View the change for current line
"  Works with both old and new CR boards
"""""""""""""""""""""""""""""""""""""""""""
function! CodeBrowser(bang, option_value)
  if !executable('git')
    return
  endif

  if (a:option_value ==# 'package')
    call s:CodeViewPackage(a:bang)
    return
  endif

  let line_number = line('.')
  let log_msg = ChompedSystem('git blame -L '. line_number . ',+1 -- '. expand('%:p'). ' 2>/dev/null')

  if empty(log_msg)
    call s:Warn('Error! Please check the line is committed and that the current directory is within a git repo.')
    return
  endif

  let commit_hash = matchstr(log_msg, '^\(\^\zs\)\=\w\+\ze.*')

  if (a:option_value ==# 'review')
    call s:ViewCodeReviewForCommit(a:bang, commit_hash)
  elseif (a:option_value ==# 'commit')
    call s:ViewCommitInCodeBrowser(a:bang, commit_hash)
    return
  else
    call s:Warn('Invalid Option for Cbrowse!')
  endif

endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  View the code review for the currentline in CodeBrowser or CR board      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:ViewCodeReviewForCommit(bang, commit_hash)
  let full_commit_msg = ChompedSystem('git rev-list --format=%B --max-count=1 '. a:commit_hash)

  " Check if old CR was used
  let cr_url = matchstr(full_commit_msg, '^.*cr\s\+\zshttps:\/\/cr.amazon.com\/r\/\d\+')

  " If not old CR, check for new CR
  if empty(cr_url)
    let cr_url = matchstr(full_commit_msg, '^.*cr\s\+\zshttps:\/\/code.amazon.com\/reviews\/CR-\d\+')
  endif

  if empty(cr_url)
    call s:Warn('No CR link found in the commit: '. a:commit_hash)
    return
  endif

  call s:EchoOrOpenUrl(a:bang, cr_url)
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  View the commit for the currentline in CodeBrowser  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:ViewCommitInCodeBrowser(bang, commit_hash)
  let expanded_hash = ChompedSystem('git rev-parse '. a:commit_hash)

  " Check if the commit is in remote
  if (ChompedSystem('git branch -r --contains '. a:commit_hash) !~? 'origin')
    call s:Warn('Current line is part of a commit that is not in remote, yet')
    return
  endif

  let remote_url = ChompedSystem('git config --get remote.origin.url')
  let package_name = matchstr(remote_url,'^\(ssh\:\/\/\|http\:\/\/\)git.amazon.com:\d\+\/pkg\/\zs\w\+')
  if package_name ==# ''
    call s:Warn('The remote url is not an Amazon url')
    return
  endif

  let url = 'https://code.amazon.com/packages/'.package_name.'/commits/'.expanded_hash
  call s:EchoOrOpenUrl(a:bang, url)
  return
endfunction

function! s:EchoOrOpenUrl(bang, url)
  echo(a:url)

  " Copy the URL to system's clipboard
  if a:bang && has('clipboard')
    let @+ = a:url
    return
  endif

  call netrw#BrowseX(a:url, 0)
endfunction

"""""""""""""""""""""""""""
"  Prints error messages  "
"""""""""""""""""""""""""""
function! s:Warn(str) abort
  echohl WarningMsg
  echomsg a:str
  echohl None
  let v:warningmsg = a:str
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Executes a system command and removes newlines and whitespaces  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ChompedSystem( ... )
  return substitute(call('system', a:000), '\n\+$', '', '')
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Tab completion options for the Cbrowse command  "
""""""""""""""""""""""""""""""""""""""""""""""""""""
fun CbrowseOptions(A,L,P)
  let options = 'commit'. "\n". 'review'. "\n". 'package'
  return options
endfunction

function! s:CodeViewPackage(bang)
  let package_name = expand('<cword>')
  let package_url = 'https://code.amazon.com/packages/'. package_name

  call s:EchoOrOpenUrl(a:bang, package_url)
endfunction

command! -complete=custom,CbrowseOptions -nargs=1 -bang Cbrowse :call CodeBrowser(<bang>0, <f-args>)
