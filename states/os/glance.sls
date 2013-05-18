glance_repo:
  git.latest:
    - name: https://github.com/openstack/glance.git
    - rev: master
    - target: /opt/stack/glance
    - require:
      - pkg: git
