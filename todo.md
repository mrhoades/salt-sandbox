## now

fill in pillar data for endpoints dynamically
/var/lib/nova and /var/log/nova must depend on nova user for first run
upload images to glance

start quantum services

## urgent bugs

* salt cmd.script salt://scripts/init-keystone fails, but exits 0 with no output, works locally with salt-call cmd.script salt://scripts/init-keystone
* salt-cloud parallel build is busted: https://github.com/saltstack/salt-cloud/issues/549
* salt state.highstate does not exit non-zero on failure.  see several github issues.
* salt cmd.script does not handle exit codes correctly, either.
* salt state.highstate does not exit error when bogus states are specified in top.sls.

## misc

* boot an instance

## first-run of highstate:

* (glance, nova, keystone) users must be created before /var/ directories
* pip package must be reqired by pip install commands

## salt

* make it exit with error when state or script/cmd fails
* display success failure at end of highstate output

## log shipping

## monitoring


# done

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
