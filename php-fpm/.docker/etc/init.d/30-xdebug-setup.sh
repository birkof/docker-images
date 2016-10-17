#!/bin/bash

if [[ -z "${XDEBUG_ENABLE-}" || -z "${XDEBUG_IDEKEY-}" ]]; then
  echo -e "\033[1;38;5;203m[Xdebug] One or more variables are undefined. Skipping..."
else
    XDEBUG_INI_FILE="/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini";
    
    echo "xdebug.remote_enable=$XDEBUG_ENABLE" >> ${XDEBUG_INI_FILE} \
    && echo "xdebug.remote_autostart=off" >> ${XDEBUG_INI_FILE} \
    && echo "xdebug.remote_handler=dbgp" >> ${XDEBUG_INI_FILE} \
    && echo "xdebug.max_nesting_level=1000" >> ${XDEBUG_INI_FILE} \
    && echo "xdebug.idekey=$XDEBUG_IDEKEY" >> ${XDEBUG_INI_FILE} \
    && echo "xdebug.remote_log=/tmp/xdebug.log" >> ${XDEBUG_INI_FILE} \
    && echo "xdebug.remote_port=${XDEBUG_REMOTE_PORT:=9000}" >> ${XDEBUG_INI_FILE}

    if [ ! -z "${XDEBUG_REMOTE_HOST-}" ]; then
        echo "xdebug.remote_host=$XDEBUG_REMOTE_HOST" >> ${XDEBUG_INI_FILE}
    else
        echo "xdebug.remote_connect_back=on" >> ${XDEBUG_INI_FILE}
    fi
    
    echo -e  "\033[1;38;5;203m[Xdebug] Set Xdebug with remote_enable $XDEBUG_ENABLE and idekey: $XDEBUG_IDEKEY."
fi

echo -en "\033[m"