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
CREATE USER ${DB} IDENTIFIED BY secret;

GRANT create session TO ${DB};
GRANT create table TO ${DB};
GRANT create view TO ${DB};
GRANT create any trigger TO ${DB};
GRANT create any procedure TO ${DB};
GRANT create sequence TO ${DB};
GRANT create synonym TO ${DB};

COMMIT

EOF