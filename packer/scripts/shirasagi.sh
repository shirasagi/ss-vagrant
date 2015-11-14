yum -y install git wget ImageMagick ImageMagick-devel

cd $HOME && cat << _EOT_ | sudo -u $SUDO_USER bash
cd \$HOME
source /etc/profile.d/rvm.sh
git clone https://github.com/shirasagi/shirasagi
cd shirasagi
# git checkout -b v0.9.5 origin/v0.9.5
cp -np config/samples/*.{yml,rb} config/

echo "== bundle install"
for i in \$(seq 1 5)
do
  bundle install
  if [ $? -eq 0 ]; then
    break
  fi
done

sed -i "s/dbcae379.*$/\$(rake secret)/" config/secrets.yml

bundle exec rake db:create_indexes
bundle exec rake ss:create_user data='{ name: "システム管理者", email: "sys@example.jp", password: "pass" }'
bundle exec rake ss:create_site data='{ name: "サイト名", host: "www", domains: "localhost:3000" }'
bundle exec rake db:seed name=users site=www
bundle exec rake db:seed name=demo site=www
bundle exec rake cms:generate_nodes site=www
bundle exec rake cms:generate_pages site=www

bin/deploy
_EOT_
