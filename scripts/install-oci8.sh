if php -m | grep oci8; then
	echo 'oracle extension already installed!'
else
	echo autodetect | pecl install oci8
	echo 'extension=oci8.so' >> /etc/php5/fpm/php.ini
	echo 'extension=oci8.so' >> /etc/php5/cli/php.ini
	echo "env[ORACLE_HOME] = '/u01/app/oracle/product/11.2.0/xe'" >> /etc/php5/fpm/php-fpm.conf
	echo "env[LD_LIBRARY_PATH] = '/u01/app/oracle/product/11.2.0/xe/lib'" >> /etc/php5/fpm/php-fpm.conf
fi
