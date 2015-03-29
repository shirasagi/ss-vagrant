echo 'NETWORKING_IPV6=no' >> /etc/sysconfig/network
echo "options ipv6 disable=1" > /etc/modprobe.d/disable-ipv6.conf
chkconfig ip6tables off
sed -ie 's/::1/# ::1/' /etc/hosts
