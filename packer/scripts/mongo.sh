arch=${arch:-"x86_64"}

if [ "$arch" == "i386" ]; then
  arch="i686"
fi

# install mongodb
cat << _EOT_ | tee /etc/yum.repos.d/mongodb.repo
[mongodb]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/$arch/
gpgcheck=0
enabled=1
_EOT_

yum -y install mongodb-org
# sed -i 's/# nojournal=true/nojournal=true/' /etc/mongod.conf
sed -i 's/bind_ip=/# bind_ip=/' /etc/mongod.conf

/sbin/service mongod restart
