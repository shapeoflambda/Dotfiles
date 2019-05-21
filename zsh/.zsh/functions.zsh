# Create and changes working directory in one command
md () {
  mkdir -p "$@" && cd "$1";
}
