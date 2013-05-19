base:
  '*':
    - base
    - users
  os-controller:
    - os.mysql
    - os.keystone
    - os.glance
    - os.nova
    - os.client
  'os-compute-*':
    - os.nova
