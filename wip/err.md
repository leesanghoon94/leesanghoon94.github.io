vagrant@control:~$ cat /etc/fstab
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# / was on /dev/ubuntu-vg/ubuntu-lv during curtin installation
/dev/disk/by-id/dm-uuid-LVM-7d7Lop99mSCkio9Q46DBa4VKaJcdSwYev3CmfLJkGfiDiA2xifj0QGe7latlrv6G / ext4 defaults 0 1
# /boot was on /dev/sda2 during curtin installation
/dev/disk/by-uuid/6278efc6-e81e-439e-a98f-69153c31a48e /boot ext4 defaults 0 1
/swap.img	none	swap	sw	0	0
#VAGRANT-BEGIN
# The contents below are automatically generated by Vagrant. Do not modify.
vagrant /vagrant vboxsf uid=1000,gid=1000,_netdev 0 0
#VAGRANT-END
vagrant@control:~$ cat /etc/fstab
# /etc/fstab: static file system information.
##
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# / was on /dev/ubuntu-vg/ubuntu-lv during curtin installation
/dev/disk/by-id/dm-uuid-LVM-7d7Lop99mSCkio9Q46DBa4VKaJcdSwYev3CmfLJkGfiDiA2xifj0QGe7latlrv6G / ext4 defaults 0 1
# /boot was on /dev/sda2 during curtin installation
/dev/disk/by-uuid/6278efc6-e81e-439e-a98f-69153c31a48e /boot ext4 defaults 0 1
#/swap.img	none	swap	sw	0	0
#VAGRANT-BEGIN
# The contents below are automatically generated by Vagrant. Do not modify.
vagrant /vagrant vboxsf uid=1000,gid=1000,_netdev 0 0
#VAGRANT-END

2222
2200