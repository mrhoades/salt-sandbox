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
    - source: salt://os/nova/etc/nova.conf
    - template: jinja
    - context:
        secrets: {{ pillar['secrets'] }}
        endpoints: {{ pillar['endpoints'] }}
        nova: {{ pillar['nova'] }}

/etc/nova/logging.conf:
  file:
    - managed
    - source: salt://os/nova/etc/logging.conf

/etc/nova/api-paste.ini:
  file:
    - managed
    - source: salt://os/nova/etc/api-paste.ini
    - context:
        secrets: {{ pillar['secrets'] }}
        endpoints: {{ pillar['endpoints'] }}


/var/lib/nova:
  file.directory:
    - user: nova

/var/log/nova:
  file.directory:
    - user: nova
