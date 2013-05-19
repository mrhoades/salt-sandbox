#!/bin/bash
set -eux
root=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)/..

# clean up any existing stack.
salt-cloud -d os-controller os-compute-{0,1}
sleep 20 # wait for vm destroy to complete

# boot fresh vms, and bootstrap them into minions
salt-cloud -m $root/maps/three-node.map
# TODO: build minions in parallel. right now salt-cloud is busted:
#  https://github.com/saltstack/salt-cloud/issues/549
# salt-cloud -m $root/maps/three-node.map -P
echo $?

# install software/configs
salt \* state.highstate
echo $?

# initialize DBs
salt os-controller cmd.script salt://scripts/init-db

# initialize openstack
salt os-controller cmd.script salt://scripts/init-keystone

