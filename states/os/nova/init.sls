nova_repo:
  git.latest:
    - name: https://github.com/openstack/nova.git
    - rev: master
    - target: /opt/stack/nova
    - require:
      - pkg: git

pip install -i http://pypi.openstack.org/openstack -r /opt/stack/nova/tools/pip-requires:
  cmd.run

pip install -i http://pypi.openstack.org/openstack /opt/stack/nova:
  cmd.run

nova_user:
  user.present:
    - name: nova
    - shell: /bin/false

/etc/nova/nova.conf:
  file:
    - managed
    - source: salt://os/nova/nova.conf
    - template: jinja
    - context:
        secrets: {{ pillar['secrets'] }}
        endpoints: {{ pillar['endpoints'] }}
        nova: {{ pillar['nova'] }}

/etc/nova/logging.conf:
  file:
    - managed
    - source: salt://os/nova/logging.conf

/etc/init/nova-api.conf:
  file:
    - managed
    - source: salt://os/nova/nova-api.upstart
    - user: root
    - group: root
    - mode: 644

/var/lib/nova:
  file.directory:
    - user: nova

/var/log/nova:
  file.directory:
    - user: nova

nova_api_service:
  service:
    - name: nova-api
    - running

