#!/usr/bin/bash
#
# Options - https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html
# 
# -----------------------------------------------------------------------------

TS=`TZ=":Australia/Melbourne" date "+%Y%m%d-%H%M%S"`

echo "Dumping DB to ${TS}"

USER=root
PASSWD=MediaWiki-2023

mysqldump -u ${USER} -p${PASSWD} --extended-insert local_mw > ${TS}.sql

