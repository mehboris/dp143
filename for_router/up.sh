dir_puppetstart='/home/git/repos/puppetstart.git'
sudo rpm -Uvh https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm
 yum update
 yum install nano
 yum install epel-release
 yum repolist
 systemctl disable firewalld

echo export PATH=/opt/puppetlabs/bin:'$PATH' >> ~/.bashrc 
yum install puppet
cd /etc/puppetlabs/code/environments/ 
rm -rf production.back
mv production production.back
mkdir production
cd -
echo $dir_puppetstart
cp  -R * /etc/puppetlabs/code/environments/production/
cd /etc/puppetlabs/code/environments/production/
cp manifests/git.pp  /etc/puppetlabs/code/environments/production/manifests/site.pp
/opt/puppetlabs/bin/puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp && cd /root/pagent/ && /usr/bin/git remote remove origin && /usr/bin/git remote add origin $dir_puppetstart && git push -u origin master  
