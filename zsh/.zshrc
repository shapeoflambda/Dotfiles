source <(antibody init)

antibody bundle < ~/.zsh_plugins.txt

eval $(thefuck --alias 'jesus')


export PATH=$PATH:$(go env GOPATH)/bin

declare -a zshFiles=("aliases" "completion" "configurations")

for fileName in "${zshFiles[@]}"
do
	if [ -f ~/.zsh/$fileName.zsh ]; then
	    source ~/.zsh/$fileName.zsh
	else
	    print "404: ~/.zsh/$fileName.zsh not found."
	fi
done
