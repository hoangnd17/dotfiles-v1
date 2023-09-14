#!/bin/sh

echo "Cloning repositories..."

# Themes
echo "Themes for Iterm. Ref: https://github.com/dracula/zsh/blob/master/INSTALL.md"
DRACULA_THEME=$HOME/Code/dracula
git clone https://github.com/dracula/zsh.git $DRACULA_THEME
ln -s $DRACULA_THEME/dracula.zsh-theme $ZSH/themes/dracula.zsh-theme
cp -R $DRACULA_THEME/lib $ZSH/themes

# Colors
git clone https://github.com/dracula/iterm.git $HOME/Code/iterm-colors