sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

yum -y install wget gcc kernel-devel-`uname -r` kernel-headers-`uname -r` perl
