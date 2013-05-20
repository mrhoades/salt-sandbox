
include:
  - os.quantum

/etc/init/quantum-server.conf:
  file:
    - managed
    - source: salt://os/quantum/etc/quantum-server.upstart

quantum-service:
  service:
    - name: quantum-server
    - running
    - watch:
      - file: /etc/quantum/quantum.conf
