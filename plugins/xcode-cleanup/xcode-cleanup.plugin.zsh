# Xcode cleanup plugin for oh-my-zsh.
# Credit: https://github.com/zisoft/dotfiles/tree/main/oh-my-zsh-custom/plugins/xcode-cleanup

function xcode_cleanup {
  xcode_cleanup_derived_data
  xcode_cleanup_archives
  xcode_cleanup_cache
  xcode_cleanup_simulator_log
  xcode_cleanup_simulator
  cleanup_tmp_folder
  cleanup_spaces_caused_by_simulators

  echo "Xcode cleanup done."
  echo

  return 0
}

function xcode_cleanup_derived_data() {
  setopt localoptions RM_STAR_SILENT
  setopt localoptions NO_NOMATCH

  local DD_DIR="$HOME/Library/Developer/Xcode/DerivedData"
  local usage=$(du -m -s $DD_DIR | awk '{print $1}')

  echo "Cleanup Derived Data"

  rm -rf $DD_DIR/*

  echo "${usage} MB freed"
  echo

  return 0
}

function xcode_cleanup_archives() {
  setopt localoptions RM_STAR_SILENT
  setopt localoptions NO_NOMATCH

  local ARCHIVE_DIR="$HOME/Library/Developer/Xcode/Archives"

  local usage=$(du -m -s $ARCHIVE_DIR | awk '{print $1}')

  echo "Cleanup Archives"

  rm -rf $ARCHIVE_DIR/*

  echo "${usage} MB freed"
  echo

  return 0
}

function xcode_cleanup_cache() {
  setopt localoptions RM_STAR_SILENT
  setopt localoptions NO_NOMATCH

  local DIR="$HOME/Library/Caches/com.apple.dt.Xcode"
  local usage=$(du -m -s $DIR | awk '{print $1}')

  echo "Cleanup Cache"

  rm -rf $DIR/*

  echo "${usage} MB freed"
  echo

  return 0
}


function xcode_cleanup_simulator_log() {
  setopt localoptions RM_STAR_SILENT
  setopt localoptions NO_NOMATCH

  local SIMLOG_DIR="$HOME/Library/Logs/CoreSimulator"
  local usage=$(du -m -s $SIMLOG_DIR | awk '{print $1}')

  echo "Cleanup Simulator Logs"

  rm -rf $SIMLOG_DIR/*

  echo "${usage} MB freed"
  echo

  return 0
}


function xcode_cleanup_simulator() {
  echo "Cleanup unavailable simulators"

  $(xcrun simctl delete unavailable)

  echo

  return 0
}

function cleanup_tmp_folder() {
  echo "Cleanup private/tmp folder"
  rm -R /private/tmp
  echo
  return 0
}

function cleanup_spaces_caused_by_simulators() {
  echo "Cleanup spaces caused by re-running simulator over times"
  sudo rm -R /Library/Developer/CoreSimulator
  echo
  return 0
}