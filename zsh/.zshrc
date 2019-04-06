source ~/.zplugin/bin/zplugin.zsh

export PATH=$PATH:$(go env GOPATH)/bin

declare -a zshFiles=("plugins" "aliases" "configurations")

for fileName in "${zshFiles[@]}"
do
	if [ -f ~/.zsh/$fileName.zsh ]; then
	    source ~/.zsh/$fileName.zsh
	else
	    print "404: ~/.zsh/$fileName.zsh not found."
	fi
done

eval $(thefuck --alias jesus)
