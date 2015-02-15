# source /etc/profile.d/rvm.sh
# source /usr/local/rvm/scripts/rvm
# 
# export rvmsudo_secure_path=1
# rvmsudo gem install bundler -v 1.7.13
# if [ $? -ne 0 ]; then
#   echo "printenv"
#   printenv
# 
#   echo "/usr/local/rvm/scripts/rvm"
#   /usr/local/rvm/scripts/rvm
# 
#   echo "cat /tmp/script.sh"
#   cat /tmp/script.sh
# 
#   bash /tmp/script.sh
# fi
# 
# true

export rvmsudo_secure_path=1
bash -c "source /etc/profile.d/rvm.sh; rvmsudo gem install bundler -v 1.7.13"
