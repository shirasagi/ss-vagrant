VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
cd /tmp
mount -o loop /home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run --nox11
umount /mnt
rm -rf /home/vagrant/VBoxGuestAdditions_*.iso
rm -rf /home/vagrant/.vbox_version

# VirtualBox 5.1.22 has been released and blow issue was fixed.
#
# # fix VirtualBox 5.1.20 Guest Addition Issue
# # see: http://qiita.com/poad1010/items/675ffe46e70135fff839
# rm -f /sbin/mount.vboxsf
# ln -s /usr/lib/VBoxGuestAdditions/mount.vboxsf /sbin/mount.vboxsf
