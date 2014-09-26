#!/bin/bash

case "$PACKER_BUILDER_TYPE" in
  openstack|amazon|google)
    # Move to own script with if , always run
    # Install cloudinit
    # setup EPEL, put elsewhere ? Dependent on OS version
    rpm -Uvh  http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
    #rpm -Uvh  http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-1.noarch.rpm
    yum -y install cloud-init cloud-utils dracut-modules-growroot
    #dracut -f
    # config cloudinit
    # edit grub ?
    ;;
  *)
    echo "Cloudinit is not configured for Packer Builder Type >>$PACKER_BUILDER_TYPE<<"
    ;;
esac
