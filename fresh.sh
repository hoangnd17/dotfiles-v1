#!/bin/sh

echo "Setting up your Mac..."

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
   echo "installing brew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file $DOTFILES/Brewfile

# Setup python environment
if test $(which pyenv); then
  eval "$(pyenv init -)";
fi

if test $(pyenv-virtualenv-init); then
   eval "$(pyenv virtualenv-init -)"; 
   eval "$(pyenv install 3.9)";
fi

# Setup node environment
if test $(which nvm); then
  eval "$(nvm install --lts)";
fi

# Setup ruby environment
if test $(which rbenv); then
  eval "$(rbenv init -)";
fi

# Make ZSH the default shell environment
chsh -s $(which zsh)

# Symlink the Mackup config file to the home directory
ln -s $DOTFILES/.mackup.cfg $HOME/.mackup.cfg

# Other symlinks
ln -s "/Applications/Sublime Merge.app/Contents/SharedSupport/bin/smerge" usr/local/bin/smerge
ln -s $HOME/$DOTFILES/.lldbinit ~/.lldbinit

# Set macOS preferences - we will run this last because this will reload the shell
source $DOTFILES/.macos
