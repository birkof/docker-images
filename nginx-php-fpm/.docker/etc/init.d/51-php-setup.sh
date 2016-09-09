#!/bin/bash

# tweak php-fpm config
php_conf=/etc/php7/php.ini 

sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" ${php_conf}
sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" ${php_conf}
sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" ${php_conf}
sed -i -e "s/variables_order = \"GPCS\"/variables_order = \"EGPCS\"/g" ${php_conf}
ln -s ${php_conf} /etc/php7/conf.d/php.ini
find /etc/php7/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;

# Display PHP error's or not
if [[ "${PHP_DISPLAY_ERRORS-}" != "1" ]] ; then
    echo php_flag[display_errors] = off >> /etc/php7/php-fpm.conf
else
    echo php_flag[display_errors] = on >> /etc/php7/php-fpm.conf
fi

# Increase the memory_limit
if [ ! -z "${PHP_MEM_LIMIT-}" ]; then
    sed -i "s/memory_limit = 128M/memory_limit = ${PHP_MEM_LIMIT}M/g" /etc/php7/conf.d/php.ini
fi

# Increase the post_max_size
if [ ! -z "${PHP_POST_MAX_SIZE-}" ]; then
    sed -i "s/post_max_size = 100M/post_max_size = ${PHP_POST_MAX_SIZE}M/g" /etc/php7/conf.d/php.ini
fi

# Increase the upload_max_filesize
if [ ! -z "${PHP_UPLOAD_MAX_FILESIZE-}" ]; then
    sed -i "s/upload_max_filesize = 100M/upload_max_filesize= ${PHP_UPLOAD_MAX_FILESIZE}M/g" /etc/php7/conf.d/php.ini
fi

echo -e "\033[1;38;5;203m[Php] Tweak PHP configuration."
echo -en "\033[m"