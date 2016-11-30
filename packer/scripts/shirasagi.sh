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

# change secret
sed -i "s/dbcae379.*$/\$(rake secret)/" config/secrets.yml

# enable gws
sed -e "s/disable: true$/disable: false/" config/defaults/gws.yml > config/gws.yml

# install seeds
bundle exec rake db:create_indexes
bundle exec rake ss:create_user data='{ name: "システム管理者", email: "sys@example.jp", password: "pass" }'
bundle exec rake ss:create_site data='{ name: "自治体サンプル", host: "www", domains: "localhost:3000" }'
bundle exec rake ss:create_site data='{ name: "企業サンプル", host: "company", domains: "192.168.33.10:3000" }'
bundle exec rake ss:create_site data='{ name: "子育て支援サンプル", host: "childcare", domains: "192.168.33.11:3000" }'
bundle exec rake ss:create_site data='{ name: "オープンデータサンプル", host: "opendata", domains: "192.168.33.12:3000" }'
bundle exec rake db:seed name=demo site=www
bundle exec rake db:seed name=company site=company
bundle exec rake db:seed name=childcare site=childcare
bundle exec rake db:seed name=opendata site=opendata
bundle exec rake db:seed name=gws site=シラサギ市
bundle exec rake cms:generate_nodes
bundle exec rake cms:generate_pages

bin/deploy
_EOT_

# use openlayers as default map
echo 'db.ss_sites.update({}, { $set: { map_api: "openlayers" } }, { multi: true });' | mongo ss > /dev/null
