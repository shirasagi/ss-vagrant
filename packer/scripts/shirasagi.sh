yum -y install git wget ImageMagick ImageMagick-devel

cd $HOME && cat << _EOT_ | sudo -u $SUDO_USER bash
cd \$HOME
source /etc/profile.d/rvm.sh
git clone https://github.com/shirasagi/shirasagi
cd shirasagi
cp -p config/samples/* config/

echo "== bundle install"
for i in \$(seq 1 5)
do
  bundle install
  if [ $? -eq 0 ]; then
    break
  fi
done

bundle exec rake db:create_indexes
bundle exec rake ss:create_user data='{ name: "システム管理者", email: "sys@example.jp", password: "pass" }'
bundle exec rake ss:create_site data='{ name: "サイト名", host: "www", domains: "localhost:3000" }'
bundle exec rake db:seed name=users site=www
bundle exec rake db:seed name=demo site=www
bundle exec rake cms:generate_nodes site=www
_EOT_
