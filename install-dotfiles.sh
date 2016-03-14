#!/bin/bash

symlinks=(.colors .i3 .ncmpcpp .oh-my-zsh .vim_runtime .weechat .bashrc .dircolors .functions .mongorc.js tmux-cheatsheet .tmux.conf vim-cheatsheet .vimrc .xinitrc .Xresources .zsh_aliases .zshrc .zshrc.zni .zsh-update)

for file in ${symlinks[@]}; do
    ln -s $HOME/dotfiles/$file $HOME/$file
done
