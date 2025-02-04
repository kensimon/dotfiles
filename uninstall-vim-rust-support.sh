#!/usr/bin/env bash
if [[ -L ~/.vim/local.vim ]]
then
    rm -v ~/.vim/local.vim
elif [[ -e ~/.vim/local.vim ]]
then
    echo "~/.vim/local.vim exists but is not a symlink, not touching it."
fi

if [[ -L ~/.vim/bundle/coc.nvim ]]
then
    rm -v ~/.vim/bundle/coc.nvim
elif [[ -e ~/.vim/bundle/coc.nvim ]]
then
    echo "~/.vim/bundle/coc.nvim exists but is not a symlink, not touching it."
fi
