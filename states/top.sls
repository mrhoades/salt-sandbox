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
  os-network:
    - os.quantum.networking
  'os-compute-*':
    - os.nova.compute
    - os.quantum.networking
    - os.quantum.agent
