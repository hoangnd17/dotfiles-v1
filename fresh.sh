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
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>/$HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install zplug
if test ! $(which zplug); then
  /bin/zsh -c "$(curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $(pwd)/.zshrc $HOME/.zshrc

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file ./Brewfile

# Create a projects directories
mkdir $HOME/Code

# Setup python environment
if test $(which pyenv); then
  eval "$(pyenv init -)"
  eval "$(pyenv install 3.9.14)"
  eval "$(pyenv global 3.9.14)"
fi

if test $(which pyenv-virtualenv); then
  eval "$(pyenv virtualenv-init -)"
fi

# Setup node environment
if test ! $(which nvm); then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm install --lts
fi

# Setup ruby environment
if test $(which rbenv); then
  eval "$(rbenv init -)"
  eval "$(rbenv install 3.1.2)"
  eval "$(rbenv global 3.1.2)"
fi

# Make ZSH the default shell environment
chsh -s $(which zsh)

# Symlink the Mackup config file to the home directory
ln -s $(pwd)/.mackup.cfg $HOME/.mackup.cfg

# Other symlinks
sudo ln -s "/Applications/Sublime Merge.app/Contents/SharedSupport/bin/smerge" /usr/local/bin/smerge
ln -s $(pwd)/.lldbinit ~/.lldbinit
ln -s $(pwd)/.gitconfig ~/.gitconfig
ln -s $(pwd)/.gitignore_global ~/.gitignore_global

# Clone
./clone.sh

# Set macOS preferences - we will run this last because this will reload the shell
source ./.macos
