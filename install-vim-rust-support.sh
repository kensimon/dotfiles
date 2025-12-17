#!/usr/bin/env bash

set -euo pipefail
cd "${HOME}"

if [[ -e .vim/local.vim ]]; then
    echo "./vim/local.vim already exists, not touching. Overwrite with:"
    echo
    echo "    cd ~/.vim && ln -s coc-settings.vim local.vim"
    echo
else
    (cd ~/.vim && ln -sv coc-settings.vim local.vim)
fi

if [[ -e .vim/bundle/coc.nvim ]]; then
    echo "./vim/bundle/coc.nvim already exists, not touching. Overwrite with:"
    echo
    echo "    cd ~/.vim/bundle && ln -s ../bundles-available/coc.nvim ."
    echo
else
    (cd ~/.vim/bundle && ln -sv ../bundles-available/coc.nvim .)
fi

echo "Set up rust-analyzer from within a repo (must be installed per rust version:)"
echo
echo "    rustup component add rust-analyzer"
echo
echo "And then from vim..."
echo
echo "    :CocInstall coc-rust-analyzer"
