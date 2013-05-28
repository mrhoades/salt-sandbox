base:
  '*':
    - base
    - users
  os-controller:
    - os.mysql
    - os.keystone
    - os.glance
    - os.nova.stateless
    - os.rabbit
    - os.quantum.service
    - os.client
    - os.horizon
  os-network:
    - os.quantum.networking
    - os.quantum.openvswitch-agent
#    - os.quantum.l3-agent
    - os.quantum.dhcp-agent
#    - os.quantum.metadata-agent
  'os-compute-*':
    - os.quantum.networking
    - os.nova.compute
    - os.quantum.openvswitch-agent
