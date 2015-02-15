#!/bin/bash -eux

## https://access.redhat.com/site/solutions/58625 (subscription required)
# http://www.linuxquestions.org/questions/showthread.php?p=4399340#post4399340
# add 'single-request-reopen' so it is included when /etc/resolv.conf is generated
echo 'RES_OPTIONS="single-request-reopen"' >> /etc/sysconfig/network
service network restart
echo '==> Slow DNS fix applied (single-request-reopen)'
