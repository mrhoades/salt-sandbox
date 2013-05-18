keystone_repo:
  git.latest:
    - name: https://github.com/openstack/keystone.git
    - rev: master
    - target: /opt/stack/keystone
    - require:
      - pkg: git
