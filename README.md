WTP Development Container [![Build Status](http://jenkins.cometcult.net/job/confr/badge/icon)](http://jenkins.cometcult.net/job/confr/)
=====

1) Requirements
---------------
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://vagrantup.com/)
* [Puppet](http://docs.puppetlabs.com/guides/installation.html)
* NFS (This comes pre-installed on Mac OS X, and is typically a simple package install on Linux)


2) Installing
-------------

Initialize the Vagrant and Puppet setup by doing:

```
./scripts/bootstrap.sh
```

3) Checkout required projects
-----------------------------

Check out the projects that needs to run in orchestration within the vagrant container
```
git clone git@github.com:cometcult/wtp-www.git
git clone git@github.com:cometcult/wtp-server.git
```

Follow each projects own README on how to configure them.

4) Vagrant
----------

Start Vagrant with:

```
vagrant up
```

Keep in mind that the first start may take a while. If you're done with development you can [suspend the VM](http://docs.vagrantup.com/v2/getting-started/teardown.html)


4.1) Troubleshooting Vagrant
----------

### If there's an error regarding en_US.UTF8 or ASCII

This problem is related to missing locales on Ubuntu.

Log in to Vagrant and fix the locale problem:

```
vagrant ssh
sudo locale-gen en_US.UTF8
```

then add following content to the `/etc/environment` file (sudo needed):

```
LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
```

exit and reload:

```
exit
vagrant reload --provision
```