#!/bin/bash

#########################################
### Script prepare linux workstation ####
#########################################

#set -euo pipefail
#exec 2>/dev/null

install_app() {
  pkg_list="git tmux npm htop flatpak fish ripgrep gcc python3 python3-pip"

  if [[ $(cat /etc/*-release) == *"debian"* || $(cat /etc/*-release) == *"ubuntu"* ]]; then
    echo "os debian or ubuntu like"
    sudo apt update && sudo apt upgrade
    sudo apt install -y $pkg_list
  else
    echo "os not supported by script"
    exit 1
  fi

  sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  flatpak install flathub io.neovim.nvim
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  curl -sS https://starship.rs/install.sh | sh
  curl https://sh.rustup.rs -sSf | sh
  cargo install --locked zellij
}

configure() {
  mkdir $HOME/.themes
  mkdir $HOME/.fonts
  mkdir $HOME/.config
  mkdir $HOME/.config/fish
  mkdir $HOME/.config/zellij

  chsh -s $(which fish)

  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip $HOME
  unzip $HOME/JetBrainsMono.zip -d $HOME/.fonts

  cd $HOME
  git clone git@github.com:n0xas69/dotfile.git
  rm -rf ~/.config/nvim
  rm -rf ~/.local/share/nvim
  git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
  mkdir $HOME/.config/nvim/lua/custom
  git clone git@github.com:n0xas69/nvchad_config.git ~/.config/nvim/lua/custom

  cp $HOME/dotfile/.config/fish/config.fish $HOME/.config/fish/config.fish
  cp $HOME/dotfile/.config/kitty/kitty.conf $HOME/.config/kitty/kitty.conf
  cp $HOME/dotfile/.config/starship.toml $HOME/.config/starship.toml
  cp $HOME/dotfile/.config/zellij/config.kdl $HOME/.config/zellij/config.kdl

}

if [[ $1 == "config" ]]; then
  configure
fi
install_app
configure
