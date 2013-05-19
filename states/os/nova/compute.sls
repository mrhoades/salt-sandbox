
include:
  - os.nova

/etc/init/nova-compute.conf
  file:
    - managed
    - source: salt://os/nova/etc/nova-compute.upstart

nova-compute-service:
  service:
    - name: nova-compute
    - running
    - watch:
      - file: /etc/nova/nova.conf
