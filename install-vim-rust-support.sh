#!/usr/bin/env bash

set -euo pipefail
cd "$(dirname "${0}")"

if [[ -e ./vim/local.vim ]]; then
    echo "./vim/local.vim already exists, not touching. Overwrite with:"
    echo
    echo "    cp ./vim/coc-settings.vim ./vim/local.vim"
    echo
else
    cp -v ./vim/coc-settings.vim ./vim/local.vim
fi

echo "Set up rust-analyzer from within a repo (must be installed per rust version:)"
echo
echo "    rustup component add rust-analyzer"
echo
echo "And then from vim:"
echo
echo "    :CocInstall coc-rust-analyzer"
