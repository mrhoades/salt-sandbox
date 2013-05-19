keystone_repo:
  git.latest:
    - name: https://github.com/openstack/keystone.git
    - rev: master
    - target: /opt/stack/keystone
    - require:
      - pkg: git

pip install -i http://pypi.openstack.org/openstack -r /opt/stack/keystone/tools/pip-requires:
  cmd.run

pip install /opt/stack/keystone:
  cmd.run

keystone_user:
  user.present:
    - name: keystone
    - shell: /bin/false

/etc/keystone/keystone.conf:
  file:
    - managed
    - source: salt://os/keystone/keystone.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        secrets: {{ pillar['secrets'] }}
        endpoints: {{ pillar['endpoints'] }}

/etc/keystone/policy.json:
  file:
    - managed
    - source: salt://os/keystone/policy.json

/etc/init/keystone.conf:
  file:
    - managed
    - source: salt://os/keystone/keystone.upstart
    - user: root
    - group: root
    - mode: 644

keystone_service:
  service:
    - name: keystone
    - running
    - watch:
      - file: /etc/keystone/keystone.conf

