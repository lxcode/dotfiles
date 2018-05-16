#!/bin/sh

# RRRRRGHHHHH it's called "visudo" for a fucking reason
update-alternatives --set /usr/bin/vim

# pkgs
apt-get install zsh tmux mosh fzf ripgrep mutt htop mtr runit curl w3m \
    xcape autocutsel cmus
