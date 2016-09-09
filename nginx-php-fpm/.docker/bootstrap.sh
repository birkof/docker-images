#!/bin/bash

set -eu
export TERM=xterm

# Supervisord default params
SUPERVISOR_PARAMS='-c /etc/supervisor/supervisord.conf'

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
  # Run supervisord detached...
  supervisord $SUPERVISOR_PARAMS

  # Some command(s) has been passed to container? Execute them and exit.
  # No commands provided? Run bash.
  if [[ $@ ]]; then
    eval $@
  else
    export PS1='[\u@\h : \w]\$ '
    /bin/bash
  fi

# Detached mode? Run supervisord in foreground, which will stay until container is stopped.
else
  # If some extra params were passed, execute them before.
  # @TODO It is a bit confusing that the passed command runs *before* supervisord,
  #       while in interactive mode they run *after* supervisor.
  #       Not sure about that, but maybe when any command is passed to container,
  #       it should be executed *always* after supervisord? And when the command ends,
  #       container exits as well.
  if [[ $@ ]]; then
    eval $@
  fi
  
  supervisord -n $SUPERVISOR_PARAMS
fi