#!/bin/sh

# RRRRRGHHHHH it's called "visudo" for a fucking reason
update-alternatives --set /usr/bin/vim

# pkgs
apt-get install cscope zsh tmux mosh
