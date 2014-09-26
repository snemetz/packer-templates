#!/bin/bash -eux

# case
# if [ -f /etc/debian_version ] ; then
# if [ -f /etc/gentoo-release ] ; then
# if [ -f /etc/redhat-release ] ; then

# These were only needed for building VMware/Virtualbox extensions:
yum -y remove gcc cpp kernel-devel kernel-headers perl
yum -y clean all
rm -rf VBoxGuestAdditions_*.iso VBoxGuestAdditions_*.iso.?
rm -rf /tmp/rubygems-*

# clean up redhat interface persistence
rm -f /etc/udev/rules.d/70-persistent-net.rules
if [ -r /etc/sysconfig/network-scripts/ifcfg-eth0 ]; then
  # Remove hardware specific settings from eth0
  #sed -i -e 's/^\(HWADDR\|UUID\|IPV6INIT\|NM_CONTROLLED\|MTU\).*//;/^$/d' \
  # /etc/sysconfig/network-scripts/ifcfg-eth0
  sed -i 's/^HWADDR.*$//' /etc/sysconfig/network-scripts/ifcfg-eth0
  sed -i 's/^UUID.*$//' /etc/sysconfig/network-scripts/ifcfg-eth0
fi


### OS Independent stuff

# Remove log files from the VM
#find /var/log -type f -exec rm -f {} \;

