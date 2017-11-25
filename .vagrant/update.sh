#!/bin/bash

#sed -i 's/~\/menu.sh/#~\/menu.sh/' /root/.bash_profile

#yum install -y php-opcache
#yum install -y php-apc

#yum remove -y php-pdo
#yum install -y php-pdo

echo '
██████╗ ██╗████████╗██████╗ ██╗██╗  ██╗    ██╗   ██╗███╗   ███╗
██╔══██╗██║╚══██╔══╝██╔══██╗██║╚██╗██╔╝    ██║   ██║████╗ ████║
██████╔╝██║   ██║   ██████╔╝██║ ╚███╔╝     ██║   ██║██╔████╔██║
██╔══██╗██║   ██║   ██╔══██╗██║ ██╔██╗     ╚██╗ ██╔╝██║╚██╔╝██║
██████╔╝██║   ██║   ██║  ██║██║██╔╝ ██╗     ╚████╔╝ ██║ ╚═╝ ██║
╚═════╝ ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝      ╚═══╝  ╚═╝     ╚═╝


===============================================================

'

echo -e "\e[1;32mSetting XDebug !\e[0m"
rm -f /etc/php.d/*xdebug.ini*

echo 'zend_extension = xdebug.so
xdebug.remote_enable = true
xdebug.remote_autostart = true
xdebug.idekey = "PHP_STORM"
xdebug.remote_host=192.168.33.1
xdebug.remote_handler = dbgp' >> /etc/php.d/15-xdebug.ini.disabled

mv -f /etc/php.d/15-xdebug.ini.disabled /etc/php.d/15-xdebug.ini

echo -e "\e[1;32mRestarting apache service\e[0m"
service httpd restart

mkdir -p /tmp/php_sessions/www
mkdir -p /tmp/php_upload/www

echo -e "\e[1;32mDownload bitrix fast start script\e[0m"
wget --quiet --directory-prefix=/home/bitrix/www http://www.1c-bitrix.ru/download/scripts/bitrixsetup.php
wget --quiet --directory-prefix=/home/bitrix/www http://www.1c-bitrix.ru/download/scripts/restore.php 


echo '
EnableSendfile Off
' >> /etc/httpd/bx/custom/z_bx_custom.conf 

echo '
sendfile off;
' >> /etc/nginx/bx/conf/bitrix_general.conf

echo -e "\e[1;32mAll done, enjoy!\e[0m"