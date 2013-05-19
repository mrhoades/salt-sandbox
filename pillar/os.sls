
secrets:
  admin_token: foobar
  admin_password: kilgore
  demo_password: phooey
  service_password: blarg
  db_password: CHANGE_ME
  rabbit_password: guest

endpoints:
  db: 127.0.0.1
  nova: 127.0.0.1
  glance: 127.0.0.1
  quantum: 127.0.0.1
  keystone: 127.0.0.1
  rabbit: 127.0.0.1

nova:
  libvirt_type: qemu
  compute_driver: nova.virt.libvirt.LibvirtDriver
