function! GitBranch()
  if executable("git")
    return trim(system("git branch 2> /dev/null | grep '*' | cut -d ' ' -f2"))
  endif
  ""
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?''.l:branchname.'   ':''
endfunction
