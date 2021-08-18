# install rvm & ruby
curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSLo rvm-installer https://raw.githubusercontent.com/rvm/rvm/1.29.4/binscripts/rvm-installer
sudo bash rvm-installer --version 1.29.4 --ruby=2.6.3

echo "gem: --no-ri --no-rdoc" >> /home/$SUDO_USER/.gemrc
echo "install: --no-document" >> /home/$SUDO_USER/.gemrc
echo "update: --no-document" >> /home/$SUDO_USER/.gemrc
chown $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.gemrc

echo "export rvmsudo_secure_path=0" > /etc/profile.d/rvmsudo_secure_path.sh
sed -ie 's/\(Defaults[\t ][\t ]*secure_path\)/# \1/' /etc/sudoers

# rvm multi user mode setup
usermod -a -G rvm $SUDO_USER
if [ -f /home/$SUDO_USER/.bashrc ]; then
  echo "umask 002" >>  /home/$SUDO_USER/.bashrc
fi
if [ -f /home/$SUDO_USER/.zshrc ]; then
  echo "umask 002" >>  /home/$SUDO_USER/.zshrc
fi
