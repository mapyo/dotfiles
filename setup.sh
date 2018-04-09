#!/bin/bash
# https://github.com/yuroyoro/dotfiles/blob/master/setup.sh

DOT_FILES=( .zshrc .zsh .gitconfig .gitignore_global .tmux.conf .tmux .vimrc .gvimrc .vim .ideavimrc .editorconfig)

for file in ${DOT_FILES[@]}
do
  ln -s $HOME/dotfiles/$file $HOME/$file
done
