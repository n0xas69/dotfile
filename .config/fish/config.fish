if status is-interactive
  starship init fish | source
  alias vim="nvim"
  set -x GOPATH /usr/local/go/bin
  set -U fish_user_paths $fish_user_paths $GOPATH
    # Commands to run in interactive sessions can go here
end
