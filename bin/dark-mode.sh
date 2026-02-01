#!/bin/bash

set -euo pipefail

function is_mint() {
    grep -q Mint /etc/issue
}


if is_mint
then
    COLOR_SCHEME_SCHEMA=org.x.apps.portal
    WM_SCHEMA=org.cinnamon
else
    COLOR_SCHEME_SCHEMA=org.gnome.desktop.interface
    WM_SCHEMA=org.gnome
    LIGHT_THEME=
fi

function usage() {
    echo "Usage: $0 <enable|disable>" 1>&2
    exit 1
}

function enable() {
    echo "set bg=dark" >"${HOME}/.dotfiles/vim/dark_mode.vim"
    echo "dark_mode = true" >"${HOME}/.config/wezterm/dark_mode.lua"
    echo -n "on" >"${HOME}/.config/dark-mode-applet/state"
    gsettings set "${COLOR_SCHEME_SCHEMA}" color-scheme 'prefer-dark'
    if is_mint
    then
        gsettings set "${WM_SCHEMA}".desktop.interface gtk-theme 'Mint-Y-Dark-Aqua'
        gsettings set "${WM_SCHEMA}".theme name 'Mint-Y-Dark-Aqua'
    fi
    gsettings set "${WM_SCHEMA}".desktop.background picture-uri "file://${HOME}/Pictures/Wallpapers/dark-mode-wallpaper.jpg"
    gsettings set "${WM_SCHEMA}".desktop.background picture-options 'centered'
    gsettings set "${WM_SCHEMA}".desktop.background primary-color '#000000'
    gsettings set "${WM_SCHEMA}".desktop.background secondary-color '#000000'
}

function disable() {
    echo "set bg=light" >"${HOME}/.vim/dark_mode.vim"
    echo "dark_mode = false" >"${HOME}/.config/wezterm/dark_mode.lua"
    echo -n "off" >"${HOME}/.config/dark-mode-applet/state"
    gsettings set "${COLOR_SCHEME_SCHEMA}" color-scheme 'prefer-light'
    if is_mint
    then
        gsettings set "${WM_SCHEMA}".desktop.interface gtk-theme 'Mint-Y-Aqua'
        gsettings set "${WM_SCHEMA}".theme name 'Mint-Y-Aqua'
    fi
    gsettings set "${WM_SCHEMA}".desktop.background picture-uri "file://${HOME}/Pictures/Wallpapers/light-mode-wallpaper.jpg"
    gsettings set "${WM_SCHEMA}".desktop.background picture-options 'zoom'
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
