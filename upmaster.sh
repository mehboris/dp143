mysql -u root -e 'FLUSH TABLES WITH READ LOCK;'
mysql -u root -e 'SHOW MASTER STATUS;'|grep mysql>status.txt
mysqldump -u root demo <employees.sql 
mysql -u root -e 'UNLOCK TABLES;'
 git config --global user.email "you@example.com"
  git config --global user.name "Your Name"
git add .
git commit -am'new status `date +%Y-%m-%d.%H:%M:%S`'
git push -u origin master
echo "aall done"


