statusfile='' # from master mysql -u root -e 'SHOW MASTER STATUS;'
binlog=   #from master
nano manifests/site.pp 
mysqldump -u root demo <employees.sql       
mysql -u root -e 'CHANGE MASTER TO MASTER_HOST=""$statusfile"", MASTER_USER="slave_user", MASTER_PASSWORD="changeme", MASTER_LOG_FILE="mysql-bin.000003", MASTER_LOG_P$
mysql -u root -e 'START SLAVE;'
mysql -u root -e 'SHOW SLAVE STATUS\G'        

