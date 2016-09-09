#!/bin/bash

# tweak nginx config
fpm_conf=/etc/php7/php-fpm.d/www.conf

sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" ${fpm_conf}
sed -i -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" ${fpm_conf}
sed -i -e "s/pm.max_children = 4/pm.max_children = 4/g" ${fpm_conf}
sed -i -e "s/pm.start_servers = 2/pm.start_servers = 3/g" ${fpm_conf}
sed -i -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 2/g" ${fpm_conf}
sed -i -e "s/pm.max_spare_servers = 3/pm.max_spare_servers = 4/g" ${fpm_conf}
sed -i -e "s/pm.max_requests = 500/pm.max_requests = 200/g" ${fpm_conf}
sed -i -e "s/user = nobody/user = nginx/g" ${fpm_conf}
sed -i -e "s/group = nobody/group = nginx/g" ${fpm_conf}
sed -i -e "s/;listen.mode = 0660/listen.mode = 0666/g" ${fpm_conf}
sed -i -e "s/;listen.owner = nobody/listen.owner = nginx/g" ${fpm_conf}
sed -i -e "s/;listen.group = nobody/listen.group = nginx/g" ${fpm_conf}
sed -i -e "s/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm.sock/g" ${fpm_conf}
sed -i -e "s/^;clear_env = no$/clear_env = no/" ${fpm_conf}

# Set custom webroot
if [ ! -z "${WEBROOT-}" ]; then
 webroot=$WEBROOT
 sed -i "s#root /var/www/html;#root ${webroot};#g" /etc/nginx/sites-available/default.conf
else
 webroot=/var/www/html
fi

# Display Version Details or not
if [[ "${HIDE_NGINX_HEADERS-}" == "0" ]] ; then
 sed -i "s/server_tokens off;/server_tokens on;/g" /etc/nginx/nginx.conf
else
 sed -i "s/expose_php = On/expose_php = Off/g" /etc/php7/conf.d/php.ini
fi

# Always chown webroot for better mounting
#chown -Rf nginx.nginx ${webroot}
chown -f nginx.nginx ${webroot}

echo -e "\033[1;38;5;203m[Nginx] Tweak Nginx configuration."
echo -en "\033[m"