wget -qO- https://toolbelt.heroku.com/install.sh | sh
echo 'PATH="/usr/local/heroku/bin:$PATH"' >> /etc/profile.d/heroku.sh
source /etc/profile.d/heroku.sh
heroku --version
