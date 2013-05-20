
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

glance:
  default_images:
    cirros: "https://launchpad.net/cirros/trunk/0.3.0/+download/cirros-0.3.0-x86_64-disk.img"
    quantal: "http://cloud-images.ubuntu.com/quantal/current/quantal-server-cloudimg-amd64-disk1.img"

network:
  interfaces:
    control: TODO - needed by quantum
