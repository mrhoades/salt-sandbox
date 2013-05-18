base:
  '*':
    - base
  os-controller:
    - os.mysql
    - os.keystone
    - os.glance
  'os-compute-*':
    - os.nova
