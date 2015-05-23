os=${os:-"centos7"}

if [ "$os" == "centos6" ]; then
  echo 'NETWORKING_IPV6=no' >> /etc/sysconfig/network
  echo "options ipv6 disable=1" > /etc/modprobe.d/disable-ipv6.conf
  /sbin/chkconfig ip6tables off
  sed -ie 's/::1/# ::1/' /etc/hosts
fi

if [ "$os" == "centos7" ]; then
  sysctl -w net.ipv6.conf.all.disable_ipv6=1
  sysctl -w net.ipv6.conf.default.disable_ipv6=1
  cat << _EOT_ | tee /etc/sysctl.d/99-disableipv6.conf
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
_EOT_
  sed -ie 's/::1/# ::1/' /etc/hosts
fi
