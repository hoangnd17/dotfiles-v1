# Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias reloadshell="source $HOME/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias ll="/opt/homebrew/opt/coreutils/libexec/gnubin/ls -AhlFo --color --group-directories-first"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias c="clear"
alias compile="commit 'compile'"
alias version="commit 'version'"

# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias sites="cd $HOME/Sites"

# JS
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
alias watch="npm run watch"

# Git
alias gs="git status"
alias gb="git branch"
alias gc="git checkout"
alias gl="git log --oneline --decorate --color"
alias gog="git log  --abbrev-commit --name-status --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias amend="git add . && git commit --amend --no-edit"
alias commit="git add . && git commit -m"
alias diff="git diff"
alias force="git push --force"
alias nuke="git clean -df && git reset --hard"
alias pop="git stash pop"
alias clone="git clone --recursive"
alias pull="git pull"
alias push="git push"
alias resolve="git add . && git commit --no-edit"
alias stash="git stash -u"
alias gsl="git stash list"
alias gss="git stash save"
alias apply="git stash apply"
alias unstage="git restore --staged ."
alias wip="commit wip"
alias gpush='git push origin $(git_current_branch)'
alias gpull='git pull origin $(git_current_branch)'

git_current_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

#Pods
# Remove the Pods directory and Podfile.lock, then reinstall all pods
alias podnuke='rm -rf Pods Podfile.lock && pod install'

#mackup: https://github.com/lra/mackup
alias backup="mackup backup"
alias restore="mackup restore"

#xcode
alias deeplink="xcrun simctl openurl booted"
alias xc="xed ."
alias xflush="xcrun simctl shutdown all && xcrun simctl erase all"
alias xclean="xcode_cleanup"

#simulator
  # Change a particular user default value
  # Usage: simdefaults [APP_BUNDLE_ID] [DEFAULTS_KEY] [VALUE]
  alias simdefaults='xcrun simctl spawn booted defaults write [APP_BUNDLE_ID] [DEFAULTS_KEY] [VALUE]'

  # Set location
  # Usage: simlocation [LATITUDE] [LONGITUDE]
  # Usage: simlocation 37.7749 -122.4194
  alias simlocation='xcrun simctl location booted set [LATITUDE] [LONGITUDE]'

  # Adjust privacy settings
  # Usage: simprivacy [SERVICE] [ACCESS_LEVEL]
  alias simprivacy='xcrun simctl privacy booted grant [SERVICE] [ACCESS_LEVEL]'

  # Handle push notifications
  # Usage: simpush [PAYLOAD_PATH]
  alias simpush='xcrun simctl push booted [APP_BUNDLE_ID] [PAYLOAD_PATH]'

  # Reset all user defaults for a particular app ID
  # Usage: simresetdefaults [APP_BUNDLE_ID]
  alias simresetdefaults='xcrun simctl spawn booted defaults delete [APP_BUNDLE_ID]'

#ssh
alias myssh="generate_ssh_key"