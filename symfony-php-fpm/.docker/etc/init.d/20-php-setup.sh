#!/bin/bash

# tweak php ini file
PHP_INI_FILE="/usr/local/etc/php/conf.d/php.ini"
PHP_FPM_FILE="/usr/local/etc/php-fpm.conf"

# Timezone set
if [ ! -z "${TZ-}" ]; then
    echo "date.timezone = \"${TZ}\"" > ${PHP_INI_DIR}/conf.d/date_timezone.ini
fi

# Which PHP errors are reported.
echo "error_reporting = E_ALL" > ${PHP_INI_DIR}/conf.d/error_reporting.ini

# Display PHP error's or not
if [[ "${PHP_DISPLAY_ERRORS-}" != "1" ]] ; then
    echo "display_errors = Off" > ${PHP_INI_DIR}/conf.d/display_errors.ini
    echo "display_startup_errors = Off" > ${PHP_INI_DIR}/conf.d/display_startup_errors.ini
    echo "track_errors = Off" > ${PHP_INI_DIR}/conf.d/track_errors.ini
    echo "xmlrpc_errors = 0" > ${PHP_INI_DIR}/conf.d/xmlrpc_errors.ini

    sed -i -e "s/;log_level\s*=\s*debug/;log_level = notice/g" ${PHP_FPM_FILE}
else
    echo "display_errors = On" > ${PHP_INI_DIR}/conf.d/display_errors.ini
    echo "display_startup_errors = On" > ${PHP_INI_DIR}/conf.d/display_startup_errors.ini
    echo "track_errors = On" > ${PHP_INI_DIR}/conf.d/track_errors.ini
    echo "xmlrpc_errors = 1" > ${PHP_INI_DIR}/conf.d/xmlrpc_errors.ini

    sed -i -e "s/;log_level\s*=\s*notice/log_level = warning/g" ${PHP_FPM_FILE}
fi

# Increase the memory_limit
if [ ! -z "${PHP_MEM_LIMIT-}" ]; then
    echo "memory_limit = ${PHP_MEM_LIMIT}" > ${PHP_INI_DIR}/conf.d/memory_limit.ini
fi

# Increase the post_max_size
if [ ! -z "${PHP_POST_MAX_SIZE-}" ]; then
    echo "post_max_size = ${PHP_POST_MAX_SIZE}" > ${PHP_INI_DIR}/conf.d/post_max_size.ini
fi

# Increase the upload_max_filesize
if [ ! -z "${PHP_UPLOAD_MAX_FILESIZE-}" ]; then
    echo "upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}" > ${PHP_INI_DIR}/conf.d/upload_max_filesize.ini
fi

# Provides real PATH_INFO/ PATH_TRANSLATED support for CGI.
echo "cgi.fix_pathinfo = 0" > ${PHP_INI_DIR}/conf.d/cgi.fix_pathinfo.ini

# A bit of performance tuning.
echo "realpath_cache_size = 128k" > ${PHP_INI_DIR}/conf.d/realpath_cache_size.ini

# OpCache tuning
echo "opcache.max_accelerated_files = 32000" > ${PHP_INI_DIR}/conf.d/opcache.max_accelerated_files.ini
echo "opcache.memory_consumption = 128" > ${PHP_INI_DIR}/conf.d/opcache.memory_consumption.ini
echo "opcache.fast_shutdown = 0" > ${PHP_INI_DIR}/conf.d/opcache.fast_shutdown.ini

echo -e "\033[1;38;5;203m[Php] Tweak PHP configuration."
echo -en "\033[m"