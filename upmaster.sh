mysql -u root -e 'SLAVE STOP;'
mysql -u root -e 'FLUSH TABLES WITH READ LOCK;'
mysql -u root -e 'SHOW MASTER STATUS;'|grep mysql>status.txt
mysqldump -u root demo <employees.sql 
mysqldump -u root --opt demo > dumped/demo.sql
mysql -u root -e 'UNLOCK TABLES;'
 git config --global user.email "you@example.com"
  git config --global user.name "Your Name"
git add .
git commit -am'new status `date +%Y-%m-%d.%H:%M:%S`'
git push -u origin mysqlmaster
echo "aall done"


