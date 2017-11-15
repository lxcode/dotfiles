#!/bin/sh

cd ~
ln -s git/dotfiles/.zshrc
ln -s git/dotfiles/.zshenv
ln -s git/dotfiles/.vim
ln -s git/dotfiles/.vimrc
ln -s git/dotfiles/.ctags
ln -s git/dotfiles/.editrc
ln -s git/dotfiles/.nexrc
ln -s git/dotfiles/.inputrc
ln -s git/dotfiles/.tmux.conf

mkdir ~/.w3m && ln -s ~/git/dotfiles/w3m-config ~/.w3m/config
mkdir -p ~/.config/kitty && ln -s ~/git/dotfiles/kitty.conf ~/.config/kitty/kitty.conf

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

read -p "Want to do X crap?"
cd ~
ln -s git/dotfiles/.xsession
ln -s .xsession .xinitrc
ln -s .Xresources
