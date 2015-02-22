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
      config.vm.box = "ss-vagrant-0.6.0"
      config.vm.box_url = "https://github.com/shirasagi/ss-vagrant/releases/download/v0.6.0/ss-vagrant-virtualbox.box"
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

Windows の方は、別途 Git をインストールし git-bash から上記コマンドを実行してください。

`vagrant up` には 5 分から 10 分ぐらいかかるので、コーヒーでも飲みながら待ってください。

起動したら次のコマンドでログインしてください。

    $ vagrant ssh

Windows の方は Tera Term などの SSH クライアントで、
次の接続情報を使用してログインしたほうが快適に使えると思います。

* host: localhost
* port: 2222
* user: vagrant
* password: vagrant

SHIRASAGI は /home/vagrant の直下にインストールしています。

    $ tree -L 2 /home/vagrant
    /home/vagrant
    `-- shirasagi
        |-- app
        |-- bin
        |-- config
        |-- config.ru
        |-- db
        |-- doc
        |-- Gemfile
        |-- Gemfile.lock
        |-- Guardfile
        |-- lib
        |-- MIT-LICENSE
        |-- private
        |-- public
        |-- Rakefile
        |-- README.md
        |-- spec
        `-- vendor

SHIRASAGI を起動してみましょう。

```
$ cd $HOME/shirasagi
$ bundle exec rake unicorn:start
bundle exec unicorn_rails -c /home/vagrant/shirasagi/config/unicorn.rb -E production -D
```

ブラウザで "http://localhost:3000/" にアクセスしてみましょう。
次のような画面が表示されれば成功です。

| SHIRASAGI TOP                        |
|--------------------------------------|
| ![SHIRASAGI TOP](images/top-min.png) |

## Vagrant Box の中身

* CentOS 6.6 (2015-02-12 時点での最新)
* MongoDB 2.6.7
* RVM 1.26.10
* Ruby 2.1.2p95
* SHIRASAGI のソース一式 (v0.6.0)


## Vagrant のインストール方法

1. [VirtualBox Download](https://www.virtualbox.org/wiki/Downloads) ページから VirtualBox をダウンロードしてインストールする。
2. [Vagrant Download](http://www.vagrantup.com/downloads.html) ページから Vagrant をダウンロードしてインストールする。
3. (Windows の人のみ) [Git for Windows](https://msysgit.github.io/) ページから Git をダウンロードしてインストールする。
   これは `vagrant up` 時に ssh コマンドが必要になるためで、Git に付属している ssh を用いるのが一番手っ取り早いのでインストールします。
4. (Windows の人のみ) [Tera Term](http://sourceforge.jp/projects/ttssh2/releases/) などのお好きな SSH クライアントをインストール。

## Vagrant Box のビルド方法

`packer` を別途インストールしてください。そして、次のコマンドでビルドできます。

    $ cd packer
    $ packer build -only=virtualbox-iso template.json

ビルドに成功すると `ss-vagrant-virtualbox.box` ができます。
ビルドには 20 分ぐらいかかります。

以上。
