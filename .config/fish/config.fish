if status is-interactive
  starship init fish | source
  alias vim="nvim"
  set -x GOPATH /usr/local/go/bin
  set -x local_bin ~/.local/bin
  set -U fish_user_paths $fish_user_paths $GOPATH $local_bin
end
