SHIRASAGI Vagrant
===

SHIRASAGI 開発用の Vagrant Box を公開します。

## 事前準備

SHIRASAGI 開発用の Vagrant Box を使用するには次のいずれかの環境が必要です。

* 64ビット Windows
* Mac
* 64ビット Ubuntu / RedHat / CentOS / 他 Linux 全般

事前に VirtualBox と Vagrant をインストールしてください。

* [VirtualBox](https://www.virtualbox.org/):
  * [ダウンロード](https://www.virtualbox.org/wiki/Downloads) から各環境に応じたインストーラーをダウンロードし、インストーラーを実行してください。
  * インストーラー実行後は、インストーラーの指示にしたがってインストールを完了させてください。
* [Vagrant](https://www.vagrantup.com/):
  * [ダウンロード](https://www.vagrantup.com/downloads.html) から各環境に応じたインストーラーをダウンロードし、インストーラーを実行してください。
  * インストーラー実行後は、インストーラーの指示にしたがってインストールを完了させてください。

## 使用方法

適当なディレクトリを作成し、次のような内容を持つ `Vagrantfile` を作成してください。

    $ mkdir shirasagi-dev
    $ cd shirasagi-dev
    $ cat Vagrantfile
    Vagrant.configure(2) do |config|
      config.vm.box = "ss-vagrant-v1.2.1"
      config.vm.box_url = "https://github.com/shirasagi/ss-vagrant/releases/download/v1.2.1/ss-vagrant-virtualbox-x86_64.box"
      config.vm.network :forwarded_port, guest: 3000, host: 3000
      config.vm.network "private_network", ip: "192.168.33.10"

      config.vm.provider :virtualbox do |vb|
        # see: http://blog.shibayu36.org/entry/2013/08/12/090545
        # IPv6 と DNS でのネットワーク遅延対策で追記
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
      end
    end

次のコマンドを実行してください。シラサギ開発環境が起動します。

    $ vagrant up

`vagrant up` コマンドは 10 分から 20 分ぐらいかかるので、コーヒーでも飲みながら待ってください。
`vagrant up` コマンドが失敗した場合、<a href="#vagrant-%E3%81%8C%E8%B5%B7%E5%8B%95%E3%81%97%E3%81%AA%E3%81%84%E5%A0%B4%E5%90%88">Vagrant が起動しない場合</a>を参考にして問題を解決してください。

起動したら次のコマンドを実行すると、シラサギ開発環境にログインすることができます。

    $ vagrant ssh

Windows の方は [Tera Term](https://osdn.jp/projects/ttssh2/) などの SSH クライアントをインストールし、
次の接続情報を使用してログインしてください。

* host: 192.168.33.10
* port: 22
* user: vagrant
* password: vagrant

次のようなプロンプトが表示されれば、シラサギ開発環境へのログインに成功しています。この画面では、コマンドの入力を待ち受けます。

    [vagrant@localhost ~]$

`tree -L 2 /home/vagrant` というコマンドを実行し、SHIRASAGI がインストールされていることを確認してみましょう。

    [vagrant@localhost ~]$ tree -L 2 /home/vagrant
    /home/vagrant
    └── shirasagi
        ├── Gemfile
        ├── Gemfile.lock
        ├── Guardfile
        ├── MIT-LICENSE
        ├── README.md
        ├── Rakefile
        ├── app
        ├── bin
        ├── config
        ├── config.ru
        ├── db
        ├── lib
        ├── log
        ├── private
        ├── public
        ├── spec
        ├── tmp
        └── vendor

`tree` コマンドが見つからないというエラーがでる方は、代わりに `ls -la` コマンドを実行してみましょう。

```sh
[vagrant@localhost ~]$ ls -la
total 152
drwx------ 10 vagrant vagrant  4096 Jun  3 23:04 .
drwxr-xr-x  4 root    root     4096 Apr 26 20:44 ..
-rw-r--r--  1 vagrant vagrant    18 Nov 20  2015 .bash_logout
-rw-r--r--  1 vagrant vagrant   193 Nov 20  2015 .bash_profile
-rw-r--r--  1 vagrant vagrant   255 Apr 26 20:50 .bashrc
-rw-r--r--  1 vagrant vagrant    68 Mar 14 10:35 .gemrc
-rw-------  1 vagrant vagrant     0 May 26 11:09 .mongorc.js
drwxr-----  3 vagrant vagrant  4096 Mar 14 10:41 .pki
drwxrwxr-x 17 vagrant vagrant  4096 Jul  8 19:21 shirasagi
drwx------  2 vagrant vagrant  4096 Apr 26 20:30 .ssh
```

SHIRASAGI がインストールされていることを確認できたので、SHIRASAGI を起動してみましょう。

```sh
$ cd $HOME/shirasagi
$ bundle exec rake unicorn:start
bundle exec unicorn_rails -c /home/vagrant/shirasagi/config/unicorn.rb -E production -D
```

ブラウザで "http://localhost:3000/" にアクセスしてみましょう。
次のような自治体サンプルサイトの画面が表示されれば成功です。

| SHIRASAGI TOP                        |
|--------------------------------------|
| ![SHIRASAGI TOP](images/top-min.png) |

また、"http://192.168.33.10:3000/" にアクセスしてみてください。
次のような企業サンプルサイトの画面が表示されるはずです。

| COMPANY TOP                              |
|------------------------------------------|
| ![SHIRASAGI TOP](images/top-company.png) |

管理画面には http://localhost:3000/.mypage からアクセスできます。

以上で正しくシラサギ開発環境が起動しました。
バリバリとシラサギをいじっていきましょう。

## Vagrant が起動しない場合

### Windows

* 32ビット版 Windows をご利用の方
  * 残念ですがご利用いただけません。
  * どうしてもという方は、[シラサギプロジェクト開発コミュニティ](https://www.facebook.com/groups/ssproj/)で質問してください。
* お使いのパソコンが Intel VT/AMD-V に対応しているかどうかを確認します。
  [VirtualChecker](http://www.forest.impress.co.jp/library/software/virtualcheck/) をダウンロードし、実行してください。
  Enabled と表示されれば Intel VT/AMD-V が有効になっており、Vagrant を使用することができます。
  Disabled と表示された場合、BIOS の設定を確認し Intel VT/AMD-V を有効にすることで Vagrant を使うことが出来ます。
* ユーザ名に日本語が含まれる場合、Vagrant が起動しない場合があります。
  環境変数 `VAGRANT_HOME` を日本語を含まないディレクトリに設定し、VirtualBox の設定を変更し、default VM folder を日本語を含まないディレクトリに変更してください。
  参考: [incompatible character encodings: CP850 and Windows-1252](https://github.com/mitchellh/vagrant/issues/3937)
* Windows 10 をご利用の方で、次のエラーが表示される場合、Microsoft 社より Visual C++ 2010 再配布可能パッケージをダウンロードしインストールしてください。

  ```
  An error occurred while downloading the remote file.
  The error message, if any, is reproduced below.
  Please fix this error and try again.
  ```

  * [Microsoft Visual C++ 2010 再頒布可能パッケージ (x86)](https://www.microsoft.com/ja-jp/download/details.aspx?id=5555)
  * [Microsoft Visual C++ 2010 再頒布可能パッケージ (x64)](https://www.microsoft.com/ja-jp/download/details.aspx?id=14632)
  * 上記 2 つともインストールしてください。

以上で問題が解決しない方は[シラサギプロジェクト開発コミュニティ](https://www.facebook.com/groups/ssproj/)で質問してください。

### Mac

* Intel ベースの Mac では、Intel VT は有効になっていますが、もし使用できない場合は https://support.apple.com/ja-jp/TS2744 を参照してください。

以上で問題が解決しない方は[シラサギプロジェクト開発コミュニティ](https://www.facebook.com/groups/ssproj/)で質問してください。

## 補足

### Vagrant Box の中身

* VirtualBox 5.0.20 r106931 Guest Addition
* CentOS 7.2.1511 (2016-06-11 時点での最新)
* MongoDB 3.2.7
* RVM 1.27.0
* Ruby 2.3.1p112
* SHIRASAGI のソース一式 (v1.2.0)

### Vagrant Box のビルド方法

[Packer](https://www.packer.io/) をインストールしてください。そして、次のコマンドでビルドできます。

    $ git clone "https://github.com/shirasagi/ss-vagrant.git"
    $ cd ss-vagrant/packer
    $ packer build -only=virtualbox-iso template.json

ビルドに成功すると `ss-vagrant-virtualbox-x86_64.box` ができます。
ビルドには 20 分ぐらいかかります。

### 32 ビット版 Vagrant Box のビルド方法

GitHub には、合計 2GB までしかファイルをアップできないため、32 ビット版の提供を取りやめました。
32 ビット版の Vagrant Box が必要な方は、ご自身でビルドしてください。

[Packer](https://www.packer.io/) をインストールしてください。そして、次のコマンドでビルドできます。

    $ git clone "https://github.com/shirasagi/ss-vagrant.git"
    $ cd ss-vagrant/packer
    $ packer build -only=virtualbox-iso -var-file=virtualbox-i386-variables.json template.json

以上。
