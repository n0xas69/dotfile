#!/bin/bash

#########################################
### Script prepare linux workstation ####
#########################################

#set -euo pipefail
#exec 2>/dev/null

install_app() {
  pkg_list="curl git tmux npm htop fish ripgrep gcc wget unzip python3 python3-pip python3-venv fzf"

  if [[ $(cat /etc/*-release) == *"debian"* || $(cat /etc/*-release) == *"ubuntu"* ]]; then
    echo "os debian or ubuntu like"
    sudo apt update && sudo apt upgrade
    sudo apt install -y $pkg_list
  else
    echo "os not supported by script"
    exit 1
  fi


  # install neovim
  wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -P $HOME
  chmod u+x $HOME/nvim.appimage
  sudo mv $HOME/nvim.appimage /usr/local/bin/nvim

  # install kitty
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  sudo ln -s $HOME/.local/kitty.app/bin/kitty /usr/local/bin/kitty

  # install starship
  curl -sS https://starship.rs/install.sh | sh

  # install rust toolchain
  curl https://sh.rustup.rs -sSf | bash -s -- -y --no-modify-path

  # install zellij
  # wget https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz -P $HOME
  # tar -xvf $HOME/zellij-x86_64-unknown-linux-musl.tar.gz -C $HOME
  # chmod +x $HOME/zellij
  # sudo mv $HOME/zellij /usr/local/bin/
  # rm $HOME/zellij-x86_64-unknown-linux-musl.tar.gz

  # install lazygit
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
  rm lazygit.tar.gz

}

configure() {
  mkdir $HOME/.themes
  mkdir $HOME/.fonts
  mkdir $HOME/.config
  mkdir $HOME/.config/fish
  mkdir $HOME/.local/bin
  #mkdir $HOME/.config/zellij
  chsh -s $(which fish)

  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip -P $HOME
  unzip $HOME/JetBrainsMono.zip -d $HOME/.fonts
  rm $HOME/JetBrainsMono.zip

  cd $HOME
  git clone git@github.com:n0xas69/dotfile.git
  rm -rf ~/.config/nvim
  rm -rf ~/.local/share/nvim
  mkdir $HOME/.config/nvim
  git clone https://github.com/n0xas69/nvim_config.git ~/.config/nvim/

  cp $HOME/dotfile/.config/fish/config.fish $HOME/.config/fish/config.fish
  cp $HOME/dotfile/.config/kitty/kitty.conf $HOME/.config/kitty/kitty.conf
  cp $HOME/dotfile/.config/starship.toml $HOME/.config/starship.toml
  cp $HOME/dotfile/.tmux.conf $HOME/.tmux.conf
  cp $HOME/dotfile/scripts/tmux_fzf.sh $HOME/.local/bin/tmux_fzf.sh
  chmod +x $HOME/.local/bin/tmux_fzf.sh
  #cp $HOME/dotfile/.config/zellij/config.kdl $HOME/.config/zellij/config.kdl

}

if [[ $1 == "config" ]]; then
  configure
fi
install_app
configure
