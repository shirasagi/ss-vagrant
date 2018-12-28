export rvmsudo_secure_path=1
bash -l -c "source /etc/profile.d/rvm.sh; rvmsudo gem install bundler --no-document"
