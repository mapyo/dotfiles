#!/bin/bash
# https://github.com/yuroyoro/dotfiles/blob/master/setup.sh

DOT_FILES=( .zshrc .zshrc.local .zsh .gitconfig .tmux.conf .tmux .vimrc .vim .ideavimrc)

for file in ${DOT_FILES[@]}
do
  ln -s $HOME/dotfiles/$file $HOME/$file
done
