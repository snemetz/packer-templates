# Open Source
rpm -ivh http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-11.noarch.rpm
yum -y install puppet
rm -f /etc/yum.repos.d/puppetlabs.repo
rpm -e puppetlabs-release

# Enterprise
#rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm

