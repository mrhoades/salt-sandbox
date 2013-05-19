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
    - os.client
  'os-compute-*':
    - os.nova.compute
