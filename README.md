
salt-sandbox
============

echohead's salt playground.

### install salt

master: `bin/install-master`
salt-cloud: `bin/install-saltcloud`
minion: `bin/install-minion $master_host`

`ln -s $(pwd)/states /srv/salt`
`ln -s $(pwd)/pillar /srv/pillar`
