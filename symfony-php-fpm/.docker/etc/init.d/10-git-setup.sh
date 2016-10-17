#!/bin/bash

if [[ -z "${GIT_CONFIG_EMAIL-}" || -z "${GIT_CONFIG_NAME-}" ]]; then
  echo -e "\033[1;38;5;203m[Git] One or more variables are undefined. Skipping..."
else
    git config --global core.editor "vim"

    if [ ! -z "${GIT_CONFIG_EMAIL-}" ]; then
     git config --global user.email "$GIT_CONFIG_EMAIL"
    fi

    if [ ! -z "${GIT_CONFIG_NAME-}" ]; then
     git config --global user.name "$GIT_CONFIG_NAME"
     git config --global push.default simple
    fi

    echo -e "\033[1;38;5;203m[Git] Set gitconfig with global user name $GIT_CONFIG_NAME and email $GIT_CONFIG_EMAIL."    
fi

echo -en "\033[m"