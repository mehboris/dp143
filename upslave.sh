#if [ ! -f status.txt ]; then
dbmasterip= 10.0.2.17
statusfile=`awk {'print $1'} status.txt` # from master mysql -u root -e 'SHOW MASTER STATUS;'
binlog=`awk {'print $2'} status.txt`   #from master
mysqldump -u root demo <employees.sql
echo "$statusfile"
echo `mysql -u root -e 'CHANGE MASTER TO MASTER_HOST="'$dbmasterip'", MASTER_USER="slave_user", MASTER_PASSWORD="changeme", MASTER_LOG_FILE="'$statusfile'", MASTER_LOG_POS='"$binlog"';'`
mysql -u root -e 'START SLAVE;'
mysql -u root -e 'SHOW SLAVE STATUS\G'
#else
#echo "not found config master"
#fi
