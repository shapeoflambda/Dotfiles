" Make finding files using the find command faster and smarter 1. If inside a
" git repo, use the directories tracked by git, this helps filtering out
" directories like 'build', 'node_modules',etc. 2. Enable recursive search by
" smartly adding '**' to path/directories 3. Ignore filetypes we don't care
" about using wildignore.
if exists('g:loaded_faster_find')
  finish
endif
let g:loaded_faster_find = 1


" Set a sane path using information from git
call path#SetSanePath()

" Helper function for local scope
function! s:Wildignore() abort

  " New empty array
  let l:ignores = []

  " Archives
  let l:ignores += [
        \ '*.7z'
        \,'*.bz2'
        \,'*.gz'
        \,'*.jar'
        \,'*.rar'
        \,'*.tar'
        \,'*.xz'
        \,'*.zip'
        \ ]

  " Bytecode
  let l:ignores += [
        \ '*.class'
        \,'*.pyc'
        \ ]

  " Databases
  let l:ignores += [
        \ '*.db'
        \,'*.dbm'
        \,'*.sdbm'
        \,'*.sqlite'
        \ ]

  " Disk
  let l:ignores += [
        \ '*.adf'
        \,'*.bin'
        \,'*.hdf'
        \,'*.iso'
        \ ]

  " Documents
  let l:ignores += [
        \ '*.docx'
        \,'*.djvu'
        \,'*.odp'
        \,'*.ods'
        \,'*.odt'
        \,'*.pdf'
        \,'*.ppt'
        \,'*.xls'
        \,'*.xlsx'
        \ ]

  " Encrypted
  let l:ignores += [
        \ '*.asc'
        \,'*.gpg'
        \ ]

  " Executables
  let l:ignores += [
        \ '*.exe'
        \ ]

  " Fonts
  let l:ignores += [
        \ '*.ttf'
        \ ]

  " Images
  let l:ignores += [
        \ '*.bmp'
        \,'*.gd2'
        \,'*.gif'
        \,'*.ico'
        \,'*.jpeg'
        \,'*.jpg'
        \,'*.pbm'
        \,'*.png'
        \,'*.psd'
        \,'*.tga'
        \,'*.xbm'
        \,'*.xcf'
        \,'*.xpm'
        \ ]

  " Incomplete
  let l:ignores += [
        \ '*.filepart'
        \ ]

  " Objects
  let l:ignores += [
        \ '*.a'
        \,'*.o'
        \ ]

  " Sound
  let l:ignores += [
        \ '*.au'
        \,'*.aup'
        \,'*.flac'
        \,'*.mid'
        \,'*.m4a'
        \,'*.mp3'
        \,'*.ogg'
        \,'*.opus'
        \,'*.s3m'
        \,'*.wav'
        \ ]

  " System-specific
  let l:ignores += [
        \ '.DS_Store'
        \ ]

  " Translation
  let l:ignores += [
        \ '*.gmo'
        \ ]

  " Version control
  let l:ignores += [
        \ '.git'
        \,'.hg'
        \,'.svn'
        \ ]

  " Video
  let l:ignores += [
        \ '*.avi'
        \,'*.gifv'
        \,'*.mp4'
        \,'*.ogv'
        \,'*.rm'
        \,'*.swf'
        \,'*.webm'
        \ ]

  " Vim
  let l:ignores += [
        \ '*~'
        \,'*.swp'
        \ ]

  " If on a system where case matters for filenames, for any that had
  " lowercase letters, add their uppercase analogues
  if has('fname_case')
    for l:ignore in l:ignores
      if l:ignore =~# '\l'
        call add(l:ignores, toupper(l:ignore))
      endif
    endfor
  endif

  return join(l:ignores, ',')
endfunction

let &wildignore = s:Wildignore()
