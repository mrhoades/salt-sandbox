service_password: blarg
admin_token: foobar

endpoints:
  db: 127.0.0.1
  nova: 127.0.0.1
  glance: 127.0.0.1
  quantum: 127.0.0.1
  keystone: 127.0.0.1
  rabbit: 127.0.0.1
admin_token: foobar

db:
  password: CHANGE_ME

rabbit:
  host: 127.0.0.1
  password: guest

nova:
  libvirt_type: qemu
  compute_driver: nova.virt.libvirt.LibvirtDriver
