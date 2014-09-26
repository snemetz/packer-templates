
Packer Templates
================

This is a set of templates to create base OS images for various uses

## Table of Contents

* [Required Software](#required-software)
* [Running Packer](#running-packer)
* [Builders](#builders)
* [Post Processors](#post-processors)
* [Supported Packer Versions](#supported-packer-versions)

## Required Software
- [Packer](http://www.packer.io/downloads.html) (obviously)
- [qemu] Ubuntu: apt-get install qemu-system
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](http://www.vagrantup.com/downloads.html)
- [VMware Player](https://my.vmware.com/web/vmware/free#desktop_end_user_computing/vmware_player/6_0), Workstation, Fusion, or vSphere. 
For VMware Player you need the Player and VIX

Ubuntu VMware Player Install
```
apt-get install build-essential linux-headers-`uname -r`
apt-get install qemu
gksudo bash VMware-Player-6.0.3-1895310.x86_64.bundle
gksudo bash VMware-VIX-1.13.3-1895310.x86_64.bundle
```

## Running Packer
If you want to build only virtualbox or vmware
```
packer build --only=virtualbox-iso template.json
packer build --only=vmware-iso template.json
```

## Builders
- [virtualbox-iso](http://www.packer.io/docs/builders/virtualbox-iso.html)
- [vmware-iso](http://www.packer.io/docs/builders/vmware-iso.html)

Not supported by vagrant and not implemented yet:
docker
openstack
qemu - xen

## Post Processors
- [vagrant](http://www.packer.io/docs/post-processors/vagrant.html)

## Supported Packer Versions
Templates tested with packer 0.6.1

