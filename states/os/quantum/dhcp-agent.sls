
include:
  - os.quantum

/etc/init/quantum-dhcp-agent.conf:
  file:
    - managed
    - source: salt://os/quantum/etc/quantum-dhcp-agent.upstart

quantum-dhcp-agent-service:
  service:
    - name: quantum-dhcp-agent
    - running

