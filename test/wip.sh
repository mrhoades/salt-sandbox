#!/bin/bash
set -eux
set -o pipefail
root=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)/..

# clean up any existing stack.
salt-cloud -d os-controller os-compute-{0,1}
sleep 20 # wait for vm destroy to complete

# boot fresh vms, and bootstrap them into minions
salt-cloud -m $root/maps/three-node.map -P
reset # currently, salt-cloud -P screws up the terminal.

# TODO: generate pillar with correct ips.
# fill in pillar with actual ips
controller_ip=$(salt os-controller network.ip_addrs | tail -1 | awk '{print $2}')
cp $root/pillar/os.sls.template $root/pillar/os.sls
sed -i "s/127.0.0.1/$controller_ip/" $root/pillar/os.sls

# install software/configs
salt \* state.highstate
# TODO: fix state dependencies so that second run is not required.
salt \* state.highstate

# initialize DBs
salt os-controller cmd.script salt://scripts/init-db

# initialize openstack
salt os-controller cmd.script salt://scripts/init-keystone
salt os-controller cmd.script salt://scripts/init-glance
