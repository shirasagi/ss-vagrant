SHIRASAGI Vagrant
===

SHIRASAGI 開発用の Vagrant Box を公開します。


## 使用方法

適当なディレクトリを作成し、次のような内容を持つ `Vagrantfile` を作成してください。

    $ mkdir shirasagi-dev
    $ cd shirasagi-dev
    $ cat Vagrantfile
    VAGRANTFILE_API_VERSION = "2"
    Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
      config.vm.box = "ss-dev"
      config.vm.box_url = "https://github.com/shirasagi/ss-vagrant/releases/download/20150212/ss-vagrant.box"
      config.vm.network :forwarded_port, guest: 3000, host: 3000

      config.vm.provider :virtualbox do |vb|
        # see: http://blog.shibayu36.org/entry/2013/08/12/090545
        # IPv6 と DNS でのネットワーク遅延対策で追記
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
      end
    end

次のコマンドで起動できます。

    $ vagrant up

## ss-dev.box の中身

* CentOS 6.* (2015-02-12 時点での最新)
* MongoDB 2.6.7
* Ruby 2.1.2
* SHIRASAGI のソース一式 (2015-02-12 時点での最新)
