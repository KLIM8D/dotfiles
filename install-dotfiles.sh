#!/bin/bash

source_dir="$HOME/dotfiles"
target_dir="$HOME"

symlinks=(.colors .i3 .ncmpcpp .oh-my-zsh .vim_runtime .weechat .bashrc .dircolors .functions .mongorc.js tmux-cheatsheet .tmux.conf vim-cheatsheet .vimrc .xinitrc .Xresources .zsh_aliases .zshrc .zshrc.zni .zsh-update)

plugins=()

append() {
    plugins+=($1)
}

get_files() {
    set -e

    git config -f .gitmodules --get-regexp '^submodule\..*\.path$' > tempfile
    while read -ru 3 path_key path
    do
        url_key=$(echo "$path_key" | sed 's/\.path/.url/')
        url=$(git config -f .gitmodules --get "$url_key")
        if [ ! -d "$path" ]; 
        then
            git clone "$url" "$path"
        else
            append "$path"
        fi
    done 3<tempfile

    root=$(pwd)
    for p in "${plugins[@]}"
    do
        cd "$p" && git pull origin master && cd "$root"
        [[ "$p" =~ YouCompleteMe$ ]] && cd "$p" && git submodule update --init --recursive &&
            ./install.py --all
    done

    rm tempfile
}

get_files

for file in "${symlinks[@]}"; do
   [[ -z $source_dir/$file ]] && ln -s "$source_dir/$file" "$target_dir/$file"
done
