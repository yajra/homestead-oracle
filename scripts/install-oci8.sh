if php -m | grep oci8; then
	echo 'oracle extension already installed!'
else
	echo autodetect | pecl install oci8-2.0.10
	echo 'extension=oci8.so' >> /etc/php5/fpm/php.ini
	echo 'extension=oci8.so' >> /etc/php5/cli/php.ini
fi

if cat /etc/php5/fpm/php-fpm.conf | grep ORACLE_HOME; then
	echo 'php-fpm oracle env path already set!'
else
	echo "env[ORACLE_HOME] = '/u01/app/oracle/product/11.2.0/xe'" >> /etc/php5/fpm/php-fpm.conf
	echo "env[LD_LIBRARY_PATH] = '/u01/app/oracle/product/11.2.0/xe/lib'" >> /etc/php5/fpm/php-fpm.conf
fi

if cat /home/vagrant/.bashrc | grep ORACLE_HOME; then
	echo 'oracle env path already set!'
else
	# fix Oracle ENV for root user - Needed for supervisord
	echo -e '\n#SET ORACLE ENV PATH' >> /home/vagrant/.bashrc
	echo 'ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe' >> /home/vagrant/.bashrc
	echo 'LD_LIBRARY_PATH=/u01/app/oracle/product/11.2.0/xe/lib' >> /home/vagrant/.bashrc
fi
