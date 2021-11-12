" From https://gist.github.com/PeterRincker/69b536f303f648cc21ec2ff2282f8c4a
" This is an enhanced version of the snippet provided under :help diff-original-file.
" Where the original :DiffOrig only shows differences between the buffer in memory and the file on disk, :Diff can be used in two ways:
" against the file on disk, like the original, with:
"   `:Diff`
" against an arbitrary Git revision of the current file, with:
"   `:Diff HEAD`

if exists('g:loaded_diff')
  finish
endif
let g:loaded_diff = 1

function! Diff(spec)
    execute  'vnew'
    setlocal bufhidden=wipe buftype=nofile nobuflisted noswapfile
    let cmd = "++edit #"
    if len(a:spec)
        let cmd = "!git -C " . shellescape(fnamemodify(finddir('.git', '.;'), ':p:h:h')) . " show " . a:spec . ":#"
    endif
    execute "read " . cmd
    silent 0d_
    let &filetype = getbufvar('#', '&filetype')

    augroup Diff
      autocmd!
      autocmd BufWipeout <buffer> diffoff!
    augroup END

    diffthis
    wincmd p
    diffthis
    wincmd p
endfunction

command! -nargs=? Diff call Diff(<q-args>)
