#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`
cyan=`tput setaf 6`
reset=`tput sgr0`

OK="${green}✔${reset}"
ERROR="${red}✖${reset}"

function log {
  echo "${cyan}> ${1}${reset}"
}
function column {
  str+="$1$(printf " %0.s" {1..20})"
  echo "${str:0:20}"
}
function command_exists {
  type "$1" &> /dev/null
}

FORCE_INSTALL=false

while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    -f|--force)
    FORCE_INSTALL=true
    shift # past flag
    ;;
    *)    # unknown option
    shift # past flag
    ;;
esac
done

create_link () {
  name="$1"
  src="$2"
  dst="$3"
  info=""
  status=""

  if [ "$FORCE_INSTALL" = true ]; then
    rm -rf "$dst"
    ln -s "$src" "$dst"
    status=$OK
    info="(Overwrote existing file)"
  elif [ -L "$dst" ]; then
    if [ "$(realpath $dst)" == "$src" ]; then
      status=$OK
      info="(Symlink already installed)"
    else
      status=$ERROR
      info="(Destination already exists, use --force to override)"
    fi
  elif [ -f "$dst" ] || [ -d "$dst" ]; then
    status=$ERROR
    info="(Destination already exists, use --force to override)"
  else
    status=$OK
    ln -s "$src" "$dst"
  fi
  echo "${status} $(column $name) ${info}"
}

echo
log "Symlinking ${PWD}/dotfiles/* to ${HOME}"
echo
for file in dotfiles/*; do
  file="${file##*/}"
  create_link "${file}" "${PWD}/dotfiles/${file}" "${HOME}/.${file}"
done

echo
log "Symlinking ${PWD}/config/* to ${HOME}/.config"
echo
for config in config/*; do
  dir=${config##*/}
  create_link "${dir}" "${PWD}/config/${dir}" "${HOME}/.config/${dir}"
done

echo
log "Symlinking ${PWD}/vscode/* to ${HOME}/Library/Application Support/Code/User"
echo
for file in vscode/*; do
  file="${file##*/}"
  create_link "${file}" "${PWD}/vscode/${file}" "${HOME}/Library/Application Support/Code/User/${file}"
done

if [ ! -f ~/.bash_private ]; then
  echo "# This file is not committed, use it to configure private settings." > ~/.bash_private
  echo
  log "Creating new ~/.bash_private file for private settings"
  echo "${OK} $(column "~/.bash_private")"
fi
