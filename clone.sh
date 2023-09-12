#!/bin/sh

echo "Cloning repositories..."

# Themes
# Dracula theme for Iterm. Ref: https://draculatheme.com/zsh
THEMES=$HOME/.dotfiles/themes
echo THEMES
git clone https://github.com/dracula/zsh.git THEMES
ln -s THEMES/dracula.zsh-theme $OH_MY_ZSH/themes/dracula.zsh-theme
