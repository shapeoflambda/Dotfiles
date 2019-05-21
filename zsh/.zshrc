source ~/.zplugin/bin/zplugin.zsh

export PATH=$PATH:$(go env GOPATH)/bin

declare -a zshFiles=("plugins" "aliases" "functions" "configurations" "work")

for fileName in "${zshFiles[@]}"
do
	if [ -f ~/.zsh/$fileName.zsh ]; then
	    source ~/.zsh/$fileName.zsh
	fi
done

eval $(thefuck --alias jesus)
