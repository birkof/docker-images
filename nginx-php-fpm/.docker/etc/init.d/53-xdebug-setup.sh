#!/bin/bash

if [[ -z "${XDEBUG_ENABLE-}" || -z "${XDEBUG_IDEKEY-}" ]]; then
  echo -e "\033[1;38;5;203m[Xdebug] One or more variables are undefined. Skipping..."
else
    xdebug_ini="/etc/php7/conf.d/xdebug.ini";
    
    echo "xdebug.remote_enable=$XDEBUG_ENABLE" >> ${xdebug_ini} \
    && echo "xdebug.remote_autostart=off" >> ${xdebug_ini} \
    && echo "xdebug.remote_connect_back=on" >> ${xdebug_ini} \
    && echo "xdebug.remote_port=9000" >> ${xdebug_ini} \
    && echo "xdebug.max_nesting_level=1000" >> ${xdebug_ini} \
    && echo "xdebug.idekey=$XDEBUG_IDEKEY" >> ${xdebug_ini}
    
    echo -e  "\033[1;38;5;203m[Xdebug] Set Xdebug with remote_enable $XDEBUG_ENABLE and idekey: $XDEBUG_IDEKEY."
fi

echo -en "\033[m"