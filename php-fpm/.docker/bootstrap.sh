#!/bin/bash

set -eu
export TERM=xterm

# Umask should be set to 002 or group write will be disabled
# Quite a few installs run into an issue where UMASK 022 should be 002 so its closer to 0775
# https://hub.docker.com/r/nubs/composer-build/~/dockerfile/
umask 002

function initTitle(){
    local data=${1:-''}
    if [ ! -z "$2" ]; then
        data="$data\033[1;38;5;97m $2 "
    fi
    echo -e "\n\033[1;33m[[ \033[1;38;5;30m$data\033[1;33m]]\033[m"
}

function preInit(){
    for i in ls $1/*-setup.sh
    do
        if [ -e "${i}" ]; then
            initTitle "Processing" "$i"
            . "${i}"
        fi
    done
}

# Init setup files
preInit "/etc/init.d"

# We have TTY, so probably an interactive container...
if test -t 0; then
  # Some command(s) has been passed to container? Execute them and exit.
  # No commands provided? Run bash.
  if [[ $@ ]]; then
    eval $@
  else
    export PS1='[\u@\h : \w]\$ '
    /bin/bash
  fi

# Detached mode? Run commands in foreground.
else
  # If some extra params were passed, execute them before.
  if [[ $@ ]]; then
    eval $@
  fi
fi