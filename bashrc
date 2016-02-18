#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Bash strict mode - http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -veuo pipefail
IFS=$'\n\t'

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
