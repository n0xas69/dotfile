#!/bin/bash

#########################################
### Script prepare linux workstation ####
#########################################

set -euo pipefail
#exec 2>/dev/null

install_app() {
  pkg_list="git tmux npm firefox htop flatpak fish ripgrep gcc"

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
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  curl -sS https://starship.rs/install.sh | sh
}

configure() {
  mkdir $HOME/.themes
  mkdir $HOME/.fonts
  mkdir $HOME/.config
  mkdir $HOME/.config/fish

  chsh -s $(which fish)

  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip $HOME
  unzip $HOME/JetBrainsMono.zip -d $HOME/.fonts 

  git clone git@github.com:n0xas69/dotfile.git $HOME
  git clone git@github.com:n0xas69/nvchad_config.git $HOME
  git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
  mkdir $HOME/.config/nvim/lua/custom
  git clone git@github.com:n0xas69/nvchad_config.git ~/.config/nvim/lua/custom

  cp $HOME/dotfile/.tmux.conf $HOME/.tmux.conf
  cp $HOME/dotfile/.config/fish/config.fish $HOME/.config/fish/config.fish
  cp $HOME/dotfile/.config/kitty/kitty.conf $HOME/.config/kitty/kitty.conf
  cp $HOME/dotfile/.config/starship.toml $HOME/.config/starship.toml

}
