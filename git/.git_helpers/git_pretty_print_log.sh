#!/usr/bin/env bash

set -e

HASH="%C(always,cyan)%h%C(always,reset)"           # Abbreviated hash
DATE="%C(always,green)%as%C(always,reset)"         # Short format of date
REF="%C(always,red)%D%C(always,reset)"             # Ref
AUTHOR_NAME="%C(always,yellow)%an%C(always,reset)" # Author name
MESSAGE="%s"                                       # Commit subject

FORMAT="$HASH{$DATE{$AUTHOR_NAME{$REF$MESSAGE"

git_pretty_print_log() {
  git log --graph --pretty=tformat:$FORMAT $* |
    column -t -s '{' |
    less -FXRS
}
