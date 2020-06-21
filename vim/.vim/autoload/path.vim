" Set append directories tracked by
function! path#SetSanePath() abort
	" Set a basic &path
	set path=.,,

  " Set directories tracked by git to the path. This means we exclude
  " directories not tracked by git like node_modules/ build/ target/
  call path#SetPathUsingGitDirectories()
endfunction

function! path#SetPathUsingGitDirectories() abort
  " If this can be done asynchronously, use async
  if has('channel') || has('nvim')
    call path#SetPathUsingGitDirectoriesAsync()
    return
  endif

  " Retrieve list of tracked directories
  let l:tree_command = 'git ls-tree -d --name-only HEAD'
  let l:git_directories = systemlist(l:tree_command . ' 2>/dev/null')

  if empty(l:git_directories)
    set path+=** "enable recursive search of there are no directories to ignore
    return
  endif

  " Remove dot directories
  let l:directories = filter(l:git_directories, { idx, val -> val !~ '^\.' })

  " Add recursive wildcard to each directory
  let l:final_directories = map(l:directories, { idx, val -> val . '/**' })

  " Add all directories to &path
  let &path .= join(l:final_directories, ',')
endfunction

function! path#SetDirsInPathNvim(job_id, msg, event) abort
  call path#SetDirsInPath(a:msg[0])
endfunction

function! path#SetDirsInPathVim(channel, msg) abort
  call path#SetDirsInPath(a:msg)
endfunction

function! path#SetDirsInPath(msg) abort
  let l:paths = split(a:msg, "\x0")
  call filter(l:paths, {_, val -> val !~ '^\.'})
  call map(l:paths, {_, val -> val . '/**'})

  let &path .= join(l:paths, ',')
endfunction

function! path#SetPathUsingGitDirectoriesAsync() abort
  let l:command = ['git', 'ls-tree', '-d', '-z', '--name-only', 'HEAD']
  if has('nvim')
    let opt = {
          \ 'on_stdout': function('path#SetDirsInPathNvim'),
          \ }
    call jobstart(l:command, opt)
  else
    let opt = { 'callback': 'path#SetDirsInPathVim' , 'err_io': 'null'}
    let job_directories = job_start(l:command, opt)
  endif
endfunction
