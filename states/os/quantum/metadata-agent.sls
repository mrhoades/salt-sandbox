
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

