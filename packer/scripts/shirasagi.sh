yum -y install git wget ImageMagick ImageMagick-devel

mkdir -p /var/www/
git clone https://github.com/shirasagi/shirasagi /var/www/shirasagi
chown -R $SUDO_USER:$SUDO_USER /var/www/shirasagi

cd $HOME && cat << _EOT_ | sudo -u $SUDO_USER bash
cd \$HOME
source /etc/profile.d/rvm.sh
ln -s /var/www/shirasagi .
cd shirasagi
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

# enable recommendation
sed -e "s/disable: true$/disable: false/" config/defaults/recommend.yml > config/recommend.yml

# install seeds
bundle exec rake db:create_indexes
bundle exec rake ss:create_user data='{ name: "システム管理者", email: "sys@example.jp", password: "pass" }'
bundle exec rake ss:create_site data='{ name: "自治体サンプル", host: "www", domains: "localhost:3000" }'
bundle exec rake ss:create_site data='{ name: "企業サンプル", host: "company", domains: "192.168.33.10:3000" }'
bundle exec rake ss:create_site data='{ name: "子育て支援サンプル", host: "childcare", domains: "192.168.33.11:3000" }'
bundle exec rake ss:create_site data='{ name: "オープンデータサンプル", host: "opendata", domains: "192.168.33.12:3000" }'
bundle exec rake ss:create_site data='{ name: "LPサンプル", host: "lp_", domains: "192.168.33.13:3000" }'
bundle exec rake db:seed name=demo site=www
bundle exec rake db:seed name=company site=company
bundle exec rake db:seed name=childcare site=childcare
bundle exec rake db:seed name=opendata site=opendata
bundle exec rake db:seed name=lp site=lp_
bundle exec rake db:seed name=gws site=シラサギ市

# use openlayers as default map
echo 'db.ss_sites.update({}, { $set: { map_api: "openlayers" } }, { multi: true });' | mongo ss > /dev/null

bundle exec rake cms:generate_nodes
bundle exec rake cms:generate_pages

bin/deploy
_EOT_

# modify ImageMagick policy to work with simple captcha
# see: https://github.com/diaspora/diaspora/issues/6828
cd /etc/ImageMagick && cat << _EOT_ | patch
--- policy.xml.orig     2016-12-08 13:50:47.344009000 +0900
+++ policy.xml  2016-12-08 13:15:22.529009000 +0900
@@ -67,6 +67,8 @@
   <policy domain="coder" rights="none" pattern="MVG" />
   <policy domain="coder" rights="none" pattern="MSL" />
   <policy domain="coder" rights="none" pattern="TEXT" />
-  <policy domain="coder" rights="none" pattern="LABEL" />
+  <!-- <policy domain="coder" rights="none" pattern="LABEL" /> -->
   <policy domain="path" rights="none" pattern="@*" />
+  <policy domain="coder" rights="read | write" pattern="JPEG" />
+  <policy domain="coder" rights="read | write" pattern="PNG" />
 </policymap>
_EOT_
