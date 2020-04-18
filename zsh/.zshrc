### Install zinit if not present already
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### Add go to path
if command -v go >/dev/null 2>&2; then
  export PATH=$PATH:$(go env GOPATH)/bin
fi

### Source individual zsh files
declare -a zshFiles=("plugins" "aliases" "functions" "configurations" "work")
for fileName in "${zshFiles[@]}"
do
	if [ -f ~/.zsh/$fileName.zsh ]; then
	    source ~/.zsh/$fileName.zsh
	fi
done

### Source the FZF zsh file
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

QT_QPA_PLATFORMTHEME=qt5ct

# use the starship.rs as the prompt
if ! command -v starship >/dev/null 2>&2; then
  curl -fsSL https://starship.rs/install.sh | zsh
fi
eval "$(starship init zsh)"
if [[ -d /home/harish/.gem/ruby/2.7.0/bin ]]; then
  export PATH="$PATH:/home/harish/.gem/ruby/2.7.0/bin"
fi
