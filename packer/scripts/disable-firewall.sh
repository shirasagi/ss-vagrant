os=${os:-"centos7"}

if [ "$os" == "centos6" ]; then
  /sbin/chkconfig iptables off
  /sbin/chkconfig ip6tables off
fi

if [ "$os" == "centos7" ]; then
  systemctl stop firewalld
  systemctl disable firewalld
fi
