#!/bin/bash

#########################################
### Script prepare linux workstation ####
#########################################

set -euo pipefail
#exec 2>/dev/null

install_app() {
  pkg_list="git tmux npm firefox htop flatpak"

  if [[ $(cat /etc/*-release) == *"debian"* || $(cat /etc/*-release) == *"ubuntu"* ]]; then
    echo "os debian or ubuntu like"
    apt update && apt upgrade
    apt install -y "$pkg_list"
  elif [[ $(cat /etc/*-release) == *"arch"* ]]; then
    echo "os archlinux"
    pacman -Syu --noconfirm
    pacman -S flatpak --noconfirm
  else
    echo "os not supported by script"
  fi

  flatpak install flathub io.neovim.nvim
}

install_app
