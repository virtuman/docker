#!/usr/bin/env bash

AUTOMYSQLBACKUP_CONFIG_FILE=/etc/automysqlbackup/automysqlbackup.conf

sed -i -r "s/^#CONFIG_backup_dir=.*/CONFIG_backup_dir='\/backup'/g" $AUTOMYSQLBACKUP_CONFIG_FILE

echo " * host:      ${BACKUP_HOST}"
sed -i -r "s/^#CONFIG_mysql_dump_host=.*/CONFIG_mysql_dump_host='${BACKUP_HOST}'/g" $AUTOMYSQLBACKUP_CONFIG_FILE

echo " * databases: ${BACKUP_DATABASES//,/ }"
if [[ ${BACKUP_DATABASES} = "all" ]]; then
    sed -i -r "s/^#CONFIG_db_names=.*/CONFIG_db_names=()/g" $AUTOMYSQLBACKUP_CONFIG_FILE
else
    sed -i -r "s/^#CONFIG_db_names=.*/CONFIG_db_names='${BACKUP_DATABASES//,/ }'/g" $AUTOMYSQLBACKUP_CONFIG_FILE
fi

echo " * username:  ${BACKUP_USERNAME}"
sed -i -r "s/^#CONFIG_mysql_dump_username=.*/CONFIG_mysql_dump_username='${BACKUP_USERNAME}'/g" $AUTOMYSQLBACKUP_CONFIG_FILE
sed -i -r "s/^#CONFIG_mysql_dump_password=.*/CONFIG_mysql_dump_password='${BACKUP_PASSWORD}'/g" $AUTOMYSQLBACKUP_CONFIG_FILE


echo " * email:     ${BACKUP_EMAIL}"
sed -i -r "s/MAILADDR=.*/MAILADDR=${BACKUP_EMAIL}/g" $AUTOMYSQLBACKUP_CONFIG_FILE

echo " * compress:  ${BACKUP_COMPRESS}"
sed -i -r "s/^#CONFIG_mysql_dump_compression=.*/CONFIG_mysql_dump_compression='${BACKUP_COMPRESS}'/g" $AUTOMYSQLBACKUP_CONFIG_FILE

echo " * encrypt:   ${BACKUP_ENCRYPT}"
if [[ ${BACKUP_ENCRYPT} = "yes" ]]; then
    sed -i -r "s/^#CONFIG_encrypt=.*/CONFIG_encrypt='yes'/g" $AUTOMYSQLBACKUP_CONFIG_FILE
    sed -i -r "s/^#CONFIG_encrypt_password=.*/CONFIG_encrypt_password='${BACKUP_ENCRYPT_PASSWORD}'/g" $AUTOMYSQLBACKUP_CONFIG_FILE
fi

echo " * commcomp:  ${MYSQL_COMPRESS_COMMUNICATION}"
sed -i -r "s/^#CONFIG_mysql_dump_commcomp=.*/CONFIG_mysql_dump_commcomp='${MYSQL_COMPRESS_COMMUNICATION}'/g" $AUTOMYSQLBACKUP_CONFIG_FILE
