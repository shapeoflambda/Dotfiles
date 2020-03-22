#!/bin/zsh
export LSCOLORS='exfxcxdxbxegedabagacad'
export CLICOLOR=true

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# don't nice background tasks
setopt NO_BG_NICE
setopt NO_HUP
setopt NO_BEEP

# allow functions to have local options
setopt LOCAL_OPTIONS

# allow functions to have local traps
setopt LOCAL_TRAPS

# share history between sessions ???
setopt SHARE_HISTORY

# Auto cd into directory
setopt  autocd autopushd

# add timestamps to history
setopt EXTENDED_HISTORY
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD

# adds history
setopt APPEND_HISTORY

# adds history incrementally and share it across sessions
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# don't record dupes in history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt HIST_EXPIRE_DUPS_FIRST

# delete char with backspaces and delete
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char

# delete word with ctrl+backspace
bindkey '^[[3;5~' backward-delete-word
# bindkey '^[[3~' backward-delete-word

# vi mode
bindkey -v
export KEYTIMEOUT=1

# to to the beggining/end of line with fn+left/right or home/end
bindkey "${terminfo[khome]}" vi-beginning-of-line
bindkey '^[[H' vi-beginning-of-line
bindkey '^A' vi-beginning-of-line
bindkey "${terminfo[kend]}" vi-end-of-line
bindkey '^[[F' vi-end-of-line
bindkey '^E' vi-end-of-line

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in nevion/vim/vi with ct-x ctrl-e:
if [[ $(command -v nvim) ]]; then
  export EDITOR=nvim
elif [[ $(command -v vim) ]]; then
  export EDITOR=vim
fi
autoload edit-command-line; zle -N edit-command-line
bindkey '^x^e' edit-command-line

# # search history with fzf if installed, default otherwise
# For Arch
if test -d /usr/share/fzf/; then
	. /usr/share/fzf/key-bindings.zsh
# For MacOS
elif test -d /usr/local/opt/fzf/shell; then
	# shellcheck disable=SC1091
	. /usr/local/opt/fzf/shell/key-bindings.zsh
else
	bindkey '^R' history-incremental-search-backward
fi

# # FZF Options
export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git" 2>/dev/null || fd --hidden --no-ignore --type f 2>/dev/null'
export FZF_DEFAULT_OPTS='--extended --preview=" [[ $(file --mime {}) =~ binary ]] &&
	echo {} is a binary file ||
	(bat --color always {} || head -500 {}) 2> /dev/null | head -$LINES"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS='--no-preview'

# # Bat Theme
BAT_THEME="DarkNeon"

# autoload -U compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Disable spaceship go symbol that causes crash
SPACESHIP_VI_MODE_SHOW=false
SPACESHIP_CHAR_SYMBOL='λ '

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey '^[[A' up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey '^[[B' down-line-or-beginning-search
fi
