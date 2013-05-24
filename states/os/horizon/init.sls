horizon_repo:
  git.latest:
    - name: https://github.com/openstack/horizon.git
    - rev: master
    - target: /opt/stack/horizon
    - require:
      - pkg: git

nodejs:
  pkg.installed

apache2:
  pkg.installed

memcached:
  pkg.installed

libapache2-mod-wsgi:
  pkg.installed

python /opt/stack/horizon/tools/install_venv.py:
  cmd:
    - run
    - unless: ls /opt/stack/horizon/.venv
    - require:
      - git: horizon_repo

/opt/stack/horizon/static:
  file.directory:
    - user: www-data
    - require:
      - git: horizon_repo


/etc/apache2/httpd.conf:
  file:
    - managed
    - source: salt://os/horizon/etc/httpd.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: apache2

/opt/stack/horizon/openstack_dashboard/local/local_settings.py:
  file:
    - managed
    - source: salt://os/horizon/etc/local_settings.py
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        secrets: {{ pillar['secrets'] }}
        endpoints: {{ pillar['endpoints'] }}
    - require:
      - git: horizon_repo

horizon_service:
  service:
    - name: apache2
    - running
