" Find interesting files like oldfiles and files in the ~/.vim directory using
" the ":Recent" and the ":VimFiles" commands respectively.
if exists("g:find_interesting_files")
  finish
endif
let g:find_interesting_files = 1

" Shorten files to current/home directories if possible
fun! s:shorten_file_paths(raw_file_paths)
  return map(a:raw_file_paths, { idx, val -> fnamemodify(expand(val), ":~:.") })
endf

" Open recent files
function! s:recent_files(argument_lead, L, P)
  let l:raw_recent_files = <SID>shorten_file_paths(copy(v:oldfiles))

  " filter out files that don't exist anymore!
  let l:raw_recent_files = filter(l:raw_recent_files, { idx, val -> file_util#file_exists(val)})

  return join(l:raw_recent_files, "\n")
endfunction

command -nargs=1 -complete=custom,<SID>recent_files Recent edit <args>

" Open files in the ~/.vim folder, excluding ~/.vim/pack and ~/.vim/cache
" direcories
fun! s:find_vim_files(A, L, P)
  if executable('fd')
    let l:vimfiles = systemlist('fd "" ~/.vim --exclude "/pack" --exclude "/cache" --type f --color "never"')
  elseif executable('rg')
    let l:vimfiles = systemlist('rg ~/.vim --files -g "\!**/.vim/pack/**" -g "\!**/.vim/cache/**"')
  else
    let l:vimfiles = systemlist('find ~/.vim/ -type f -not -path "*.vim//pack*" -not -path "*.vim//cache*"')
  endif

  let l:vimfiles += ['~/.vimrc']

  return join(<SID>shorten_file_paths(l:vimfiles), "\n")
endf

command -nargs=1 -complete=custom,<SID>find_vim_files VimFiles edit <args>
