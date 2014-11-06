#!/bin/bash

git submodule update --init --recursive

DYNAMIC_CONFIG="config.vm.hostname = 'wtp.dev'
  config.hostmanager.aliases = %w(api.wtp.dev)"
SYNCED_FOLDER="config.vm.synced_folder \"./wtp-www\", \"/home/vagrant/wtp-www.dev\", :nfs => true
  config.vm.synced_folder \"./wtp-server\", \"/home/vagrant/wtp-server.dev\", :nfs => true"

cat .puppet/Vagrantfile |
    sed -e 's/manifests_path = "manifests"/manifests_path = ".puppet\/manifests"/g' |
    sed -e 's/33.33.33.10/33.33.33.20/g' |
    sed -e 's/comet-project/wtp-dev-container/g' |
    sed -e 's/module_path = "modules"/module_path = ".puppet\/modules"/g' > Vagrantfile

VAGRANTFILE=`cat Vagrantfile`
VAGRANTFILE="${VAGRANTFILE/\#SYNCED_FOLDER\#/${SYNCED_FOLDER}}"
VAGRANTFILE="${VAGRANTFILE/\#DYNAMIC_CONFIG\#/${DYNAMIC_CONFIG}}"
echo "$VAGRANTFILE" > Vagrantfile

HAS_HOSTMANGER=`vagrant plugin list | grep vagrant-hostmanager | wc -l`
if [ $HAS_HOSTMANGER -eq 0 ] 
then
	echo "vagrant-hostmanager plugin missing, installing..."
	vagrant plugin install vagrant-hostmanager
else
	vagrant plugin update vagrant-hostmanager
fi
