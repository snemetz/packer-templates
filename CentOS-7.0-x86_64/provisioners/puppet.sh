
# Open Source
rpm -ivh http://yum.puppetlabs.com/el/7/products/x86_64/puppetlabs-release-7-11.noarch.rpm
yum -y install puppet
#rm -f /etc/yum.repos.d/puppetlabs*.repo
rpm -e puppetlabs-release

# Enterprise
#rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
#rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm

