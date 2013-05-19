
include:
  - os.nova

/etc/init/nova-api.conf:
  file:
    - managed
    - source: salt://os/nova/etc/nova-api.upstart

/etc/init/nova-cert.conf:
  file:
    - managed
    - source: salt://os/nova/etc/nova-cert.upstart

/etc/init/nova-consoleauth.conf:
  file:
    - managed
    - source: salt://os/nova/etc/nova-consoleauth.upstart

/etc/init/nova-scheduler.conf:
  file:
    - managed
    - source: salt://os/nova/etc/nova-scheduler.upstart

/etc/init/nova-conductor.conf:
  file:
    - managed
    - source: salt://os/nova/etc/nova-conductor.upstart

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
