#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/work/builds ~/projects ~/ ~/work ~/personal ~/personal/yt -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
zellij_running=$(pgrep zellij)

if [[ -z $zellij_running ]]; then
    cd $selected && zellij --session $selected_name
    exit 0
fi

# if ! tmux has-session -t=$selected_name 2> /dev/null; then
#    tmux new-session -ds $selected_name -c $selected
#fi

#tmux switch-client -t $selected_name
