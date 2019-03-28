# use nvim as default if available
if command -v nvim >/dev/null 2>&2; then
	alias vim='nvim'
fi

# Add bit of color
alias ls='ls --color=auto'
alias grep='grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias /='cd /'

# vim habbits
alias :q=exit
alias :wq=exit

# open html files in the browser. Eg. test results
alias -s {html,htm}=xdg-open
