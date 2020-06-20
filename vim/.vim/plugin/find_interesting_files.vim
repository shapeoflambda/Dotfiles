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
  call filter(l:raw_recent_files, { idx, val -> file_util#file_exists(val)})

  " filter out the file currently open in the buffer
  if !empty(expand('%'))
    call filter(l:raw_recent_files, 'v:val != "' .. fnamemodify(expand('%'), ":~:.") .. '"')
  endif

  return filter(l:raw_recent_files, 'v:val =~ "' .. escape(a:argument_lead, '.') .. '"')
endfunction

command -nargs=1 -complete=customlist,<SID>recent_files Recent edit <args>

" Open files in the ~/.vim folder, excluding directories like ~/.vim/pack and
" ~/.vim/cache direcories
fun! s:find_vim_files(A, L, P)
  let l:vim_directories = []

  let l:vim_directories += ["~/.vim/after/**"]
  let l:vim_directories += ["~/.vim/autoload/**"]
  let l:vim_directories += ["~/.vim/colors/**"]
  let l:vim_directories += ["~/.vim/compiler/**"]
  let l:vim_directories += ["~/.vim/customsnippets/**"]
  let l:vim_directories += ["~/.vim/doc/**"]
  let l:vim_directories += ["~/.vim/ftdetect/**"]
  let l:vim_directories += ["~/.vim/plugin/**"]
  let l:vim_directories += ["~/.vim/syntax/**"]

  let match_pattern = '*' .. a:A .. '*' "Match any part of the file name
  return globpath(join(l:vim_directories, ','), l:match_pattern, 0, 1)
endf

command -nargs=1 -complete=customlist,<SID>find_vim_files VimFiles edit <args>
