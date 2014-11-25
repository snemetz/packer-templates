#!/bin/bash

# Hyper-V & Azure setup. Not a builder. Pass user var
case "$CLOUD_TYPE" in
  azure)
	echo "AZURE setup ..."
	# Setup repo and install agent
	mkdir -m 0700 /var/lib/waagent
	mv /lib/udev/rules.d/75-persistent-net-generator.rules /var/lib/waagent/
	mv /etc/udev/rules.d/70-persistent-net.rules /var/lib/waagent/

	cat <<REPOS > /etc/yum.repos.d/openlogic.repo
[openlogic]
name=CentOS-\$releasever - openlogic packages for \$basearch
baseurl=http://olcentgbl.trafficmanager.net/openlogic/\$releasever/openlogic/\$basearch/
enabled=1
gpgcheck=0
REPOS
	echo 'http_caching=packages' >> /etc/yum.conf
	if [ -f /etc/yum/pluginconf.d/fastestmirror.conf ]; then
	  sed -i '/^enabled=/ s/1/0/' /etc/yum/pluginconf.d/fastestmirror.conf
	fi
	yum clean all
	# Test that there is only one kernel line
	sed -i '/kernel / s/$/ earlyprintk=ttyS0 rootdelay=300 numa=off/' /boot/grub/menu.lst

	# Edit Sudoers - Puppet should take care of this
	sed -i '/^Defaults targetpw/ d' /etc/sudoers
	
	# install Azure Linux Agent - In repo: http://olcentgbl.trafficmanager.net/openlogic/6/openlogic/x86_64/RPMS/
	yum -y install python-pyasn1 WALinuxAgent
	# Config Azure Linux Agent
	# DO NOT put swap on OS disk. Put on local resource disk, which is a temp disk
#	/etc/waagent.conf - see what else is in file - replace or edit
#	# Defaults
#	ResourceDisk.Format=y
#	ResourceDisk.Filesystem=ext4
#	ResourceDisk.MountPoint=/mnt/resource
#	# NOT Defaults
	sed -i '/^ResourceDisk.EnableSwap=/ s/=.*/=y/' /etc/waagent.conf
	sed -i '/^ResourceDisk.SwapSizeMB=/ s/=.*/=4096/' /etc/waagent.conf
	
	# Setup memory hot add - Needed??
	#echo 'SUBSYSTEM=="memory", ACTION=="add", ATTR{state}="online"' > /etc/udev/rules.d/100-balloon.rules

	# Move to cleanup
	# deprovision and prep for Azure
	#waagent -force -deprovision
	#export HISTSIZE=0
  ;;
esac

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

