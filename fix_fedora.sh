#!/bin/sh

# RRRRRGHHHHH it's called "visudo" for a fucking reason
sudo dnf -y remove nano-default-editor

# pkgs
sudo dnf install zsh tmux mosh fzf ripgrep mutt mtr curl w3m \
    rust git fd-find khal khard vdirsyncer isync notmuch \
    glibc-static bat helix vis vim

cargo install duf dust bottom pv
pip3 install --user visidata tldextract emoji urlexpander fugashi deepl geopy snownlp lingua-language-detector

mkdir ~/git
cd ~/git && git clone https://github.com/lxcode/dotfiles
cd ~/
for file in .zshrc .zshenv .zsh .zlogin .vimrc .vim .ctags .editrc .inputrc .nexrc .tmux.confbin .mailcap
do
    ln -s ~/git/dotfiles/$file ~/$file
done

mkdir ~/.w3m
ln -s ~/git/dotfiles/w3m-config ~/.w3m/config
