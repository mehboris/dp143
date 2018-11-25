gitserv=10.0.2.12
sudo rpm -Uvh https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm
 yum update -y
 yum install -y nano epel-release && yum repolist
 systemctl disable firewalld

echo export PATH=/opt/puppetlabs/bin:'$PATH' >> ~/.bashrc
yum install -y puppet
cd /etc/puppetlabs/code/environments/
rm -rf production.back
mv production production.back
mkdir production
cd production
ssh-keygen -b 4096 -t rsa -f ~/.ssh/git_serv_rsa -q -N ""
ssh-copy-id -i ~/.ssh/git_serv_rsa.pub git@$gitserv
echo Host $gitserv > ~/.ssh/config
echo IdentityFile ~/.ssh/git_serv_rsa >>  ~/.ssh/config
echo IdentitiesOnly yes  >>  ~/.ssh/config
git config --global user.name "git"
git config --global user.name mehboris@gmail.com
git init
git remote add origin git@$gitserv:/home/git/repos/puppetstart.git
git pull origin master

/opt/puppetlabs/bin/puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp


