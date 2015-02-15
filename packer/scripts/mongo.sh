# install mongodb
cat << _EOT_ > /etc/yum.repos.d/mongodb.repo
[mongodb]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/
gpgcheck=0
enabled=1
_EOT_

yum -y install mongodb-org
sed -i 's/# nojournal=true/nojournal=true/' /etc/mongod.conf

service mongod restart
