#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

tmux new-session -d -s grafana

function gitwindow() {
    NAME=$1
    PROJ=$2

    tmux new-window -c $PROJ -n $NAME
    tmux split-window -c $PROJ -t $NAME -h
    tmux split-window -c $PROJ -t $NAME
    tmux send-keys -t 2 'watchgitstatus'
    tmux send-keys -t 2 Enter
    tmux send-keys -t 1 'cd . && clear'
    tmux send-keys -t 1 Enter
    tmux send-keys -t 0 'cd . && clear'
    tmux send-keys -t 0 Enter
}

gitwindow deployment_tools $HOME/git/grafana/deployment_tools
gitwindow deployment_tools_2 $HOME/git/grafana/deployment_tools_2
gitwindow tanka $HOME/git/grafana/tanka
gitwindow jsonnet-libs $HOME/git/grafana/jsonnet-libs

tmux new-window -d -c $HOME/git/notes -n notes
tmux new-window -d -c $HOME/git/aur -n aur
tmux new-window -d -c $HOME/git/dotfiles -n dotfiles

tmux kill-window -t 1
tmux select-window -t deployment_tools
tmux attach -t grafana
