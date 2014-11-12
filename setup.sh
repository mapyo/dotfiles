#!/bin/bash
# https://github.com/yuroyoro/dotfiles/blob/master/setup.sh

DOT_FILES=( .zshrc .gitconfig .tmux.conf .tmux .vimrc .vim)

for file in ${DOT_FILES[@]}
do
  ln -s $HOME/dotfiles/$file $HOME/$file
done
