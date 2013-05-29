## now

- instances get metadata
- instances can talk to each other
- instances can talk to internet

https://github.com/mseknibilel/OpenStack-Grizzly-Install-Guide/blob/OVS_MultiNode/OpenStack_Grizzly_Install_Guide.rst

- change private addresses to come from 172.16.0.0/20
- change public addresses to be something realistic.


quantum subnet-create --gateway 10.4.0.1 --ip-version 4 --dns-nameserver 8.8.8.8 --disable-dhcp public 172.16.20.0/24

nova_api ip used in metadata_agent.ini must be public ip!!!!!!!


enable ip forwarding:
    sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
    # To save you from rebooting, perform the following
    sysctl net.ipv4.ip_forward=1

on exteral subnet, disable "use_dhcp"
  (pass '--disable-dhcp' to subnet-create)

nova secgroups should be disabled ?
  http://docs.openstack.org/folsom/openstack-network/admin/content/ch_limitations.html

mkdir /var/log/quantum ?

    nova secgroup-add-rule default icmp 0 0 0.0.0.0/0
    nova secgroup-add-rule default tcp 22 22 0.0.0.0/0

    quantum router-create router1
    quantum net-create public --router:external=True
    quantum subnet-create public 172.16.1.0/24
    quantum router-interface-add router1 67cc5b46-c14c-4b62-8ec1-7b4f4a811d6a
                                         (internal id)
    ip netns exec qrouter-21ddd461-4a11-4c51-b867-f28d02f59580 ssh cirros@192.0.2.34
                          (router id)

vms can ping+ssh to each other!
vms get dhcp on default internal network, cloud-init times out
verrrrrry slowly (like an hour) on metadata

    1  source /root/stackrc
    4  quantum router-create default-router
    5  quantum router-interface-add default-router 11f88779-4736-4753-ba6d-f4ccc972199a
    8  nova secgroup-add-rule default icmp 0 0 0.0.0.0/0
    9  nova secgroup-add-rule default tcp 22 22 0.0.0.0/0
    6  nova boot --image cirros --flavor 1 foo
   11  nova boot --image cirros --flavor 1 foo2


foo2, foo3 got dhcp of 172.
foo was ssh-able only once router was started.
foo2, foo3 are still not ssh-able
add router to private net?
    1  source /root/stackrc 
    2  nova boot --image cirros --flavor 1 foo
    3  watch nova list
    4  nova console-log foo
    5  nova list
    6  quantum router-list
    7  tail -200 /var/log/upstart/nova-api.log 
    8  grep -RI vnc_auto /var/log/upstart/
    9  nova list
   10  nova console-log foo | less
   11  quantum net-list
   12  nova console-log foo | less
   13  quantum net-list
   14  quantum router-create router1
   15  quantum router-list
   16  quantum net-create public --router:external=True
   17  quantum subnet-create public 172.16.1.0/24
   18  quantum net-lit
   19  quantum net-list
   20  quantum subnet-list
   21  quantum router-list
   22  quantum router-interface-add router1 67cc5b46-c14c-4b62-8ec1-7b4f4a811d6a
   23  quantum router-list
   24  nova boot --image cirros --flavor 1 foo2
   25  nova list
   26  nova console-log foo2
   27  nova boot --image cirros --flavor 1 foo3
   28  nova list
   29  nova console-log foo3
   30  nova list
   31  quantum help | grep security
   32  quatnum security-group-list
   33  quantum security-group-list
   34  nova help | grep security
   35  nova secgroup-list
   36  nova help | grep secgroup
   37  nova secgroup-list-rules default
   38  nova help secgroup-add-rule
   39  nova secgroup-add-rule default icmp 0 0
   40  nova secgroup-add-rule default icmp 0 0 0.0.0.0/0
   41  nova secgroup-list-rules default
   42  nova list
   43  nova console-log foo3 | less
   44  nova list
   45  nova help secgroup-add-rule
   46  nova secgroup-add-rule default tcp 22 22 0.0.0.0/0
   47  quantum net-list
   48  quantum subnet-list
   49  quantum router-list




quantum-ns-metadata-proxy is started by l3_agent when a quantum router exists:
  http://docs.openstack.org/trunk/openstack-network/admin/content/l3_workflow.html

quantum-ns-metadata-proxy does not start:
2013-05-28 20:30:33.708 30350 TRACE quantum Traceback (most recent call last):
2013-05-28 20:30:33.708 30350 TRACE quantum   File "/usr/local/bin/quantum-ns-metadata-proxy", line 9, in <module>
2013-05-28 20:30:33.708 30350 TRACE quantum     load_entry_point('quantum==2013.2.a649.gc3e24c8', 'console_scripts', 'quantum-ns-metadata-proxy')()
2013-05-28 20:30:33.708 30350 TRACE quantum   File "/usr/local/lib/python2.7/dist-packages/quantum/agent/metadata/namespace_proxy.py", line 170, in main
2013-05-28 20:30:33.708 30350 TRACE quantum     router_id=cfg.CONF.router_id)
2013-05-28 20:30:33.708 30350 TRACE quantum   File "/usr/local/lib/python2.7/dist-packages/quantum/agent/metadata/namespace_proxy.py", line 135, in __init__
2013-05-28 20:30:33.708 30350 TRACE quantum     super(ProxyDaemon, self).__init__(pidfile, uuid=uuid)
2013-05-28 20:30:33.708 30350 TRACE quantum   File "/usr/local/lib/python2.7/dist-packages/quantum/agent/linux/daemon.py", line 90, in __init__
2013-05-28 20:30:33.708 30350 TRACE quantum     self.pidfile = Pidfile(pidfile, procname, uuid, root_helper)
2013-05-28 20:30:33.708 30350 TRACE quantum   File "/usr/local/lib/python2.7/dist-packages/quantum/agent/linux/daemon.py", line 33, in __init__
2013-05-28 20:30:33.708 30350 TRACE quantum     self.fd = os.open(pidfile, os.O_CREAT | os.O_RDWR)
2013-05-28 20:30:33.708 30350 TRACE quantum TypeError: coercing to Unicode: need string or buffer, NoneType found

  pidfile?

  ns-metadata-proxy is supposed to be started by quantum-l3-agent, with the --pid_file passed in as a command line arg.

  quantum-ns-metadata-proxy has incorrect path (/usr/local/bin) in dhcp and l3 rootwraps.

  is a router port required for ns-metadata-proxy to be started?

metadata service is reachable from instances
(quantum-ns-metadata-proxy) ?
  https://docs.google.com/document/d/1wixS-CrHe37Fv4my9MxUVeQKDb3mUJJCwPnireQ1gn8/edit
configure service_quantum_metadata_proxy, quantum_metadata_proxy_shared_secret:
  http://docs.openstack.org/trunk/openstack-network/admin/content/nova_config_metadata.html

ping+login vms, given dhcp.

init-networking seems to fail when run during highstate.

## quantum notes

(http://techbackground.blogspot.co.nz/2013/05/the-quantum-l3-router-and-floating-ips.html)
(http://docs.openstack.org/grizzly/openstack-network/admin/content/index.html)
(http://docs.openstack.org/grizzly/openstack-network/admin/content/l3_workflow.html)
(http://techbackground.blogspot.ie/2013/05/debugging-quantum-dhcp-and-open-vswitch.html)

## soon

ntp
configure appropriate tenant quantum network + default subnet.

## log shipping

## monitoring

## alerting

## tempest

## ceph

## upstream bugs

* salt sometimes hangs onto minion state for a hostname, and must be restarted.
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

X allow icmp and ssh access to vms by default
X do nova-compute nodes need the 192. address?  yes - 192.168.122.0/24
X run quantum-metadata-agent on network node
X fix quantum-l3-agent on network node: The external network bridge 'br-ex' does not exist
X salt-master sometimes hangs onto some state for a vm name across deploys - restarting master seems to resolve it.
X configure quantum with br-int, br-ex, drop ctlplane
X init-networking wasn't being run automatically on ovs nodes
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
