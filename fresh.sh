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
   echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/user/.zprofile
   eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file ./Brewfile

# Setup python environment
if test $(which pyenv); then
  eval "$(pyenv init -)";
  eval "$(pyenv install 3.9.14)";
  eval "$(pyenv global 3.9.14)";
fi

if test $(pyenv-virtualenv); then
   eval "$(pyenv virtualenv-init -)";
fi

# Setup node environment
if test ! $(which nvm); then
  echo "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash)"
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  eval "$(nvm install --lts)";
fi

# Setup ruby environment
if test $(which rbenv); then
  eval "$(rbenv init -)";
  eval "$(rbenv install 3.1.2)";
  eval "$(rbenv global 3.1.2)";
fi

# Make ZSH the default shell environment
chsh -s $(which zsh)

# Symlink the Mackup config file to the home directory
ln -s $DOTFILES/.mackup.cfg $HOME/.mackup.cfg

# Other symlinks
ln -s "/Applications/Sublime Merge.app/Contents/SharedSupport/bin/smerge" /usr/local/bin/smerge
ln -s ./.lldbinit ~/.lldbinit
ln -s ./.gitconfig ~/.gitconfig
ln -s ./.gitignore_global ~/.gitignore_global

# Set macOS preferences - we will run this last because this will reload the shell
source /.macos
