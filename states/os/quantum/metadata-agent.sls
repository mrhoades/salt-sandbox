
include:
  - os.quantum

/etc/init/quantum-metadata-agent.conf:
  file:
    - managed
    - source: salt://os/quantum/etc/quantum-metadata-agent.upstart
    - template: jinja

quantum-metadata-agent-service:
  service:
    - name: quantum-metadata-agent
    - running

/etc/init/quantum-ns-metadata-proxy.conf:
  file:
    - managed
    - source: salt://os/quantum/etc/quantum-ns-metadata-proxy.upstart
    - template: jinja

quantum-ns-metadata-proxy-service:
  service:
    - name: quantum-ns-metadata-proxy
    - running

