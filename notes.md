# INSTALLATION / SETUP NOTES / QA

Problem:
	oci_connect() not found on CLI
Solution:
	add extension=oci8.so on /etc/php/cli/php.ini


Problem:
	Oracle Listener does not start on boot?

Solution:
	vi /etc/init.d/oracle-xe
	go to line :556
	update line:
		status=`ps -ef | grep tns | grep oracle`
		to
		status=`ps -ef | grep tns | grep oracle | grep xe`