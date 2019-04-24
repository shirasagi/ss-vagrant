# install rvm & ruby
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
if [ $? -ne 0 ]; then
  gpg2 --keyserver hkp://pgp.mit.edu --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
fi

curl -sSLo rvm-installer https://raw.githubusercontent.com/rvm/rvm/1.29.4/binscripts/rvm-installer
sudo bash rvm-installer --version 1.29.4 --ruby=2.4.6

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
