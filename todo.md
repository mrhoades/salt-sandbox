## now

configure quantum with br-int, br-ex, drop ctlplane
init-networking seems to not get called - /e/n/i is not updated.


## quantum notes

(http://techbackground.blogspot.co.nz/2013/05/the-quantum-l3-router-and-floating-ips.html)
(http://docs.openstack.org/grizzly/openstack-network/admin/content/index.html)
(http://docs.openstack.org/grizzly/openstack-network/admin/content/l3_workflow.html)
(http://techbackground.blogspot.ie/2013/05/debugging-quantum-dhcp-and-open-vswitch.html)

## soon

run quantum-metadata-agent on network node
metadata service is reachable from instances
configure appropriate tenant quantum network + default subnet.

## log shipping

## monitoring

## alerting

## tempest

## ceph

## upstream bugs

* salt state.highstate does not exit non-zero on failure.  see several github issues. this may be fixed on 'develop' branch of salt.
* salt cmd.script does not handle exit codes correctly, either.
* salt state.highstate does not exit error when bogus states are specified in top.sls.

## misc

* novnc via horizon

## first-run of highstate:

* database create states must require mysql to be present
* pip package and target repo must be reqired by pip install commands

## salt

* display success failure at end of highstate output


# done

X instances get dhcp.
X set quantum-ovs local_ip setting dynamically.
X use gre network_type instead of flat
X don't run nova-api-metadata on compute nodes (handled by quantum)
X use correct providers for security groups with quantum.
X perfom apt-get update in base state
X script to fire up ssh connection in screen/tmux.:wq
X run horizon
X keystone endpoint was missing from service catalog.
X configure ifaces/bridges for quantum
X create default quantum net/subnet
X run quantum l3 agent, metadata agent, dhcp agent on network node
X nova instances get quantum ips.
X generate keystone certs
X fill in pillar data for endpoints dynamically
X salt-cloud parallel build is busted: https://github.com/saltstack/salt-cloud/issues/549
  - pull request: https://github.com/saltstack/salt-cloud/issues/549
  - can be installed from here until landing:
      https://github.com/echohead/salt-cloud/tree/parallel_create_hangs
X start quantum agent
X run nova-api-metadata on compute nodes.
X boot bigger instances
X use vms with more mem
X run quantum service
X install quantum software
X (glance, nova, keystone) users must be created before /var/ directories
X /var/lib/nova and /var/log/nova must depend on nova user for first run
X pull default images from pillar
X upload images to glance
X nova-client auths correctly with default stackrc.
X init-keystone does not run subsequent times unless run locally with salt-call.
X run nova-compute
X init-keystone fails first time with 'Could not find service:'
X configure nova rootwrap
X install rabbit
X run all nova non-compute services
X run nova-api
X default keystone endpoints
X default keystone users
X automated integration test for what's done so far.
