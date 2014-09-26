#!/bin/bash

case "$PACKER_BUILDER_TYPE" in
  virtualbox-iso|virtualbox-ovf)
    # Install Virtualbox guest additions
    yum -y install bzip2
    VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
    cd /tmp
    mount -o loop /home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
    sh /mnt/VBoxLinuxAdditions.run
    umount /mnt
    rm -rf /home/vagrant/VBoxGuestAdditions_*.iso
    ;;
  vmware-iso|vmware-vmx)
    # Install VMware Tools
    yum -y install fuse fuse-libs
    mount -o loop /home/vagrant/linux.iso /mnt
    cd /tmp
    tar xzf /mnt/VMwareTools-*.tar.gz
    umount /mnt
    /tmp/vmware-tools-distrib/vmware-install.pl --default
    rm -rf /tmp/vmware-tools-distrib
    rm -rf /home/vagrant/linux.iso
    ;;
  qemu-kvm)
    # Should anything get installed ?? qemu guest agent ?
    echo 'No tools setup for KVM'
  ;;
  qemu-xen)
    # Install Xen tools
    echo 'No tools setup for Xen yet'
  ;;
  *)
    echo "Unsupported Packer Builder Type >>$PACKER_BUILDER_TYPE<< selected."
    echo "Supported Builders: virtualbox-iso|virtualbox-ovf|vmware-iso|vmware-ovf."
    ;;
esac

