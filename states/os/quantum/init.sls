quantum_repo:
  git.latest:
    - name: https://github.com/openstack/quantum.git
    - rev: master
    - target: /opt/stack/quantum
    - require:
      - pkg: git

pip install -i http://pypi.openstack.org/openstack -r /opt/stack/quantum/tools/pip-requires:
  cmd.run

pip install -i http://pypi.openstack.org/openstack /opt/stack/quantum:
  cmd.run

quantum_user:
  user.present:
    - name: quantum
    - shell: /bin/false

openvswitch-switch:
  pkg.installed

openvswitch-datapath-dkms:
  pkg.installed

python-netaddr:
  pkg.installed

/etc/sudoers.d/quantum:
  file:
    - managed
    - user: root
    - group: root
    - mode: 440
    - source: salt://os/quantum/etc/sudoer
rsync -avh /opt/stack/quantum/etc/quantum/rootwrap.d /etc/quantum:
  cmd.run

/etc/quantum/quantum.conf:
  file:
    - managed
    - source: salt://os/quantum/etc/quantum.conf
    - template: jinja
    - context:
        secrets: {{ pillar['secrets'] }}
        endpoints: {{ pillar['endpoints'] }}
        quantum: {{ pillar['quantum'] }}

/etc/quantum/l3_agent.ini:
  file:
    - managed
    - source: salt://os/quantum/etc/l3_agent.ini
    - context:
        secrets: {{ pillar['secrets'] }}
        endpoints: {{ pillar['endpoints'] }}
        quantum: {{ pillar['quantum'] }}

/etc/quantum/dhcp_agent.ini:
  file:
    - managed
    - source: salt://os/quantum/etc/dhcp_agent.ini

/etc/quantum/rootwrap.conf:
  file:
    - managed
    - source: salt://os/quantum/etc/rootwrap.conf

/etc/sudoers.d/quantum:
  file:
    - managed
    - user: root
    - group: root
    - mode: 440
    - source: salt://os/quantum/etc/sudoer

/etc/quantum/api-paste.ini:
  file:
    - managed
    - source: salt://os/quantum/etc/api-paste.ini
    - template: jinja
    - context:
        secrets: {{ pillar['secrets'] }}
        endpoints: {{ pillar['endpoints'] }}

/etc/quantum/plugins/openvswitch/ovs_quantum_plugin.ini:
  file:
    - managed
    - source: salt://os/quantum/etc/ovs_quantum_plugin.ini
    - template: jinja
    - context:
        secrets: {{ pillar['secrets'] }}
        endpoints: {{ pillar['endpoints'] }}
        quantum: {{ pillar['quantum'] }}

/etc/quantum/policy.json:
  file:
    - managed
    - source: salt://os/quantum/etc/policy.json

/var/lib/quantum:
  file.directory:
    - user: quantum
    - require:
      - user: quantum

