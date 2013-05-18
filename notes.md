
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
