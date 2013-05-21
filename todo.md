## now

configure ifaces/bridges for quantum
run quantum l3 agent, metadata agent, dhcp agent.
nova instances get quantum ips.
metadata service is reachable from instances

## urgent bugs

* salt state.highstate does not exit non-zero on failure.  see several github issues. this may be fixed on 'develop' branch of salt.
* salt cmd.script does not handle exit codes correctly, either.
* salt state.highstate does not exit error when bogus states are specified in top.sls.

## misc

* boot an instance

## first-run of highstate:

* database create states must require mysql to be present
* pip package and target repo must be reqired by pip install commands

## salt

* make it exit with error when state or script/cmd fails
* display success failure at end of highstate output

## log shipping

## monitoring


# done

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
