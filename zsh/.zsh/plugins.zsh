zplugin light skywind3000/z.lua

zplugin ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zplugin light tj/git-extras

zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/fast-syntax-highlighting

zplugin compinit >> /dev/null

zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
