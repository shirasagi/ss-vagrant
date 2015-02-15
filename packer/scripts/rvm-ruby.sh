# install rvm & ruby
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | sudo bash -s stable --ruby=2.1.2

echo "gem: --no-ri --no-rdoc" > /home/vagrant/.gemrc
chown vagrant:vagrant /home/vagrant/.gemrc

# echo "Rebooting the machine..."
# reboot
# sleep 60
