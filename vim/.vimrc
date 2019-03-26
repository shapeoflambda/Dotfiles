let configs = [
\  "general",
\  "mappings",
\  "plugins",
\  "plugin-settings",
\  "ui",
\]
for file in configs
  let x = expand("~/.vim/".file.".vim")
  if filereadable(x)
    execute 'source' x
  endif
endfor
