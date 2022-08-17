If you don't have 'ansible', run below command:

~~~
brew install ansible
~~~

And then run below commands:

~~~
vagrant up && vagrant package
~~~

If the build process is succeeded, you can see `package.box` in the current directory.
You can upload `package.box` to Vagrant Cloud with your browser to publish globally if you like.
