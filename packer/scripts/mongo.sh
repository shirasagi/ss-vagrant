arch=${arch:-"x86_64"}

if [ "$arch" == "i386" ]; then
cat << _EOT_ | tee /etc/yum.repos.d/mongodb-org-2.6.repo
[mongodb-org-2.6]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/i686/
gpgcheck=0
enabled=1
_EOT_
else
cat << _EOT_ | tee /etc/yum.repos.d/mongodb-org-3.4.repo
[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/3.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc
_EOT_
fi

yum -y install mongodb-org
sed -i 's/bind_ip=/# bind_ip=/' /etc/mongod.conf

/sbin/service mongod restart
