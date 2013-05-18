nova_repo:
  git.latest:
    - name: https://github.com/openstack/nova.git
    - rev: master
    - target: /opt/stack/nova
    - require:
      - pkg: git
