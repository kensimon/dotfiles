#!/bin/bash

set -euo pipefail

function usage() {
    echo "Usage: $0 <enable|disable>" 1>&2
    exit 1
}

function enable() {
    echo "set bg=dark" >"${HOME}/.dotfiles/vim/dark_mode.vim"
    echo "dark_mode = true" >"${HOME}/.config/wezterm/dark_mode.lua"
    echo -n "on" >"${HOME}/.config/dark-mode-applet/state"
    gsettings set org.x.apps.portal color-scheme 'prefer-dark'
    gsettings set org.cinnamon.desktop.interface gtk-theme 'Mint-Y-Dark-Aqua'
    gsettings set org.cinnamon.theme name 'Mint-Y-Dark-Aqua'
    gsettings set org.cinnamon.desktop.background picture-uri 'file:///home/ksimon/Pictures/40lS66E.jpeg'
    gsettings set org.cinnamon.desktop.background picture-options 'centered'
    gsettings set org.cinnamon.desktop.background primary-color '#000000'
    gsettings set org.cinnamon.desktop.background secondary-color '#000000'
}

function disable() {
    echo "set bg=light" >"${HOME}/.vim/dark_mode.vim"
    echo "dark_mode = false" >"${HOME}/.config/wezterm/dark_mode.lua"
    echo -n "off" >"${HOME}/.config/dark-mode-applet/state"
    gsettings set org.x.apps.portal color-scheme 'prefer-light'
    gsettings set org.cinnamon.desktop.interface gtk-theme 'Mint-Y-Aqua'
    gsettings set org.cinnamon.theme name 'Mint-Y-Aqua'
    gsettings set org.cinnamon.desktop.background picture-uri 'file:///usr/share/backgrounds/linuxmint-tessa/kemsley_kluane.jpg'
    gsettings set org.cinnamon.desktop.background picture-options 'zoom'
}

if [[ "${1:-}" == "enable" ]]
then
    enable
elif [[ "${1:-}" == "disable" ]]
then
    disable
else
    usage
fi
