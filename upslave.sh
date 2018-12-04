if [ ! -f status.txt ]; then
statusfile=`awk {print $1} status.txt` # from master mysql -u root -e 'SHOW MASTER STATUS;'
binlog=`awk {print $1} status.txt`   #from master
mysqldump -u root demo <employees.sql
mysql -u root -e 'CHANGE MASTER TO MASTER_HOST=""$statusfile"", MASTER_USER="slave_user", MASTER_PASSWORD="changeme", MASTER_LOG_FILE="mysql-bin.000003", MASTER_LOG_P$
mysql -u root -e 'START SLAVE;'
mysql -u root -e 'SHOW SLAVE STATUS\G'
else
echo "not found config master"
fi


