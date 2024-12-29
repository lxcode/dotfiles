#!/bin/sh

# RRRRRGHHHHH it's called "visudo" for a fucking reason
update-alternatives --set /usr/bin/vim

# pkgs
apt-get install zsh tmux mosh fzf ripgrep mutt mtr runit curl w3m \
    rust websocat zstd git build-essential

cargo install fd-find duf dust bottom pv
