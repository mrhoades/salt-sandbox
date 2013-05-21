
salt-sandbox
============

echohead's salt playground.

### install salt

turn this box into a salt master:

    bin/install-master

configure salt cloud to run a bunch of cloud vms:

    bin/install-saltcloud
    # edit /etc/salt/cloud to add your openstack creds, etc.
    # edit /etc/salt/cloud.profiles to include your image names, etc.

put the states and config data where salt looks for it:

    ln -s $(pwd)/states /srv/salt
    ln -s $(pwd)/pillar /srv/pillar

### spin up some vms

    salt-cloud -m maps/three-node.map -P

### deploy openstack

add ip addresses and set creds in pillar:

    vi pillar/os.sls
    salt '*' saltutil.refresh_pillar

install software and config:

    salt-key -L              # verify that these are the hosts you really mean
    salt \* state.highstate  # install openstack
    salt \* state.highstate  # run it again, required because of bugs at the moment.

initialize state:

    salt os-controller cmd.script salt://scripts/init-db
    salt os-controller cmd.script salt://scripts/init-keystone
    salt os-controller cmd.script salt://scripts/init-glance

### clean up

    salt-cloud -d os-controller os-compute-{0,1}
