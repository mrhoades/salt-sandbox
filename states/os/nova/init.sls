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

/etc/nova/api-paste.ini:
  file:
    - managed
    - source: salt://os/nova/api-paste.ini
    - context:
        secrets: {{ pillar['secrets'] }}
        endpoints: {{ pillar['endpoints'] }}

/etc/init/nova-api.conf:
  file:
    - managed
    - source: salt://os/nova/nova-api.upstart

/etc/init/nova-cert.conf:
  file:
    - managed
    - source: salt://os/nova/nova-cert.upstart

/etc/init/nova-consoleauth.conf:
  file:
    - managed
    - source: salt://os/nova/nova-consoleauth.upstart

/etc/init/nova-scheduler.conf:
  file:
    - managed
    - source: salt://os/nova/nova-scheduler.upstart

/etc/init/nova-conductor.conf:
  file:
    - managed
    - source: salt://os/nova/nova-conductor.upstart

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
    - watch:
      - file: /etc/nova/nova.conf

nova_cert_service:
  service:
    - name: nova-cert
    - running
    - watch:
      - file: /etc/nova/nova.conf

nova_consoleauth_service:
  service:
    - name: nova-consoleauth
    - running
    - watch:
      - file: /etc/nova/nova.conf

nova_scheduler_service:
  service:
    - name: nova-scheduler
    - running
    - watch:
      - file: /etc/nova/nova.conf

nova_conductor_service:
  service:
    - name: nova-conductor
    - running
    - watch:
      - file: /etc/nova/nova.conf
