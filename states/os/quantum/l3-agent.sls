
include:
  - os.quantum

/etc/init/quantum-l3-agent.conf:
  file:
    - managed
    - source: salt://os/quantum/etc/quantum-l3-agent.upstart

quantum-l3-agent-service:
  service:
    - name: quantum-l3-agent
    - running

