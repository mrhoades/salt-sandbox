## now

* default keystone users

## urgent bugs

* salt cmd.script salt://scripts/init-keystone fails, but exits 0 with no output, works locally with salt-call cmd.script salt://scripts/init-keystone
* salt-cloud parallel build is busted: https://github.com/saltstack/salt-cloud/issues/549
* salt state.highstate does not exit non-zero on failure.  see several github issues.
* salt cmd.script does not handle exit codes correctly, either.

## misc

* default glance images
* nova-compute services
* quantum services
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

* automated integration test for what's done so far.
