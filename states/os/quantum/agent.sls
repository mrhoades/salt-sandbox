
include:
  - os.quantum

/etc/init/quantum-openvswitch-agent.conf:
  file:
    - managed
    - source: salt://os/quantum/etc/quantum-openvswitch-agent.upstart

quantum-openvswitch-service:
  service:
    - name: quantum-openvswitch-agent
    - running
