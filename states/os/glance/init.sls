glance_repo:
  git.latest:
    - name: https://github.com/openstack/glance.git
    - rev: master
    - target: /opt/stack/glance
    - require:
      - pkg: git

pip install -i http://pypi.openstack.org/openstack -r /opt/stack/glance/tools/pip-requires:
  cmd.run

pip install /opt/stack/glance:
  cmd.run

glance_user:
  user.present:
    - name: glance
    - shell: /bin/false

/etc/glance/glance-api-paste.ini:
  file:
    - managed
    - source: salt://os/glance/glance-api-paste.ini
    - template: jinja
    - context:
        auth_host: {{ pillar['auth_host'] }}
        service_password: {{ pillar['service_password'] }}

/etc/glance/glance-registry-paste.ini:
  file:
    - managed
    - source: salt://os/glance/glance-registry-paste.ini
    - template: jinja
    - context:
        auth_host: {{ pillar['auth_host'] }}
        service_password: {{ pillar['service_password'] }}

/etc/glance/glance-api.conf:
  file:
    - managed
    - source: salt://os/glance/glance-api.conf
    - template: jinja
    - context:
        auth_host: {{ pillar['auth_host'] }}
        service_password: {{ pillar['service_password'] }}
        db_host: {{ pillar['db_host'] }}
        db_password: {{ pillar['db_password'] }}
        rabbit_host: {{ pillar['rabbit_host'] }}
        rabbit_password: {{ pillar['rabbit_password'] }}

/etc/glance/policy.json:
  file:
    - managed
    - source: salt://os/glance/policy.json

/etc/init/glance-api.conf:
  file:
    - managed
    - source: salt://os/glance/glance-api.upstart

/etc/init/glance-registry.conf:
  file:
    - managed
    - source: salt://os/glance/glance-registry.upstart

/var/lib/glance:
  file.directory:
    - user: glance

glance-api-service:
  service:
    - name: glance-api
    - running

glance-registry-service:
  service:
    - name: glance-registry
    - running
