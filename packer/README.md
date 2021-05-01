Packer build scripts
===

## Prerequisites

VirtualBox 6.1.22 or above
Packer 1.7.2 or above
Vagrant ...

## Build

Run:

~~
packer build -only=virtualbox-iso template.json
~~

## Test

Run blow command to launch vagrant box and login to it:

~~
$ vagrant box add --name ss-vagrant-test ./ss-vagrant-virtualbox-x86_64.box
==> box: Box file was not detected as metadata. Adding it directly...
==> box: Adding box 'ss-vagrant-test' (v0) for provider: 
    box: Unpacking necessary files from: file:///Users/nakano_hideo/Projects/ss-vagrant/packer/ss-vagrant-virtualbox-x86_64.box
==> box: Successfully added box 'ss-vagrant-test' (v0) for 'virtualbox'!
$ cd ../test
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'ss-vagrant-test'...
==> default: Matching MAC address for NAT networking...
==> default: Setting the name of the VM: test_default_1619843801932_91575
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 3000 (guest) => 3000 (host) (adapter 1)
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: private key
    default: 
    default: Vagrant insecure key detected. Vagrant will automatically replace
    default: this with a newly generated keypair for better security.
    default: 
    default: Inserting generated public key within guest...
    default: Removing insecure key from the guest if it's present...
    default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
==> default: Mounting shared folders...
    default: /vagrant => /Users/nakano_hideo/Projects/ss-vagrant/test
$ vagrant up
$ vagrant ssh
~~

In the vagrant box, run below command to examine SHIRASAGI installation:

~~~
$ tree -L 2 /var/www/
/var/www/
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

12 directories, 7 files

$ cd /var/www/shirasagi/
$ bin/rake unicorn:start
bundle exec unicorn_rails -c /var/www/shirasagi/config/unicorn.rb -E production -D
~~~

Then access to "http://localhost:3000/.mypage" with your browser and you can login to SHIRASAGI with `sys` / `pass`.

After examined SHIRASAGI, run blow command to clean-up all:

~~~
$ vagrant destroy
    default: Are you sure you want to destroy the 'default' VM? [y/N] y
==> default: Forcing shutdown of VM...
==> default: Destroying VM and associated drives...
~~~
