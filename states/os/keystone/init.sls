keystone_repo:
  git.latest:
    - name: https://github.com/openstack/keystone.git
    - rev: master
    - target: /opt/stack/keystone
    - require:
      - pkg: git

/etc/keystone/keystone.conf:
  file:
    - managed
    - source: salt://os/keystone/keystone.conf
    - user: root
    - group: root
    - mode: 644
