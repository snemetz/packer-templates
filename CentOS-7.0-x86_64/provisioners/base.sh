sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
yum -y install deltarpm
yum -y install bzip2 gcc wget kernel-devel-`uname -r` kernel-headers-`uname -r` perl
