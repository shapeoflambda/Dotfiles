#!/usr/bin/env bash

info() {
  printf "\033[00;34m$@\033[0m\n"
}

# ###########################################################
# Install packages
# ###########################################################
installPackages() {
  info "Installing required packages..."
  if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sudo pacman -S git neovim vim thefuck zsh ripgrep stow
  elif [ "$(uname)" == "Darwin" ]; then
    info "Installing brew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    info "Installing essential packages"
    brew install git neovim vim zsh ripgrep stow nnn fzf tldr
  fi

  info "Installing Extras.."

  # zplugin
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

}

installFonts() {
  info "Installing Fonts.."

  if [ "$(uname)" == "Darwin" ]; then
    fonts=~/Library/Fonts
  elif [ "$(uname)" == "Linux" ]; then
    info "Fonts will be sylimked using stow and copy is NOT required"
    return 1
  fi

  find "$DOTFILES/fonts/" -name "*.[o,t]tf" -type f | while read -r file; do
    cp -v "$file" "$fonts"
  done
}

doAll() {
  installPackages
  setWallpaper
  installFonts
}

doHelp() {
  echo "Usage: $(basename "$0") [options]" >&2
  echo
  echo "   -s, --sync             Synchronizes dotfiles to home directory"
  echo "   -l, --link             Create symbolic links"
  echo "   -i, --install          Install the required packages"
  echo "   -f, --fonts            Copies font files"
  echo "   -c, --config           Configures your system"
  echo "   -w, --wallpaper        Sets the wallpaper in the wallpaper directory"
  echo "   -a, --all              Does all of the above"
  echo
  exit 1
}

# ###########################################################
# Wallpaper
# ###########################################################
setWallpaper() {
  info "Setting wallpaper..."
  if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    if [ "$GDMSESSION" == "gnome" ]; then
      gsettings set org.gnome.desktop.background picture-uri file:///home/$USER/.wallpaper_01.jpg
    fi
  fi
}

if [ $# -eq 0 ]; then
  doHelp
else
  for i in "$@"; do
    case $i in
      -s | --sync)
        doSync
        doGitConfig
        shift
        ;;
      -l | --link)
        doSymLink
        shift
        ;;
      -i | --install)
        installPackages
        shift
        ;;
      -f | --fonts)
        doFonts
        shift
        ;;
      -c | --config)
        doConfig
        shift
        ;;
      -w | --wallpaper)
        setWallpaper
        shift
        ;;
      -a | --all)
        doAll
        shift
        ;;
      *)
        doHelp
        shift
        ;;
    esac
  done
fi
