#!/bin/bash -eux

# case
# if [ -f /etc/debian_version ] ; then
# if [ -f /etc/gentoo-release ] ; then
# if [ -f /etc/redhat-release ] ; then

case "$PACKER_BUILDER_TYPE" in
  virtualbox-iso|virtualbox-ovf)
    yum -y remove gcc cpp kernel-devel kernel-headers perl
    rm -rf VBoxGuestAdditions_*.iso VBoxGuestAdditions_*.iso.?
    rm -rf /tmp/rubygems-*
  ;;
esac

# clean up redhat interface persistence
rm -f /etc/udev/rules.d/70-persistent-net.rules
if [ -r /etc/sysconfig/network-scripts/ifcfg-eth0 ]; then
  # Remove hardware specific settings from eth0
  #sed -i -e 's/^\(HWADDR\|UUID\|IPV6INIT\|NM_CONTROLLED\|MTU\).*//;/^$/d' \
  # /etc/sysconfig/network-scripts/ifcfg-eth0
  sed -i 's/^HWADDR.*$//' /etc/sysconfig/network-scripts/ifcfg-eth0
  sed -i 's/^UUID.*$//' /etc/sysconfig/network-scripts/ifcfg-eth0
fi

# Remove log files from the VM
#find /var/log -type f -exec rm -f {} \;

yum -y clean all
case "$CLOUD_TYPE" in
	azure)
		waagent -force -deprovision
	;;
esac
export HISTSIZE=0

