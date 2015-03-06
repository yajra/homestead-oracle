#!/usr/bin/env bash

DB=$1

LogDirectory='/home/vagrant/oracle'
DataDirectory='/home/vagrant/oracle/data'

/u01/app/oracle/product/11.2.0/xe/bin/sqlplus -s <<EOF  > ${LogDirectory}/query.log
system/secret
set linesize 32767
set feedback off
set heading off

DROP USER ${DB} CASCADE;
GRANT ALL PRIVILEGES TO ${DB} IDENTIFIED BY secret;

COMMIT

EOF