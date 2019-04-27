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

# to to the beggining/end of line with fn+left/right or home/end
bindkey "${terminfo[khome]}" beginning-of-line
bindkey '^[[H' beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey '^[[F' end-of-line

# delete char with backspaces and delete
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char

# delete word with ctrl+backspace
bindkey '^[[3;5~' backward-delete-word
# bindkey '^[[3~' backward-delete-word

# Search up/down using the text entered so far
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Open vi to edit the command on pressing <C-x><C-e>
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

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
SPACESHIP_GOLANG_SYMBOL=""
