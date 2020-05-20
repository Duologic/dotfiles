#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

PROJ=$HOME/git/grafana/deployment_tools

tmux new-session -d -s deployment_tools -c $PROJ  -n deployment_tools
tmux split-window -c $PROJ/ksonnet -t deployment_tools -h
tmux split-window -c $PROJ -t deployment_tools
tmux send-keys 'watchgitstatus'
tmux send-keys Enter
tmux select-pane -t 1
tmux send-keys 'cd . && clear'
tmux send-keys Enter
tmux select-pane -t 0
tmux send-keys 'cd . && clear'
tmux send-keys Enter

tmux new-window -d -c $HOME/git/notes -n notes
tmux new-window -d -c $HOME/git/aur -n aur
tmux new-window -d -c $HOME/git/dotfiles -n dotfiles

tmux attach -t deployment_tools

