# install rvm & ruby
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
if [ $? -ne 0 ]; then
  gpg2 --keyserver hkp://pgp.mit.edu --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
fi
curl -sSL https://get.rvm.io | sudo bash -s stable --ruby=2.4.2

echo "gem: --no-ri --no-rdoc" >> /home/vagrant/.gemrc
echo "install: --no-document" >> /home/vagrant/.gemrc
echo "update: --no-document" >> /home/vagrant/.gemrc
chown vagrant:vagrant /home/vagrant/.gemrc

echo "export rvmsudo_secure_path=0" > /etc/profile.d/rvmsudo_secure_path.sh
sed -ie 's/\(Defaults[\t ][\t ]*secure_path\)/# \1/' /etc/sudoers
