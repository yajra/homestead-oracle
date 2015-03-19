# INSTALLATION / SETUP NOTES / QA

###Problem:
	oci_connect() not found on CLI
###Solution:
	add extension=oci8.so on /etc/php/cli/php.ini


###Problem:
	Oracle Listener does not start on boot?

###Solution:
	vi /etc/init.d/oracle-xe
	go to line :556
	update line:
		status=`ps -ef | grep tns | grep oracle`
		to
		status=`ps -ef | grep tns | grep oracle | grep xe`

###Problem:
	Supervisord not working due to Oracle Environments

###Solution:
	Manually add oracle environment path on your program
```
[program:queue]
command=php artisan queue:listen --tries=2 --env=homestead
directory=/home/vagrant/www
stdout_logfile=/home/vagrant/www/app/storage/logs/supervisord.log
redirect_stderr=true
autostart=true
autorestart=true
user=vagrant
environment=ORACLE_HOME="/u01/app/oracle/product/11.2.0/xe",LD_LIBRARY_PATH="/u01/app/oracle/product/11.2.0/xe/lib",USER="vagrant"
```