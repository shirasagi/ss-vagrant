os=${os:-"centos7"}

if [ "$os" == "centos7" ]; then
  sysctl -w fs.inotify.max_user_watches=524289
  cat << _EOT_ | tee /etc/sysctl.d/98-max_user_watches.conf
fs.inotify.max_user_watches = 524289
_EOT_
