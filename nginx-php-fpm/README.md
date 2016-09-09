docker-nginx-php-fpm
==============

Docker image with Nginx, PHP-FPM &amp; Xdebug support

Versions
-----
| Tag | Nginx | PHP | Alpine |
|-----|-------|-----|--------|
| latest | 1.10.1 | 7.0.10 | 3.4 |
| php5 | 1.10.1 | 5.6.24 | 3.4 |
| php7 | 1.10.1 | 7.0.10 | 3.4 |

Usage
-----
```
sudo docker run -d birkof/nginx-php-fpm
```
You can then browse to http://<DOCKER_HOST>:8080 to view the default install files. To find your DOCKER_HOST use the docker inspect to get the IP address.

Configuration Parameters
-----
The following flags are a list of all the currently supported options that can be changed by passing in the variables to docker with the -e flag.

 - **GIT_CONFIG_EMAIL** : Set your email for code pushing (required for git to work)
 - **GIT_CONFIG_NAME** : Set your name for code pushing (required for git to work)
 - **WEBROOT** : Change the default webroot directory from /var/www/html to your own setting (By default code is checked out into /var/www/html/)
 - **ERRORS** : Set to 1 to display PHP Errors in the browser
 - **HIDE_NGINX_HEADERS** : Disable by setting to 0, default behaviour is to hide nginx + php version in headers
 - **PHP_MEM_LIMIT** : Set higher PHP memory limit, default is 128 Mb
 - **PHP_POST_MAX_SIZE** : Set a larger post_max_size, default is 100 Mb
 - **PHP_UPLOAD_MAX_FILESIZE** : Set a larger upload_max_filesize, default is 100 Mb
 - **XDEBUG_ENABLE** : Enable Xdebug
 - **XDEBUG_IDEKEY** : IDE Key Xdebug
 - **APP_ENV** : Application environment


Examples
--------
```
sudo docker run -d -e 'YOUR_VAR=VALUE' birkof/nginx-php-fpm
```

Logging and Errors
--------
All logs should now print out in stdout/stderr and are available via the docker logs command:
```
docker logs <CONTAINER_NAME>