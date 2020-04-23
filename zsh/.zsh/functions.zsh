# Create and changes working directory in one command
mkcd () {
  mkdir -p "$@" && cd "$1";
}
