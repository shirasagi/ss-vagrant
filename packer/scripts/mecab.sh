yum -y install wget

cd /usr/local/src
wget http://mecab.googlecode.com/files/mecab-0.996.tar.gz \
     http://mecab.googlecode.com/files/mecab-ipadic-2.7.0-20070801.tar.gz \
     http://mecab.googlecode.com/files/mecab-ruby-0.996.tar.gz
if [ $? -ne 0 ]; then
  exit 1
fi

cd /usr/local/src
tar xvzf mecab-0.996.tar.gz
cd mecab-0.996
./configure --enable-utf8-only
make
make install
if [ $? -ne 0 ]; then
  exit 2
fi

echo "/usr/local/lib" | tee -a /etc/ld.so.conf
/sbin/ldconfig

export PATH=$PATH:/usr/local/bin

cd /usr/local/src
tar xvzf mecab-ipadic-2.7.0-20070801.tar.gz
cd mecab-ipadic-2.7.0-20070801
./configure --with-charset=UTF-8
make
make install
if [ $? -ne 0 ]; then
  exit 3
fi

cd /usr/local/src
tar xvzf mecab-ruby-0.996.tar.gz
source /etc/profile.d/rvm.sh
cd /usr/local/src/mecab-ruby-0.996
ruby extconf.rb
if [ $? -ne 0 ]; then
  exit 4
fi

make install
if [ $? -ne 0 ]; then
  exit 4
fi
