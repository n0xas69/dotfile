#!/bin/bash

set -euo pipefail

#########################################
### Script prepare linux workstation ####
#########################################


install_app() {
  pkg_list="git tmux neovim npm firefox htop"

  if [[ $(cat /etc/*-release) == "*debian*" || $(cat /etc/*-release) == "*ubuntu*" ]]; then
    echo "os debian or ubuntu like"
  elif [[ $(cat /etc/*-release) == "*arch*" ]]; then
    echo "os archlinux"
  else
    echo "os not supported by script"
  fi
}
