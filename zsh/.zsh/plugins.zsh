zplugin light rupa/z

zplugin ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zplugin light tj/git-extras

zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/fast-syntax-highlighting

# Oh my zsh plugins
zplugin snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

# Prompt theme
zplugin light denysdovhan/spaceship-prompt

zplugin compinit >> /dev/null
