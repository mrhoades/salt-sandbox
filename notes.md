
=== key management

show pending keys: `salt-key -L`
accept key: `salt-key -a hostname`
accept all keys: `salt-key -A`
delete key: `salt-key -d hostname`
delete all keys: `salt-key -D`
show pubkey: `salt-key -p hostname`


=== basic commands
pingall: `salt \* test.ping`
run command: `salt \* cmd.run uptime`

=== salt-cloud

list images: `salt-cloud --list-images openstack`
list sizes: `salt-cloud --list-sizes openstack`

define vm profiles in /etc/salt/cloud.profiles:

```
demo:
  provider: openstack
  image: Ubuntu Server 12.04.2 LTS (amd64 20130318) - Partner Image
  size: standard.xsmall
  os: Ubuntu
```

boot vms from profile: `salt-cloud -p $profile_name hostname_a hostname_b ...`
boot vms in parallel: `salt-cloud -P -p $profile_name host-{1,2,3}`
destroy vms by name: `salt-cloud -d hostname ...` or by regexp: `salt-cloud -d host-{1,2,3}`

