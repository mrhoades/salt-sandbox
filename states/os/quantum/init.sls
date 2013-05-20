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

/etc/quantum/quantum.conf:
  file:
    - managed
    - source: salt://os/quantum/etc/quantum.conf
    - template: jinja
    - context:
        secrets: {{ pillar['secrets'] }}
        endpoints: {{ pillar['endpoints'] }}
        network: {{ pillar['network'] }}

/etc/quantum/policy.json:
  file:
    - managed
    - source: salt://os/quantum/etc/policy.json

/var/lib/quantum:
  file.directory:
    - user: quantum
    - require:
      - user: quantum

