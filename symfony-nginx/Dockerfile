FROM nginx:alpine

# Ensure www-data has access to file from volume if file are mapped as uid/gid 1000/1000
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

# Injecting assets
ADD .docker /

# Working dir
WORKDIR /var/www/html