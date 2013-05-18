### key management

show pending keys: `salt-key -L`
* accept key: `salt-key -a hostname`
* accept all keys: `salt-key -A`
* delete key: `salt-key -d hostname`
* delete all keys: `salt-key -D`
* show pubkey: `salt-key -p hostname`


### basic commands

* pingall: `salt \* test.ping`
* run command: `salt \* cmd.run uptime`
* install package: `salt \* pkg.install git`


### modules:

* help for all modules: `salt '*' sys.doc | less`
* network (ifaces, macs, ips, arp, etc)
* cmd (run, script, exec_code, run_stderr)
* git
* iptables


### salt-cloud

* list images: `salt-cloud --list-images openstack`
* list sizes: `salt-cloud --list-sizes openstack`

define vm profiles in /etc/salt/cloud.profiles:

```
demo:
  provider: openstack
  size: standard.xsmall
  image: Ubuntu Server 12.04.2 LTS (amd64 20130318) - Partner Image
  os: Ubuntu
  ssh_username: ubuntu
  sudo: true
```

* boot vms from profile: `salt-cloud -p $profile_name hostname_a hostname_b ...`
* boot vms in parallel: `salt-cloud -P -p $profile_name host-{1,2,3}`
* destroy vms by name: `salt-cloud -d hostname ...` or by regexp: `salt-cloud -d host-{1,2,3}`

#### maps

boot all vms in a map: `salt-cloud -m $map_file -P`


### targeting

* glob: `salt 'os-*' test.ping`
* glob: `salt 'compute[1-5]' test.ping`
* regexp (`-E`): `salt -E 'db0-(test|prod)' test.ping`
* list (`-L`): `salt -L 'db0,db1' test.ping`
* ip (`-S`): `salt -S 10.4.123.17 grains.items`
* subnet (`-S`): `salt -S 10.0.0.0/24 test.ping`
* grains (`-G`): `salt -G 'os:Ubuntu' test.ping`  `salt -G 'roles:compute' cmd.run uptime`
* grains with regexp: `salt --grain-pcre 'os:Ubun.*' test.ping`


### grains

* list: `salt '*' grains.ls`
* show: `salt '*' grains.items`

